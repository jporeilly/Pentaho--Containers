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
apt-get install docker-compose
```
``edit the env.properties file and enter the following values:``
```
installer_node_hostname=installer.skytap.example
installer_node_ip=10.0.0.99
cluster_node_hostname=pentaho-server-1.skytap.example
cluster_node_ip=10.0.0.1
pem_file_name=id_rsa
ansible_user=k8s
```
``to define the extra-vars.yml, execute:``
```
./apply_env_properties.sh
```
Note: You may have to change the permission: sudo chmod +ax apply_env_properties.sh  

``check extra-vars.yml``

---

<em>Run the playbook - download_kubespray.yml</em>   
Kubernetes clusters can be created using various automation tools. Kubespray is a composition of Ansible playbooks, inventory, provisioning tools, and domain knowledge for generic OS/Kubernetes clusters configuration management tasks. 

Kubespray provides:
* a highly available cluster
* composable attributes
* support for most popular Linux distributions

``run the download_kubespray.yml playbook:``
```
cd /etc/ansible/playbooks
ansible-playbook -i hosts-skytap.yml --extra-vars="@extra-vars.yml" -b -v download_kubespray.yml
```
Note: check that the hosts-skytap.yml & extra-vars.yml have been copied.

There is a sample inventory in the inventory folder. You need to copy that and name your whole cluster (e.g. mycluster). The repository has already provided you the inventory builder to update the Ansible inventory file.  

``copy inventory/sample as inventory/mycluster:``
```
cd /installers/kubespray-release-2.14/inventory
sudo mkdir mycluster
cd ..
sudo chown -R installer mycluster
sudo cp -rfp sample mycluster
declare -a IPS=(10.0.0.101 10.0.0.102 10.0.0.103)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```
``check inventory/mycluster/hosts.yaml``

---