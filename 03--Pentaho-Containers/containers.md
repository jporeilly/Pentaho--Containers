## <font color='red'>Pentaho 9.3 - Containers</font>  

The following pre-requisites configure the Pentaho Server and Data Integration 9.3.

Prerequisites for DockMaker:
* Docker
* A Docker Hub user account - pull required database images
* CURL command on host
* Pentaho EE license - PENTAHO_INSTALLED_LICENSE_PATH=/data/licenses/.installedLicenses.xml
* Java 8 or 11


---

<em>Install DockMaker</em>  

Dock Maker 1.0 is a command line tool used to create containers for Pentaho products:
* Pentaho Server
* Carte server
* Pentaho Data Integration

<font color='teal'>DockMaker has been downloaded and copied to ~/dockmaker-9.3.0.0</font>

Install the package by completing these steps.

``run the install script:``
```
cd dock-maker-9.3.0.0
./install.sh
```
Note: a console window will appear.
``accept license:``

``edit the installation path:``
```
/home/pentaho/dock-maker-9.3.0.0-422-public
```
Note: The Installation Progress window appears. Progress bars indicate the status of the installation. When the 
installation progress is complete, click Quit to exit the Unpack Wizard.

---

<em>Pentaho EE License</em>  
Set the PENTAHO_INSTALLED_LICENSE_PATH variable so that when you start Pentaho, the licenses can install.  

<font color='red'>If you do not set the variables, Pentaho will not start correctly.</font>

``open a terminal window and log in as root:``
```
sudo -i
```
``edit /etc/environment file:``
```
cd /etc/environment
nano  /etc/environment
```
``add the following:``
```
export PENTAHO_INSTALLED_LICENSE_PATH=/data/licenses/.installedLicenses.xml
```
Note: You will need to log out and back in to set the variable. 

``verify that the PENTAHO_INSTALLED_LICENSE_PATH variable is set:``
```
env | grep PENTAHO_INSTALLED_LICENSE_PATH
```

---