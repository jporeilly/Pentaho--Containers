## <font color='red'>Infrastructure Pre-requisites</font>
The following pre-requiste steps have been completed and are listed just for Lab reference. 

This reference section covers:
  * Setup SkyTap Lab environment. 
     
  * Setup of LDOS 1.2.0 Master / Worker Nodes.  
  * Setup of LDOS 1.2.0 Installer.
  * Setup of HAProxy 2.4
  * Setup of Pentaho Server 9.2

  * Generate SSH keys & deploy

#### Downloads
All files required for installation are available in the release folder and can be found in the link below.  
https://hcpanywhere.hitachivantara.com/a/PWPVYtZj1UovY9VO/e52a0db2-ad14-4673-941b-c304c2b108b2?l

<font color='green'>The required packages have been downloaded.</font>  

---

### <font color='red'>Skytap Lab</font>  

The SkyTap Lab environment is configured with: 

SkyTap DNS: 10.0.0.254 - This is automatically assigned.  
Domain Name: skytap.example  

| Server Name               | Host              |  IP address | OS               |
| ------------------------- | ------------------| ----------- | ---------------- |
| HAProxy                   | pentaho-server-1  | 10.0.0.1    | Unbuntu 18.04.4  |
| LDOS 1.2.0 Master Node 1  | k8s-master-node-1 | 10.0.0.101  | CentOS 7.5       |    
| LDOS 1.2.0 Master Node 2  | k8s-master-node-2 | 10.0.0.102  | CentOS 7.5       |
| LDOS 1.2.0 Master Node 3  | k8s-master-node-3 | 10.0.0.103  | CentOS 7.5       |
| Ansible Controller        | installer         | 10.0.0.99   | Unbuntu 18.04.6  | 
|

VM sequence: 
* LDOS Master 1-3 
* HAProxy 
* Ansible Controller 

![SkyTap Lab](../assets/skytap_lab.png)

---

### <font color='red'>LDOS 1.2.0 Master / Worker Nodes</font>  

These servers were deployed as CentOS 7.5 Firstboot images.
Each of the nodes in the cluster has been configured with a 'k8s' user with sudo priviliges.

<font color='green'>The Master and Worker Nodes have been configured with the required user.</font>  

``update all nodes:``
```
sudo yum check-update
sudo yum clean all
sudo reboot
sudo yum update
```

---

<em>add a 'k8s' user to the wheel group (log in as root):</em>  
The k8s account has previously been created. 

``add k8s to wheel group:``
```
sudo -i
usermod -aG wheel k8s
```
``check the assigned groups:``
```
groups
```
``or for the ids:``
```
id k8s
```
``check 'k8s' user on any master node:``
```
ls /home
```

---

<em>install nano:</em>  
Nano is a text editor.

``install editor (nano or vim):``
```
sudo yum install -y nano
```

---

<em>allow users in group wheel to run all commands without password:</em>  

``edit sudoers:``
```
sudo nano /etc/sudoers  
```
```
## Allows users in group wheel to run all commands
%wheel  ALL=(ALL)     ALL

## Without password
%wheel  ALL=(ALL)     NOPASSWD:  ALL
```
``save:``
```
Ctrl +o
enter
Ctrl + x
```

---

### <font color='red'>LDOS 1.2.0 Ansible Controller</font>  

This server has been configured with an 'installer' user with sudo privileges. 

<font color='green'>The Ansible Controller has been installed and configured.</font>  

``update (log in as root):``
```
sudo -i
apt update -y
apt upgrade -y
```
``add an 'installer' user:``
```
adduser installer
```
Note: password is 'lumada'  

``add 'installer' to sudo group:``
```
sudo usermod -aG sudo installer
```
``check the assigned groups:``
```
groups
```
``or for the ids:``
```
id installer
```
``check 'installer' user:``
```
ls /home
```

---

<em>allow users in group sudo to run all commands without password:</em>  

``edit sudoers:``
```
sudo nano /etc/sudoers
```
```
## Allows users in group admin to gain root privileges
%admin  ALL=(ALL)    ALL
%sudo   ALL=(ALL)    ALL  

## Without password
%sudo  ALL=(ALL)     NOPASSWD:  ALL
```
``save:``
```
Ctrl +o
enter
Ctrl + x
```
``reboot and check user:``
```
sudo reboot
sudo -v
```

---

### <font color='red'>Other Required Packages on Ansible Controller</font>  

Enusre that the following packages are also installed and configured:
* openssh server
* pip & pip3
* git
* visual studio code - just for training purposes
* tree - visualize directories

<font color='green'>The packages have been installed and configured.</font>  

---

<em>install openssh server:</em>  
``ssh client should already be installed:``
```
ssh -V
```
Note: you are currently only able to connect as a client to SSH servers
```
sudo apt install openssh-server 
```
``verify service is running:``
```
sudo systemctl status sshd
```
Note: By default, your SSH server is listening on port 22.  
`if you need further details:`
```
sudo apt-get install net-tools
netstat -tulpn | grep 22^
```
If you are using UFW as a default firewall on your Ubuntu 18.04 host, it is likely that you need to allow SSH connections on your host:
```
sudo ufw status
```
Note: For training purposes it is inactive.  
``to enable SSH connections on your host:``
```
sudo ufw allow ssh
```

---

<em>install pip3 & pip:</em>

``ensure python is installed:``
```
sudo apt install python3-pip
```
``verify pip3 installation:``
```
pip3 --version
```
``enable the universe repository for pip:``
```
sudo add-apt-repository universe
```
``install python2:``
```
sudo apt update
sudo apt install python2
```
``use curl to download the get-pip.py script:``
```
sudo apt install curl
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
```
``install pip for Python 2:``
```
sudo python2 get-pip.py
```
``verify pip2 installation:``
```
pip2 --version
```

---

<em>install git:</em>    
used to access the LDOS-Workshop Git repository.  

``install Git:``
```
sudo apt install git
```
``verify the installation:``
```
git --version
```

---

<em>install Visual Studio Code:</em> 

``Visual Studio Code is used for workshop Lab Guide:``
```
sudo apt install snapd
sudo snap install --classic code
```
Note: Whenever a new version is released, Visual Studio Code package will be automatically updated in the background.
to use VSC:
```
cd
code
```

---

<em>install tree:</em> 

``to browse directories:``
```
sudo apt-get update -y
sudo apt-get install -y tree
reboot
```

---

#### <font color='red'>SSH Keys</font>  

Generate the required SSH keys to connect to LDOS nodes.  
You will need the IPs of the Cluster Nodes - refer to table above.

<font color='green'>The SSH keys have been generated and copied to all Nodes.</font>  

``generate ssh key:``
```
cd
ssh-keygen -t rsa
```
Note: keys are located in .ssh directory. 2 keys: id_rsa (private) id_rsa.pub (public)

``copy over key to k8s user on LDOS nodes:``
```
ssh-copy-id k8s@10.0.0.101
ssh-copy-id k8s@10.0.0.102
ssh-copy-id k8s@10.0.0.103
```
Password: lumada
Note: this will copy over both the private and public keys.


``test passwordless ssh connection:``
```
ssh -i ~/.ssh/id_rsa  k8s@10.0.0.101
exit
```

---

#### <font color='red'>Docker Registry Volume</font>  

Installation of the Foundry Platform and LDOS requires that the images are uploaded to a Regsitry to maintain versioning.   
In this workshop a locally, self-certified Docker Registry will be created on ``/installers`` volume. 

---

#### <font color='red'>HA-Proxy - Pentaho Server 9.2</font>  

This server has been configured with an 'pentaho' user with sudo privileges.  

<font color='green'>Pentaho server has been installed and configured.</font>  

``update (log in as root):``
```
apt update -y
```
``add an 'pentaho' user:``
```
adduser pentaho
```
Note: password is 'lumada'  

``add 'pentaho' to sudo group:``
```
sudo usermod -aG sudo pentaho
```
``check the assigned groups:``
```
groups
```
``or for the ids:``
```
id pentaho
```
``check 'pentaho' user:``
```
ls /home
```

---

<em>allow users in group sudo to run all commands without password:</em> 

``edit sudoers:``
```
sudo nano /etc/sudoers
## Allows users in group admin to gain root privileges
%admin  ALL=(ALL)    ALL
%sudo   ALL=(ALL)     ALL  

## Without password
%sudo  ALL=(ALL)     NOPASSWD:  ALL
```
``save:``
```
Ctrl +o
enter
Ctrl + x
```
``reboot and check user:``
```
sudo reboot
sudo -v
```

---

#### <font color='red'>HA Proxy</font>  

Install the latest HAProxy using a PPA.

  > browse to: https://haproxy.debian.net/

 Note: use the wizard to generate commands.

<font color='green'>HA Proxy server has been installed and configured.</font>

``enable PPA (log in as root):``
```
 apt-get install --no-install-recommends software-properties-common
 add-apt-repository ppa:vbernat/haproxy-2.5
```
``then install:``
```
apt-get install haproxy=2.5.\*
```
``verify installation:``
```
haproxy -v
```
``update and upgrade:``
```
sudo apt update && sudo apt upgrade -y
```

---

<em>Configure HAProxy</em>  
HAProxy is an open-source High availability proxy and load balancer that is popularly known for its efficiency and speed. Works for TCP and HTTP protocols, it is used to enhance the performance of a website by splitting up the load across multiple servers and to simplify the request processing tasks. 

Configure HAProxy to load-balance across the cluster.

the configuration file is located at:  
  /etc/haproxy/haproxy.cfg

Details can be found at:   
  > browse to: https://www.haproxy.com/documentation/hapee/latest/configuration/config-sections/defaults/


``rename the existing /etc/haproxy/haproxy.cfg to haproxy.cfg.bak:``
```
cd /etc/haproxy
sudo mv haproxy.cfg  haproxy.cfg.bak
```
``copy over 01-Infrastructure/01-Environment/haproxy.cfg to /etc/haproxy:``
```
cd /installers/LDOS-Workshop/

```
``restart haproxy:``
```
sudo systemctl restart haproxy
```
``test the installation:``

   > browse to:  http://localhost:8000/haproxy?stats

---

#### <font color='red'>Data Volume</font>  

You will require a /data volume which gets mapped to LDOS, as a Pentaho File Repository.
NFS server has already been installed.

---