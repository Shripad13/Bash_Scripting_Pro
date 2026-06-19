
## Ansible Modules

ansible.builtin.ping - To check the connectivity of target machine

ansible.builtin.debug - for print a messg, like echo in bash

ansible.builtin.shell - allows you to run shell commands using the system’s shell

ansible.builtin.command - runs the command directly, which is safer and preferred when shell features aren’t needed.

ansible.builtin.package - This modules manages packages on a target without specifying a package manager module
(like ansible.builtin.dnf, ansible.builtin.apt, …)

ansible.builtin.file  - This modules has a capability to update, delete & create a file & directory.

ansible.builtin.service - This modules has a capability to start/stop & restart service, Cross-platform (init systems)
ansible.builtin.service - Want maximum compatibility across distros

ansible.builtin.systemd_service - Need full control on modern Linux (systemd)
ansible.builtin.systemd_service - also daemon reload module, Preferred for systemd distros

ansible.builtin.fetch - This module Fetches files from remote nodes

ansible.builtin.user – This module Manages user accounts

ansible.builtin.stat - conditional check module

ansible all -m setup - To gather ad-hoc info about system.

ansible.buitlin.unarchive - This module unpacks an archive after transferring it to the remote node.

ansible.builtin.git - This module manages git checkouts of repositories.

ansible.builtin.copy - This module copies files to remote locations.

ansible.builtin.template - This module copies a file from the local machine to the remote machine, but it also processes the file as a Jinja2 template, allowing you to dynamically generate content based on variables and conditions.

✅ state: present  #means:"Make sure the package is installed."
If the package is already installed, Ansible does nothing (it's idempotent). If it's not installed, Ansible will install it.
✅state: absent   #Ensure the package is removed/uninstalled.
✅state: latest   #Ensure the latest version of the package is installed.

✅state: started        #Ensures the service is running.
✅enabled: yes          #Configures the service to start automatically on boot.
✅become: yes           #Instructs Ansible to escalate privileges (e.g., using sudo) for executing tasks.
✅remote_src: yes       #Means things will happen to remote servers (manadatory to mention this)

✅daemon_reload: true  # Reload systemd daemon (after unit file changes)

 state: restarted #Restart the service if it is already running, or start it if it is not running.
 state: stopped #Stop the service if it is running, and do nothing if it is already stopped.

# Command Line for encrypting the pwd with base64 encoding
echo -n "your_password" | base64

```
In Ansible if one task fails then successive task will not execute & stops there only, so for exceptions handling sometimes you can use below -

ignore_errors: True          # ignore_errors is a predefined keyword in Ansible to ignore the errors of a task, if the task fails, it will not stop the playbook execution.
```


###############################
# How to call a common yml file to the main.yml file with ansible.builtin.include_role collection

- name: App Pre-requisite Tasks
  ansible.builtin.include_role:           # through this we can call any role inside another role
    name: common                          # Name of the role to be called
    tasks_from: pre-req.yml               # Name of the file to be called inside the role


## How to check Connectivity of all the target Nodes?
ansible all -m ping

forks: The number of parallel processes to use.
serial: Whether to run tasks serially (one at a time) or in parallel.
async: Whether to run tasks asynchronously (in the background) or synchronously (wait for completion).
poll: The interval (in seconds) at which to check the status of asynchronous tasks.
retries: The number of times to retry a task if it fails.
delay : The amount of time (in seconds) to wait before executing a task.
delegate_to: Whether to delegate the execution of a task to another host.
run_once: true --> Need to run task only once (DB migration)

Increase the SSH timeout in ansible.cfg by setting timeout = 30 or higher
under the [ssh_connection] section.



Q. can you create a modules in ansible?
Yes — Ansible lets you create custom modules, which are reusable pieces of Python (or sometimes other languages) that extend Ansible’s functionality.
You can write your own when built-in modules aren’t enough.
📁 1. Folder structure
project/
├── library/
│   └── dir_size.py   <-- custom module
├── playbook.yml

Ansible automatically looks in the library/ folder for custom modules.

🧠 2. Custom module code (library/dir_size.py)
   
▶️ 3. Playbook using the module
---
- name: Test custom Ansible module
  hosts: localhost
  connection: local
  tasks:
    - name: Get directory size
      dir_size:
        path: /tmp
      register: result
    - name: Show result
      debug:
        var: result

📦 Where modules can live
You can store custom modules in:

library/ (recommended per project)
~/.ansible/plugins/modules/
configured ANSIBLE_LIBRARY path        