
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

# Ansible Tower - GUI for Ansible & it has feature of getting the inventory dynamically.



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





# Ansible Vault
Vault helps you in encrypting the string & supplying in a format thats not plain text.
Ansible does not support defining !vault values directly inside playbooks this way. Vault-encrypted values are meant to be stored in separate variable files, not inline in the playbook YAML.

Run Below command to get plain password intfrom encrypted pass
$ ansible-vault encrypt_string <password>



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


# Copy vs Template module
1. Copy module just copy-paste from local to remote machine (you cannnot parameterize the file).
2. Of you use template collection, you can use it for copy-paste & parameterized files.


# Regarding Roles & Calling a role -
1. When you call a specific role, tasks mentioned in the main.yml will be executed.
2. We can also define a task in another file tasks/anything.yml & can import the task that are available in anything.yml

# what is Role Dependency in Ansible ?
1. This helps in making one particualr task as pre-requisite

For example, Running a Backend first without making Mysql operation doesnt work.
So we can define role dependency for BACKEND as MySQL, that means you wish to run backend, MySQL will be executed first.

It is mentioned here on common/mian.yml & this needs to be called in backend/meta/main.yml file, so that automatically it will be executed first.


## Running Playbook using PUSH Mechanism


ansible-playbook -i inv-dev -e ansible_username=ec2-user -e ansible_password=DevOps321 -e COMPONENT=frontend -e ENV=dev expense.yml

OR

ansible-playbook -i frontend-dev.expense.internal -e ansible_username=ec2-user -e ansible_password=DevOps321 -e COMPONENT=frontend -e ENV=dev expense.yml


### Ansible PULL Mechanism

Ansible also works using pull based mechanism, in this case we dont have to maintain the inventory.
But ensure the node that runs this ansible-pull should have ANSIBLE installed.

## When to use PUSH Vs PULL 

Typically its a choice, but generally if the inventory is STATIC, then we designate one of the node as Ansible Controller where we make the deployments from here using PUSH to other nodes.

If the inventory is the DYNAMIC (where Infra scales up & down dynamically) in that case we end up using ANSIBLE_PULL , but the pre-requisite is that the node running ansible-pull should have ansible installed.
Also in ansible-pull, you DONT necessarily to maintain inventory.

you can still maintain inventory file as below -
filename-pull.yml & need to mention localhost for hosts 
hosts: localhost

Also you need to pull the code ONLY from Github & git related products like Git, Gitlab, Bigbucket

COMMAND to run on target node directly - ansible-pull -U <git url repo> -e COMPONENT=frontend -e ENV=dev expense.yml

Where you want to do configuration management on server, run the ansible command there itself as simple as that.


# Ansible Tower-
For all our jobs in Ansible, there is no UI so far.
You can use Ansible Tower for UI, but tower can be useful only for ANsible.

# Available Tools for Deployments- 

1. Jenkins not really menat for purpose of deployments, Its main goal is CI.
2. Go CD - Its a continuous deployment Tool.
3. ArgoCD - Its a exclusively for Kubernetes deployments & dont work for server based deployments.


## 🌀 What is Ansible Galaxy?

Ansible Galaxy is:
A community hub and package repository where Ansible users can share, discover, and reuse automation content like roles, collections, and playbooks.
It's like npm (for Node.js) or PyPI (for Python) — but specifically for Ansible content.


## For Use of Ansible-pull
> You need to have ansible install on target nodes - 
>. Steps to make your own AMI :
1.Use lab image & create instance
2. Install ansible on that node using "pip3.11 install ansible"
3. Create  an AMI using this & name it as "b58-golden-image"
4. Make sure you are the owner , so supply your account id.

## Ansible builtin module Vs Ansible community modules
If you are using the builtin modules you dont need to  install requirements.
If you are using the community modules, you need to check for requirements & install.

# To extract the secrets form Hasicorp Vault for Ansible
vars:
        secrets: "{{ lookup('community.hashi_vault.hashi_vault', 'secret=expense-dev/data/backend', token=token, url='https://vault.devsecopswithshri.site:8200', validate_certs=False) }}"

