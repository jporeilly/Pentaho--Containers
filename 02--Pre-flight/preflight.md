## <font color='red'>Preflight - Hardware & Utils</font>  

The following pre-requisites configure the Pentaho Server and Data Integration 9.3 cluster nodes and installs k8s-1.18.10 using kubespray-2.14.

Prerequisites for the Pentaho Server 9.3 machine:
* Docker 
* Docker Compose
* Harbor

Prerequisites for the Pentaho Data Integration 9.3 machine:

---

<em>Install Docker.io</em>  
Since Harbor will be deployed as docker containers, Docker needs to be first installed.

``remove any previous Docker files:``
```
sudo apt-get remove docker docker-engine docker.io
```
``check system is up-to-date:``
```
sudo apt-get update
```
``install Docker:``
```
 sudo apt install docker.io
```
``install all the dependency packages:``
```
sudo snap install docker
```
``check the version installed:``
```
docker --version
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
```
sudo docker ps
```


---

<em>Install Docker Compose</em>   
Docker Compose is a command-line tool for managing multiple Docker containers. It is a tool for building isolated containers through the YAML file to modify your application’s services.

<font color='teal'>Docker-compose has already been installed and configured.</font>

``install docker-compose:``
```
sudo apt-get install docker-compose
```
``check the version installed:``
```
docker-compose --version
```
Note: This option will not guarantee that you downloading the latest docker-compose version.

On the GitHub repository, you will get the updates of Docker Compose, which might not be available on the standard Ubuntu repository. At the time of this writing this workshop, the most current stable version is 2.4.0.

``download latest:``
```
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
sudo mkdir -p $DOCKER_CONFIG/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
```
Note: saves the file in: ~/.docker/cli-plugins directory, under the name docker-compose.  

``change the file permission:``
```
sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
reboot
```
``verify the installed version:``
```
docker compose --version
```

---

<em>Install Harbor</em>   
Harbor is an open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted.  

Harbor, a CNCF Graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud native compute platforms like Kubernetes and Docker. At the time of this writing this workshop, the most current stable version is 2.4..

  > For further details: https://goharbor.io/

<font color='teal'>Harbor has already been installed and configured.</font>

``download Harbor:``
```
sudo wget https://github.com/goharbor/harbor/releases/download/v2.4.1/harbor-offline-installer-v2.4.2.tgz
```
``extract Harbor:``
```
sudo tar -xvzf harbor-offline-installer-v2.4.1.tgz
```
``configure Harbor:``
```
cd harbor
ls
```
``copy harbor.yml.tmpl harbor.yml:``
```
sudo cp harbor.yml.tmpl harbor.yml
```
``edit the harbor.yml:``
```
sudo nano harbor.yml
```
Note: the configuration is fine for demo environments. For production it is highly recommended to generate a SSL certificate and key.