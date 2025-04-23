
#For ansible , pre-requisite is Python 3.11
Latest ansible version is 11.3
sudo dnf list |grep ansible

yum is the package manager tll RHEL8
dnf is the package manager for RHEL9

# To Install Ansible (Install only on Controller machine) -
sudo pip3.11 install ansible
ansible --version

#What is inventory?
 Inventory is a file that has the list of all the VM IP'sthat needs to be managed by  ansible
 all is the default group on this file that includes every thing on the file.
 
 # Running ansible commands manually
 ansible -i inventoryFilename all -e ansible_user=ec2-user -e ansible_password=DevOps321

 Ansible is all about modules (from version 2.8, referred as collection)
