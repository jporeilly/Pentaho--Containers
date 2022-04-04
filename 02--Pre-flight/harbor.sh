#!/bin/bash

# ==============================================================
# Harbor on Ubuntu 20.04
# Edit your /etc/hosts file to resolve IP and FQDN. 
# Pre-requisite steps: disable swap
#                      disable firewall (demo only)
# Pre-requistes steps for Docker: 
#                      apt-transport-https
#                      ca-certificates 
#                      curl 
#                      gnupg-agent 
#                      software-properties-common
# Install Docker. 
# Install Docker Compose
# Install Harbor with Chartmuseum. Comment out HTTPS section.
# 02/04/2022
# ==============================================================

#Prompt for the user to ask if the install should use the IP Address or Fully Qualified Domain Name of the Harbor Server
PS3='Would you like to install Harbor based on IP or FQDN? '
select option in IP FQDN
do
    case $option in
        IP)
            IPorFQDN=$(hostname -I|cut -d" " -f 1)
            break;;
        FQDN)
            IPorFQDN=$(hostname -f)
            break;;
     esac
done

# Infrastructure
apt update -y
swapoff --all
sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
ufw disable #Do Not Do This In Production
echo "Infrastructure update completed .."

#Install Latest Stable Docker Release
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io
tee /etc/docker/daemon.json >/dev/null <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "insecure-registries" : ["$IPorFQDN:443","$IPorFQDN:80","0.0.0.0/0"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
mkdir -p /etc/systemd/system/docker.service.d
groupadd docker
MAINUSER=$(logname)
usermod -aG docker $MAINUSER
systemctl daemon-reload
systemctl restart docker
echo "Docker Installation complete"

#Install Latest Stable Docker Compose Release
COMPOSEVERSION=$(curl -s https://github.com/docker/compose/releases/latest/download 2>&1 | grep -Po [0-9]+\.[0-9]+\.[0-9]+)
curl -L "https://github.com/docker/compose/releases/download/v$COMPOSEVERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "Docker Compose Installation completed .."

#Install Latest Stable Harbor Release
HARBORVERSION=$(curl -s https://github.com/goharbor/harbor/releases/latest/download 2>&1 | grep -Po [0-9]+\.[0-9]+\.[0-9]+)
curl -s https://api.github.com/repos/goharbor/harbor/releases/latest | grep browser_download_url | grep online | cut -d '"' -f 4 | wget -qi -
tar xvf harbor-online-installer-v$HARBORVERSION.tgz

cd harbor
cp harbor.yml.tmpl harbor.yml
# comment out https
sed -i "s/reg.mydomain.com/$IPorFQDN/g" harbor.yml
sed -e '/port: 443$/ s/^#*/#/' -i harbor.yml
sed -e '/https:$/ s/^#*/#/' -i harbor.yml
sed -e '/\/your\/certificate\/path$/ s/^#*/#/' -i harbor.yml
sed -e '/\/your\/private\/key\/path$/ s/^#*/#/' -i harbor.yml

mkdir /var/log/harbor
./install.sh --with-chartmuseum
echo -e "Harbor Installation Completed \n\nPlease log out and log in or run the command 'newgrp docker' to use Docker without sudo\n\nLogin to your harbor instance:\n docker login -u admin -p Harbor12345 $IPorFQDN"