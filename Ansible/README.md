
#For ansible , pre-requisite is Python 3.11
Latest ansible version is 11.3
sudo dnf list |grep ansible

yum is the package manager till RHEL8
dnf is the package manager for RHEL9

# To Install Ansible (Install only on Controller machine) -
sudo pip3.11 install ansible
ansible --version

#What is inventory?
 Inventory is a file that has the list of all the VM IP'sthat needs to be managed by  ansible
 all is the default group on this file that includes every thing on the file.
 
 # Running ansible commands manually
timeout 3 telnet <Private IP> 22           # after 3 sec telnet will get break
ping <Private IP>
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.shell -a uptime
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.ping
ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.ping
ansible -i inv backend -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.ping

ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.shell -a "df -kh"

-i means inventory file
-e means environment variable
-m means module
-a means argument
all - means default group in inv file


 Ansible is all about modules (from version 2.8, referred as collection)
 collections means modules only

Ansible Playbook = Ansible Scripts


# In our case we need to install the nginx, start the service & download the packages.
 ** This way is not recommended at all, need to use key-value arguments **

 ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.package -a nginx
 ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.systemd_service nginx
 ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 ansible.builtin.get_url http://xtz/a 
 

# Recommended approach - Go with Playbook
1. Ansible scripts are referred as a Playbook
2. Playbooks are scripted by using YML

YAML is all about : Use either 1 or 2 spaces across YML files

    * Dictionary : A key with single vlaue (key-value pair)
                a: 10
                name: Shripad
                job: Software
                skill: DevOps

    * List : A key with multiple values (If anything starts with - hypen then its List)
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

# IMP Points
One play should not have same name of two tasks
If you attempt to use a variable that is not decalred then particular task accessing the variable will fail.
You can even declare variables in file & defind in playbook.


# Ansible Push Vs Pull 
Push - Use when Infra is Static
Pull - Use when Infra is Dynamic

Ansible Tower - GUI for Ansible & it has feature of getting the inventory dynamically.


 ### How to run an ansible playbook?
ansible-playbook -i inv -e ansible_user=ec2-user -e ansible_password=DevOps321 001-playbook.yml
ansible-playbook -i inv -e ansible_user=ec2-user -e ansible_password=DevOps321 001-playbook.yml

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

Ansible is very rich with collections.

By default gather_facts is yes in all playbooks, if you dont want to gather_facts then mention as no.
Make sure all group is there in inv file.

ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts

Also you can search particualr info by using grep
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts|grep "ansible_nodename"

ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts
$ ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts|grep nameservers

$ ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts|grep "ansible_nodename"

$ ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts|grep "ansible_kernel"

You can redirect the output to some file, becoz it generated hug info of facts
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts > ~/op.txt





# Run Below command to get plain pass into encrypted pass
ansible-vault encrypt_string password

# Problem Statement -
1. If we use playbooks directly, we never have any idea on which file is been used by which playbook.
2. You never know which variable file is used by which playbook.
3. you cannot resuse the code.

This is where Ansible roles comes into play !!

# Ansible Roles 
(Usage of this is close to what use see prod approach)
File name extension should be .yml not a .yaml


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


