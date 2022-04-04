## <font color='red'>Preflight - Hardware & Utils</font>  

The following pre-requisites configure the Pentaho Server and Data Integration 9.3.

Prerequisites for the Pentaho Server 9.3 machine:
* Docker 
* Docker Compose
* Harbor

Prerequisites for the Pentaho Data Integration 9.3 machine:



---

<em>Install Harbor</em>  

<<<<<<< HEAD
``remove any previous Docker files:``
```
sudo apt-get remove docker docker-engine docker.io
```
``check system is up-to-date:``
```
sudo apt-get update
```
``install pre-requisites:``
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
``add the GPG key for the official Docker repository:``
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
``add Docker to APT repositories:``
```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```
``check repo:``
```
apt-cache policy docker-ce
```
``install Docker:``
```
 sudo apt install docker-ce
```
``check status:``
```
sudo systemctl status docker
```
``check the version installed:``
```
docker --version
```
``create a Docker group:``
```
sudo groupadd docker
```
``add user:``
```
sudo usermod -aG docker ${USER}
```
``test pull image:``
```
sudo docker run hello-world
```
``check image has been pulled:``
```
sudo docker images
```
``check containers:``
=======
The Harbor community has provided a script that with a single command prepares an Ubuntu 20.04 machine for Harbor and deploys the latest stable version.  
This script installs Harbor with an HTTP connection, Clair, and the Chart Repository Service. It does not install Notary, which requires HTTPS.  

``run the script:``
>>>>>>> bfc49201977b694c5ea66b9f38c6a6896b42f7b3
```
sudo ./harbor.sh
```
Select whether to deploy Harbor using the IP address or FQDN of the host machine.

This is the address at which you access the Harbor interface and the registry service.

To use the IP address, enter 1.  
To use the FQDN, enter 2.  

``enter option 2``  
When the script reports Harbor Installation Complete, log in to your new Harbor instance.

  > browse to: http://harbor.skytap.example

User name: admin  
Password: Harbor12345  

After deployment, you can enable HTTPS and Notary by reconfiguring the installation. 

  > for further details: https://goharbor.io/docs/2.0.0/install-config/configure-https/

--- 

<em>Push & Pull Images to/from Harbor</em>

Once logged in, you should be able to create new projects, pull and push images into Harbor. 

``log in to Harbor with CLI:``
```
cd harbor
docker login harbor.skytap.example
Username: admin
Password: Harbor12345
```
Harbor optionally supports HTTP connections, however the Docker client always attempts to connect to registries by first using HTTPS. If Harbor is configured for HTTP, you must configure your Docker client so that it can connect to insecure registries. In your Docker client is not configured for insecure registries, you will see the following error when you attempt to pull or push images to Harbor:  

```Error response from daemon: Get https://myregistrydomain.com/v1/users/: dial tcp myregistrydomain.com:443 getsockopt: connection refused.```


``create a new project:``
```
in the UI create a project called 'busybox`
```
``pull the image:``
```
docker pull busybox
```
``list the images:``
```
docker images
```
``hello world in container:``
```
docker run busybox echo "hello from busybox"
```
``push to harbor:``
```

```

---

<em>Configure HTTPS connection</em>

<font color='teal'>This section is for reference only.</font>

In a production environment, you should obtain a certificate from a CA. In a test or development environment, you can generate your own CA. To generate a CA certficate, run the following commands.

<<<<<<< HEAD
``download Harbor:``
```
sudo wget https://github.com/goharbor/harbor/releases/download/v2.4.2/harbor-offline-installer-v2.4.2.tgz
```
``extract Harbor:``
```
sudo tar -xvzf harbor-offline-installer-v2.4.2.tgz
=======
``generate a CA certificate private key:``
```
openssl genrsa -out ca.key 4096
>>>>>>> bfc49201977b694c5ea66b9f38c6a6896b42f7b3
```
``enter cert details:``
```
#Syntax to generate cert and key: 
openssl req \
    -newkey rsa:4096 -nodes -sha256 -keyout domain.key \
    -x509 -days 365 -out domain.crt \
    -subj "/CN=localhost/C=<Country>/ST=<State>/L=<Location>/O=<Organization>"
```
```
openssl req -newkey rsa:4096 -nodes -sha256 -keyout harbor.skytap.example.key -x509 -days 365 -out harbor.skytap.example.crt -subj "/CN=harbor.skytap.example/C=UK/ST=London/L=London/O=HitachiVantara"
```
``configure the Harbor Installer - harbor.yml:``
hostname — set this to either the IP address or the domain of your hosting server.
harbor_admin_password — set this to a strong, unique password.

``edit the paths of the keys to reflect as shown in below example:``
```
hostname: harbor.skytap.example
# http related config
http:
# port for http, default is 80. If https enabled, this port will redirect to https port
port: 80
# https related config
https:
# https port for harbor, default is 443
port: 443
# The path of cert and key files for nginx
certificate: /etc/ssl/harbor.skytap.example.crt
private_key: /etc/ssl/harbor.skytap.example.key
```
<<<<<<< HEAD
Note: the configuration is fine for demo environments. For production it is highly recommended to generate a SSL certificate and key.
* locally setup FQDN harbor.example.com to access admin UI
* update /etc/hosts with 10.0.0.101   harbor.skytap.example
* comment out SSL

``install harbor:``
```
./install.sh
```
Note: the script will perform a bunch of checks
=======


---
>>>>>>> bfc49201977b694c5ea66b9f38c6a6896b42f7b3
