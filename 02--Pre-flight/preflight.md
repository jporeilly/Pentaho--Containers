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