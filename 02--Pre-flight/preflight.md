## <font color='red'>Preflight - Hardware & Utils</font>  

The following pre-requisites configure the Pentaho Server and Data Integration 9.3.

Prerequisites for the Pentaho Server 9.3 machine:
* Docker 
* Docker Compose
* Harbor

Prerequisites for the Pentaho Data Integration 9.3 machine:



---

<em>Install Harbor</em>  
The Harbor community has provided a script that with a single command prepares an Ubuntu 20.04 machine for Harbor and deploys the latest stable version.  
This script installs Harbor with an HTTP connection, Clair, and the Chart Repository Service. It does not install Notary, which requires HTTPS.  

``run the script:``
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
``Error response from daemon: Get https://myregistrydomain.com/v1/users/: dial tcp myregistrydomain.com:443 getsockopt: connection refused.``


# Created a new project named bbanews-test
# Tag an Image:
#Syntax:  docker tag SOURCE_IMAGE[:TAG] registry.captainvirtualization.in/bbabews-test/REPOSITORY[:TAG]
#Ex:
eknath@registry:~/harbor$ sudo docker tag eknath009/nginx-bbanews:latest registry.captainvirtualization.in/bbabews-test/bbanews:latest
#To list the tagged image
docker images
# Push the Image into Harbor registry
#Syntax: docker push registry.captainvirtualization.in/bbabews-test/REPOSITORY[:TAG]
eknath@registry:~/harbor$ sudo docker push registry.captainvirtualization.in/bbabews-test/bbanews:latest