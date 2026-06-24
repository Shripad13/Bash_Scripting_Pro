
# For ansible , pre-requisite is Python 3.11
Latest ansible version is 13 with 13.2.0 is the most recent update.
sudo dnf list |grep ansible

Latest Ansible-Core : 2.19.8; 2.18.15

Latest Ansible Stable VErsion released on March 2026 - 2.20.4

yum is the package manager till RHEL8
dnf is the package manager for RHEL9

# To Install Ansible (Install only on Controller machine) -
sudo pip3.11 install ansible
ansible --version

# Python is mandatory to for using Ansible on COntroller Node.
 $ sudo dnf install python3
 $ python3 --version

# What will be the updates in every ansible version releases
Ansible releases two types of updates: Major community packages and ansible-core. Major updates occur roughly every six months to introduce new features and structural changes. Minor/patch updates occur every four weeks to provide bug fixes, minor functionality updates, and new collection versions.


# What is so special in Ansible -
it does automation in a way that’s simple, agentless, and human-readable, which is surprisingly rare in infrastructure tooling.
🧠 1. Agentless architecture - SSH/WinRM
Lower maintenance overhead
Easier onboarding of new servers
Fewer security concerns (no extra daemon running everywhere)

📜 2. Human-readable automation (YAML playbooks)

🔁 3. Idempotency (safe repeated execution)
Ansible is designed so that running the same playbook multiple times:
Does not break systems
Only applies changes if needed
⚙️ 5. Huge built-in ecosystem (modules)
Ansible comes with thousands of modules:

🔄 6. Push-based model (no server required)

Playbooks themselves must be YAML in Ansible.
But Ansible is extensible, and you can use other languages for modules, plugins, scripts, and inventory generation.

# What is inventory?
 Inventory is a file that has the list of all the VM IP'sthat needs to be managed by ansible
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

> Ansible Tower - GUI for Ansible & it has feature of getting the inventory dynamically.
> Ansible Tower provides a Robust Data Logging feature.


 ### How to run an ansible playbook?
ansible-playbook -i inv -e ansible_user=ec2-user -e ansible_password=DevOps321 001-playbook.yml
ansible-playbook -i inv -e ansible_user=ec2-user -e ansible_password=DevOps321 001-playbook.yml

## Variable Precednce in variable
local variables >> play variable

When you supply Command Line Variables have higher precednce than play & local variables.
ex -  
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -e URL=cli.google.com PlayBookfile.yaml


# In Ansible flow doesnt matter like in Bash top to bottom approach 
In ansible it acts whole unit for each task, if you give variable before module or after module doesnt matter.

In Ansible, If you attempt to use a variable which is not declared, then it returns as error.

# How to Gather facts of the nodes mentioned on the invemtory -

Gathering facts refers to the automatic collection of system information/properties (also known as facts) from the managed nodes (hosts) before running any tasks. This is handled by the setup module,(*ansible.builtin.setup*:)

Types of facts gathers - OS details, Network interfaces, Memory & CPU info, Disk & mounts etc

Ansible is very rich with collections.

By default gather_facts is yes in all playbooks, if you dont want to gather_facts then mention as no.
Make sure all group is there in inv file.
gather_facts: yes
gather_facts: no

ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts

Also you can search particualr info by using grep
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts|grep "ansible_nodename"

# command to generate the facts of the nodes mentioned in inventory file & redirect the output to some file, becoz it generated huge info of facts
ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts


$ ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts|grep nameservers

$ ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts|grep "ansible_nodename"

 $ ansible -i inv frontend -e ansible_user=ec2-user -e ansible_password=DevOps321  -m ansible.builtin.gather_facts|grep "ansible_kernel"

You can redirect the output to some file, becoz it generated hug info of facts
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=  -m ansible.builtin.gather_facts > ~/op.txt


# use of ansible.builtin.setup - To gather ad-hoc info about system.
ansible -i inv all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ansible.builtin.setup -a "filter=ansible_cmdline"  | grep BOOT_IMAGE

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

For example, Running a Backend first without making Mysql operational doesnt work.
So we can define role dependency for BACKEND as MySQL, that means you wish to run backend, MySQL will be executed first.

It is mentioned here on common/main.yml & this needs to be called in backend/meta/main.yml file, so that automatically it will be executed first.


## Running Playbook using PUSH Mechanism

ansible-playbook -i inv-dev -e ansible_username=ec2-user -e ansible_password=DevOps321 -e COMPONENT=frontend -e ENV=dev expense.yml

OR

ansible-playbook -i frontend-dev.expense.internal -e ansible_username=ec2-user -e ansible_password=DevOps321 -e COMPONENT=frontend -e ENV=dev expense.yml

# How ansible-pull works?
1. This connects to the instance and runs ansible command that connects to the repo & runs the playbook.
2. Make sure the machine you are running has ANsible Installed.
3. Either you can install ansible in the same provisioner or make sure the AMI you are using has ansible installed.
4. Source can only be on Git.
   
   $ ansible-pull -u <git_URL.git> playBookname.yml

# B59-S39 - Session on ansible-pull

### Ansible PULL Mechanism

Ansible also works using pull based mechanism, in this case we dont have to maintain the inventory.
But ensure the node that runs this ansible-pull should have ANSIBLE installed.

> You need to have ansible install on TARGET NODES for using Ansible Pull Mechanism

The ansible-pull mechanism is designed for scale and environments with intermittent connectivity, or where security policies prevent a central control node from initiating connections to managed hosts. 

1. Agentless Execution: ansible-pull does not require a persistent agent running on the managed nodes.
2. Git Integration: managed node uses Git to clone or update a repository containing the Ansible playbooks.
3. Scheduled Tasks: A cron job or scheduler on the managed node runs the ansible-pull command at a regular interval to check for updates.
4. Local Execution: Once the repository is updated locally, the command executes the specified playbook against localhost. The inventory file for the playbook typically lists 127.0.0.1 as the target. 

## When to use PUSH Vs PULL 
1. When you have a case where you dont want to keep a node just for ansible
2. Whenever you r infra is dynamic (that means infra comes out & grows), that time maintaining the infra is a big deal, in that time we will ensure the nodes that are provisioned as ANSIBLE install & we make that node to pull the playBook using the ansible-pull & run the playbook.

Typically its a choice, but generally if the inventory is STATIC, then we designate one of the node as Ansible Controller where we make the deployments from here using PUSH to other nodes.

If the inventory is the DYNAMIC (where Infra scales up & down dynamically) in that case we end up using ANSIBLE_PULL , but the pre-requisite is that the node running ansible-pull should have ansible installed.
Also in ansible-pull, you DONT necessarily to maintain inventory.

you can still maintain inventory file as below -
filename-pull.yml & need to mention localhost for hosts 
hosts: localhost

Also you need to pull the code ONLY from Github & git related products like Git, Gitlab, Bigbucket

COMMAND to run on target node directly - 
  $ ansible-pull -U <git url repo> -d <destination_directory> -e COMPONENT=frontend -e ENV=dev expense.yml

Where you want to do configuration management on server, run the ansible command there itself as simple as that.


⬇️ What if your servers could pull configurations themselves—like how Git works?
Welcome to Ansible Pull, a powerful alternative to the traditional push-based automation model.

🔹 What is Ansible Pull?

Unlike the standard Ansible Push model (where a control node pushes Playbooks to targets), Ansible Pull flips the approach:
Each managed node pulls Playbooks from a Git repository and applies them locally.

It’s ideal for scalable, decentralized environments—especially where SSH access is restricted.

🔹 Why Use Ansible Pull?

✅ Eliminates the need for a central control node
✅ Works behind firewalls and NAT
✅ Scales easily for 100s or 1000s of servers
✅ Automates periodic configuration with cron
✅ Uses Git as a single source of truth

🔹 How Ansible Pull Works-
Ansible Pull is already included with Ansible. On each node, just run:
ansible-pull -U https://lnkd.in/gGs3Nk6V site.yml

You can also automate this using cron for regular config pulls:
(crontab -l ; echo "*/30 * * * * ansible-pull -U https://lnkd.in/gGs3Nk6V site.yml >> /var/log/ansible-pull.log 2>&1") | crontab -
---
🔹 Example Use Case
Imagine bootstrapping 200 cloud VMs. Instead of setting up SSH access to each, you embed ansible-pull in your instance startup script. Each server pulls its config and self-configures—hands-free automation.

> Ansible config file will be on repo of github

🔹 Ansible Pull vs. Ansible Push – Key Differences
1. Control Node Requirement
Push: Needs a centralized controller
Pull: Each node is independent

2. SSH Access
Push: Requires SSH to all hosts
Pull: No SSH needed—nodes pull from Git

3. Scalability
Push: Gets tricky as the environment grows
Pull: Scales naturally—nodes work in parallel

4. Firewall-Friendly
Push: May face network restrictions
Pull: Works behind firewalls with outbound Git access

5. Git Integration
Push: Optional
Pull: Mandatory—Git is the source of configuration

6. Use Case
Push: Great for centralized, ad-hoc, or manual control
Pull: Ideal for cloud-scale, immutable, or air-gapped setups



# Ansible Tower-
For all our jobs in Ansible, there is no UI so far.
You can use Ansible Tower for UI, but tower can be useful only for Ansible.

# Available Tools for Deployments- 
1. Jenkins not really meant for purpose of deployments, Its main goal is CI.
2. Go CD - Its a continuous deployment Tool.
3. ArgoCD - Its a exclusively for Kubernetes deployments & dont work for server based deployments.


## 🌀 What is Ansible Galaxy?
Ansible Galaxy is:
A community hub and package repository where Ansible users can share, discover, and reuse automation content like roles, collections, and playbooks.
It's like npm (for Node.js) or PyPI (for Python) — but specifically for Ansible content.


# Steps to make your own AMI :
1. Use lab image & create instance
2. Install ansible on that node using "pip3.11 install ansible"
3. Create  an AMI using this & name it as "b58-golden-image"
4. Make sure you are the owner, so supply your account id.

## Ansible builtin module Vs Ansible community modules
If you are using the builtin modules you dont need to  install requirements.
If you are using the community modules, you need to check for requirements & install.

# To extract the secrets from Hasicorp Vault for Ansible
vars:
        secrets: "{{ lookup('community.hashi_vault.hashi_vault', 'secret=expense-dev/data/backend', token=token, url='https://vault.devsecopswithshri.site:8200', validate_certs=False) }}"


> Ansible primary configuration file - /etc/ansible/ansible.cfg
> Ansible log - /var/log/ansible.log
> Ansible looks for modules - /usr/share/ansible


# What is the filename where we store all the host ip?
In config file - /etc/ansible/hosts

# How to specify host with port number?
In /etc/ansible/hosts
hostname:port


## Interview Q&A
1. How do you use reusable components in Ansible?
   - By using Ansible Roles, which allow you to organize tasks, variables, files, and templates into reusable units.
2. How do you configure your outlook into Ansible playbook?
   - By using Ansible Mail Module

3. What if Build fail, how to send Failure mail?
 We can register the output in a variable & check for the status of that variable, if its failed then send mail using mail module.
 when: variable_name.rc ==0        It will send success mail
 when: variable_name.rc !=0        It will send Failure mail
 
 ansible galaxy install init role_name      


 DB, Infra, app team
 roles
    DB - main.yml
    Infra - main.yml
    App - main.yml

# handlers in ansible -
Ansible handlers are special tasks that run only when they are explicitly notified by another task in a playbook. They are primarily used to trigger actions in response to a change in the system state caused by a previous task, such as restarting a service after its configuration file has been updated. 

Triggered by notify: A task uses the notify directive to call a handler by its unique name.
By default, handlers run at the end of a play, after all tasks in the tasks section are finished
Use Cases:
Restarting or reloading services (e.g., web servers, databases) after a configuration change.
Triggering a system reboot if a kernel or critical library update requires it.
Performing maintenance tasks like clearing a cache or sending alerts. 

---
- name: Example playbook with handlers
  hosts: webservers
  become: yes
  tasks:
    - name: Ensure the web server configuration file is present
      ansible.builtin.template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify:
        - Restart Nginx

  handlers:
    - name: Restart Nginx
      ansible.builtin.service:
        name: nginx
        state: restarted

---

# What is Idempotent in Ansible?
An action is idempotent if it can be applied multiple times without changing the result beyond the initial application.
Most Ansible modules (e.g., file, package, user) verify if the desired state (e.g., file present, package installed) already exists. If it does, the task does nothing and reports "OK" or "SUCCESS," rather than changing anything.
Non-idempotent Exceptions: Modules like command and shell are not natively idempotent, as they execute commands regardless of the system's state


# Why is Ansible Idempotent?
Consistency & Stability: It ensures the server state is identical to the configuration described in the playbook, eliminating configuration drift.
Safety in Re-execution: Playbooks can be run repeatedly (e.g., during automated CI/CD) without causing errors or breaking existing, correct configurations.
Efficiency: By identifying that a system is already in the desired state, Ansible avoids unnecessary work, saving time and system resources.
Declarative Approach: It allows engineers to define "what" the final state should be, rather than "how" to achieve it.  


# Question 7: How can you configure a rolling update for services using Ansible?
- hosts: webservers 
  serial: 2 
  tasks: 
  - name: Update application 
    command: update_app 

This updates two hosts at a time, ensuring minimal downtime. Combine with 
health checks to validate each host before proceeding. 




# Run Ansible Playbook with verbose - Use -v, -vv, -vvv, -vvvv for increasing levels of verbosity.
 $ ansible-playbook -v playbook.yml



# Using /etc/sudoers (Direct Edit) 
Open the file: Run sudo visudo in your terminal.
Add the entry: Navigate to the end of the file and add a line for your specific user or group:
For a user: username ALL=(ALL) NOPASSWD: ALL.
%sudo ALL=(ALL) NOPASSWD: ALL
root    ALL=(ALL:ALL) ALL

For a group: %groupname ALL=(ALL) NOPASSWD: ALL (commonly used with the %wheel or %sudo groups).


📘 Why playbooks start with -
A playbook is actually a list of “plays”.
Playbook = list of plays
- means “this is a list item”.
Also it’s pure YAML syntax.

1. Dictionary (key-value)
name: Install nginx
hosts: web
2. List (sequence)
- item1
- item2
- item3