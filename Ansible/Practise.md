1. Write a playbook to install and start Nginx

- name: Install and start Nginx
  hosts: webservers
  become: yes
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
      when: ansible_os_family == "Debian"

    - name: Start nginx
      service:
        name: nginx
        state: started
        enabled: yes

2. Create a user and add SSH key

- name: Create user with SSH access
  hosts: all
  become: yes
  tasks:
    - name: Create user
      user:
        name: devopsuser
        state: present

    - name: Add SSH key
      authorized_key:
        user: devopsuser
        key: "{{ lookup('file', 'id_rsa.pub') }}"

3. Copy file only if it changes (idempotency)

- name: Copy config file
  hosts: all
  tasks:
    - name: Copy file
      copy:
        src: app.conf
        dest: /etc/app.conf
        owner: root
        mode: '0644'                

4. Use variables from external file

- name: Use vars file
  hosts: all
  vars_files:
    - vars.yml
  tasks:
    - name: Print variable
      debug:
        msg: "{{ app_name }}"


5. Write a handler example

- name: Restart service on config change
  hosts: webservers
  become: yes
  tasks:
    - name: Update config
      copy:
        src: nginx.conf
        dest: /etc/nginx/nginx.conf
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted

6. Loop through multiple packages

- name: Install packages
  hosts: all
  become: yes
  tasks:
    - name: Install packages
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - git
        - curl
        - vim
  
7. Conditional task execution         
- name: Conditional execution
  hosts: all
  tasks:
    - name: Install httpd
      yum:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"

8. Template with Jinja2

- name: Deploy template
  hosts: all
  tasks:
    - name: Deploy config
      template:
        src: app.j2
        dest: /etc/app.conf

9. Register and use output

- name: Check disk space
  hosts: all
  tasks:
    - name: Run df command
      command: df -h
      register: disk_output

    - name: Show output
      debug:
        var: disk_output.stdout

10. Rolling deployment (serial)

- name: Rolling deployment
  hosts: webservers
  serial: 2
  tasks:
    - name: Pull latest code
      git:
        repo: https://github.com/example/app.git
        dest: /var/www/app

    - name: Restart service
      service:
        name: app
        state: restarted                      




$ ansible --version
ansible [core 2.19.8]

$ python3 --version
Python 3.9.18


secrets: "{{ lookup('community.hashi_vault.hashi_vault', 'secret=expense-dev/data/backend', token=token, url='https://vault.devsecopswithshri.site:8200', validate_certs=False) }}"


10.190.96.242 ansible_connection=ssh ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_connection=ssh → use SSH
ansible_ssh_common_args='-o StrictHostKeyChecking=no' → skip host key prompt OR Do NOT ask for confirmation when connecting to a new host

ansible_connection=ssh ansible_ssh_common_args='-o StrictHostKeyChecking=no'


Errors- 
1. Connection timed out  - check with telnet command

2. Permission Denied Error-
- SSH connectivity & user permissions
- Check /etc/sudoers file or sudoer.d
- Manual logging


3. Doesnt make changes on target server
- RUn with -vvv verbose for detaild logs
- Check if any conditional statements
- Verify inventory
- Inspect generated files on target
- Test with --check Dry run


4. Cause - Ansible hangs
- ssh_connection timeout
- requires user input
- check firewall restrictions
- May occur high CPU on target
- vvv 

5. Optimize the PLaybook
- Optimize loops with loop_control
- combine related shell commands
- ENable pipelining in ansible.cfg
Use async & Pol for long running tasks

6. Syntax Error
= Run --syntax-check

✅ Ansible Playbook: Delete All Files and Confirm Empty Directory
---
- name: Delete all files in a directory and verify empty state
  hosts: all
  become: yes

  vars:
    target_dir: /tmp/testdir   # change this to your directory

  tasks:
    - name: Find all files in the directory
      ansible.builtin.find:
        paths: "{{ target_dir }}"
        file_type: any
      register: files_found

    - name: Delete all files found
      ansible.builtin.file:
        path: "{{ item.path }}"
        state: absent
      loop: "{{ files_found.files }}"

    - name: Re-check directory contents after deletion
      ansible.builtin.find:
        paths: "{{ target_dir }}"
        file_type: any
      register: files_after

    - name: Show remaining files count
      ansible.builtin.debug:
        msg: "Remaining files: {{ files_after.matched }}"

    - name: Fail if directory is not empty
      ansible.builtin.assert:
        that:
          - files_after.matched == 0
        fail_msg: "Directory is NOT empty after cleanup!"
        success_msg: "Directory is successfully empty (0 files)."