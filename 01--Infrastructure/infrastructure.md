## <font color='red'>Infrastructure Pre-requisites</font>
The following pre-requiste steps have been completed and are listed just for Lab reference. 

This reference section covers:
  * Setup SkyTap Lab environment. 
     
  * Setup of Pentaho Server EE 9.3 Master / Worker Nodes.  
  * Setup of Pentaho Data Integration.


#### Download Packages from Customer Support Portal
All files required for installation are available in the release folder and can be found in the link below.  

  > https://support.pentaho.com/hc/en-us

<font color='teal'>The required packages have been downloaded.</font>
  
* pentaho-server-ee-9.3.0.0-427-dist.zip
* paz-plugin-ee-9.3.0.0-427-dist.zip
* pir-plugin-ee-9.3.0.0-427-dist.zip
* pdd-plugin-ee-9.3.0.0-427-dist.zip

---

### <font color='red'>Skytap Lab</font>  

The SkyTap Lab environment is configured with: 

SkyTap DNS: 10.0.0.254 - This is automatically assigned.  
Domain Name: skytap.example  

| Server Name               | Host              |  IP address | OS               |
| ------------------------- | ------------------| ----------- | ---------------- |
| Data Integration 9.3      | pdi               | 10.0.0.1    | Ubuntu 20.04     |
| Pentaho Server EE 9.3     | harbor            | 10.0.0.101  | Ubuntu 20.04     |    
|

VM sequence: 
* Pentaho Server EE 9.3
* Pentaho Data Integration 9.3 

![SkyTap Lab](.\assets\skytap_lab.png)

---

### <font color='red'>Pentaho Server EE 9.3 Master / Worker Nodes</font>  

These servers were deployed as Ubuntu Desktop 20.04LTS images.
Each of the nodes in the cluster has been configured with a 'pentaho' user with sudo priviliges.

<font color='teal'>Pentaho Server EE 9.3 has been configured.</font>  

``update all servers:``
```
sudo apt-get update -y
sudo apt-get dist-upgrade
sudo reboot
```

---

### <font color='red'>Pentaho Data Integration & Pentaho Server</font>  

This server has been configured with 'pentaho' user with sudo privileges. 

<font color='teal'>Pentaho Data Integration 9.3 has been configured.</font>  

``update (log in as root):``
```
sudo -i
apt update -y
apt upgrade -y
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

### <font color='red'>Other Required Packages on Pentaho Server EE 9.3</font>  

Enusre that the following packages are also installed and configured:
* git
* visual studio code - just for training purposes
* tree - visualize directories

<font color='teal'>The required packages have been installed and configured.</font>  

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