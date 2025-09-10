
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
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.shell -a uptime
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.ping
 
 Ansible is all about modules (from version 2.8, referred as collection)
 collections means modules only

Ansible Playbook = Ansible Scripts


In our case we need to install the nginx, start the service & download the packages.

 ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 ansible.builtin.package nginx
 ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 ansible.builtin.systemd_service nginx
 ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 ansible.builtin.get_url http://xtz/a 
 

YAML is all about : 
    * Dictionary : A key with single vlaue 
                a: 10
    * List : A key with multiple values (If anythign starts with - hypen then its List)
                course: 
                  - python
                  - java
                  - nodejs
    * Map : 

In Ansible, what is Playbook ?
 1. A playbook is nothing but a list of plays
 2. A play is nothing but a list of tasks
 3. A task is nothing but a list of actions 

PLAYBOOK>>PLAY>>TASK>>ACTIONS

 ### How to run an ansible playbook?
 ansible -playbook -i inv -e ansible_user=ec2-user -e ansible_password=DevOps321 playBookname.yml


## Variable Precednce in variable
localvariables >> play variable

When you supply Command Line Variables have higher precednce than play & local variables.
ex -  
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -e URL=cli.google.com PlayBookfile.yaml


# In Ansible flow doesnt matter like in Bash top to bottom approach 
In ansible it acts whole unit for each task, if you give variable before module or after module doesnt matter.

In Ansible, If you attempt to use a variable which is not declared, then it returns as error.



# How to Gather facts of the nodes mentioned on the invemtory -

Gathering facts refers to the automatic collection of system information/properties (also known as facts) from the managed nodes (hosts) before running any tasks. This is handled by the setup module,(ansible.builtin.setup:)

Types of facts gathers - OS details, Network interfaces, Memoory & CPU info, Disk & mounts etc

By default gather_facts is yes in all playbooks, if you dont want to gather_facts then mention as no.
 ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts





# Run Below command to get plain pass into encrypted pass
ansible-vault encrypt_string password


# Ansible Roles 



roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""