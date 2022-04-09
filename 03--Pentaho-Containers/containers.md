## <font color='red'>Pentaho 9.3 - Containers</font>  

The following pre-requisites configure the Pentaho Server and Data Integration 9.3.

Prerequisites for DockMaker 1.0:
* Docker
* A Docker Hub user account - pull required database images
* CURL command on host
* Pentaho EE license - PENTAHO_INSTALLED_LICENSE_PATH=/data/licenses/.installedLicenses.xml
* Java 8 or 11


---

<em>Install DockMaker 1.0</em>  

Dock Maker 9.3 is a command line tool used to create containers for Pentaho products:
* Pentaho Server
* Carte server
* Pentaho Data Integration

<font color='teal'>Dock Maker 9.3 has been downloaded and copied to ~/docker-maker-9.3.0.0</font>

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



