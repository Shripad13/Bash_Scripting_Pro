
# Alias
To keep all alias permanently on server, add them in .bash_profile file
ex: alias gp="git pull"

alias ssh="ssh ec2-user@$1"


# .bash_profile
When you want something to be prompted on server whenever login to server, 
that also you can update in .bash_profile file

# .bashrc file
To customize the user’s shell environment whenever a new interactive Bash terminal is opened.
1. Setting Environment Variables
2. Creating Aliases (Shortcuts)
3. Customizing Prompt (PS1)
4. Defining Functions
5. Running Commands at Startup

The purpose of the .bashrc file is to configure the Bash shell environment for a user. It is executed whenever a new interactive shell starts and is used to set environment variables, define aliases, customize the prompt, and create functions.”


# type
Ex: type git, type date, type cat , type fdisk 

It will show the path where these applications installed on server


sudo dnf list installed |grep java
sudo dnf list |grep java
sudo dnf list |grep jdk

> PATH ---> shell looks for executable files


# Hard Link - 
A hard link is another name (directory entry) for the same file data (same inode).
Both the original file and the hard link share the same inode number.

If original file is deleted, data still exists as long as one hard link remains
command -     $ ln original.txt hardlink.txt
check inode - $ ls -li

If inode numbers are same → it's a hard link.

# Soft Link (Symbolic Link)-
A soft link (symlink) is a shortcut that points to the filename (path) of another file.
It is like a shortcut in Windows.
Has different inode number
If original file is deleted, symlink becomes broken (dangling link)
Centralized file management – One file, accessible from multiple locations.

Command - $ ln -s original.txt softlink.txt
Check symlink - ls -l

A hard link is another name for the same file and shares the same inode. Even if the original file is deleted, the data remains accessible.
A soft link is a symbolic pointer to the file path. If the original file is deleted, the soft link becomes broken.”

The purpose of a hard link is to provide multiple directory entries for the same file data without consuming extra space.”
The purpose of a soft link is to act as a shortcut that points to another file or directory, even across filesystems.”

Hard Link = Two different names for the same person.
Soft Link = A paper that contains someone’s address.


# 1️⃣ Extract IP addresses from logs using awk "How do you find the top 5 IPs hitting a web server?”
 $ cat /var/log/nginx/access.log | awk '{print $1}' | sort | uniq -c | sort -nr | head -5
    $1 → first field in log (IP address)
    sort | uniq -c → count occurrences (sort the IP adddress if its same IP coming multiple times)
    sort -nr → sort by number descending (r - reverse, n - numeric)
    head -5 → top 5 IPs hitting your server
    awk -> search/filter or read rows & columns , perform calculations & applied conditions & format outputs
   Syntax -> awk 'pattern {action}' filename
    grep -> find lines
    cut -> extarct columns


2️⃣ Extract usernames from /etc/passwd using cut "How do you list all system users?”
 $ cut -d':' -f1 /etc/passwd
    -d':' → delimiter is colon
    -f1 → first field (username)

3️⃣ Replace a word in a configuration file using sed  "“How do you change the port in Apache config via CLI?”
  $ sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf        
  s/old/new/ → substitute
  -i → edit file in-place

4️⃣ Extract the total memory from free -m using awk
“How do you get total system memory in MB from command line?”

$ free -m |grep Mem | awk '{print $2}'
$ free -m | awk 'NR==2 {print $2}'
    NR==2 → second line (memory info)
    $2 → second field (total memory in MB)

If you just want a single snapshot, use: Prints line 7 & 8 of top command
 $ top -b -n1 | awk 'NR==7,NR==8'


5️⃣ Extract domain names from a URL list using sed
 How do you get domain names from a list of URLs?”

 $ cat urls.txt | sed 's|https\?://||' | cut -d'/' -f1    

    sed 's|https\?://||' → remove http:// or https://
    cut -d'/' -f1 → get domain before first /



1️⃣ Find files modified in the last 24 hours
How do you find recently modified log files?
  $find /var/log -type f -mtime -1    

    /var/log → search directory
    -type f → only files
    -mtime -1 → modified less than 1 day ago (-n = last n days)

2️⃣ Find files older than 7 days for cleanup
“How would you remove old temporary files automatically?”
  $ find /tmp -type f -mtime +7
    -mtime +7 → modified more than 7 days ago
    Useful for automated cleanup scripts    

3️⃣ Delete files older than 30 days
  $ find /var/log/archive -type f -mtime +30 -exec rm -f {} \;
    
    -mtime +30 → modified more than 30 days ago
    -exec rm -f {} \; → delete each found file

4️⃣ Find directories modified in the last 3 days
“How do you find recently updated project folders?”

 $find /opt/projects -type d -mtime -3
    -type d → only directories
    -mtime -3 → modified in the last 3 days

5️⃣ Find and list files older than 15 days with details
How do you audit old backup files?”

 $ find /home/user/backups -type f -mtime +15 -ls

--------------------------------------------------
 | Syntax      | Meaning                          |
| ----------- | --------------------------------- |
| `-mtime +N` | Modified **more than N days ago** |
| `-mtime -N` | Modified **less than N days ago** |
| `-mtime N`  | Modified **exactly N days ago**   |
Know difference between -mtime (days) and -mmin (minutes)


# To remove the directoy based on timestamp of directories
find . -maxdepth 1 -type d -newermt 2021-01-01 ! -newermt 2025-01-01 -exec rm -rf {} \;


# A filesystem has unexpectedly remounted as read-only, How do you diagnose & fix it?
what would you check in dmesg for underlying I/O errors?
Check kernel messages using below command -

dmesg -T | tail -100
##

sudo su   ----> /home/user
sudo su - ---> /root

top -bn1 |grep "Cpu(s)" |awk '{print $2+$4}'
OR
top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}'

$8  - $8 is often the id (idle CPU) value.
100 - idle% = used CPU%

top -bn1 | grep "Cpu(s)"
top -bn1  ---> Show me the current system status one time and quit.
-b → batch / non-interactive
-n1 → run once
$2 = User CPU (us)
$4 = System CPU (sy)

(echo "$MEMORY_USAGE > $THRESHOLD" | bc -l) 
bc -l: This command-line calculator is used for floating-point comparison. 

s/OLD/NEW/
sed 's/%//g': Removes the percentage sign & replace with blank space

df /|grep / |awk '{print $5}' | sed 's/%//g'


uptime | awk -F'load average: ' '{ print $2 }' | cut -d, -f1 | tr -d ' '
-F'load average: ' -----> Sets the field separator to the string

cut -d, -f1    -----> 
-d -----> Sets delimiter as a comma
-f1  --------> Selects the first field
 tr -d ' '       ---> 
tr     ----> delete characters 
-d ' ' ------> deletes spaces

ping -c 4 google.com|tail -1| awk -F '/' '{print $5}'

awk -F '/' '{print $5}': Extracts the average latency.
-F '/'   ----> Sets the field separator to /

uptime | awk -F 'load average:' '{ print $2 }' | awk '{print $1}' | sed 's/,//'
s/OLD/NEW/ -------> s/,//



awk 'NR==2 {print $3}' | sed 's/m//'
NR ---> Number of Record
NR==2   ----> Only act on the second line of input
{print $3}   ----> Print the third field (column) of that line


#awk to print names of people who are older than 25 
awk '$2 > 25 {print $1}' data.txt

# TO check Memory consumption of processes
ps -eo pid,comm,%mem --sort=-%mem | head

# Print lines that contain the word "error"
awk '/error/ {print}' log.txt


set -x ----> enables debugging mode
set +x ----> disables debugging mode
set -e ----> script exit immediately if any command returns non-zero status
set -u ----> treat unset variables as an error and exit immediately
set -o pipefail ----> causes a pipeline to return the exit status of the last command in the pipe that returned a non-zero return value

Background process - Ex- sleep 5 &
Foreground process - Ex- echo "Enter a name";read name ; echo "Hello, $name"


Q6. Have you written shell scripts? Give an example.

Yes. I’ve written shell scripts for:
Log cleanup and archiving
Monitoring disk usage and alerts
Application health checks
Example: A script to check WebLogic service status and restart automatically if it’s down


# Advanced sed examples
sed '/alpha/s/beta/gamma/'
sed '/apple/,/orange/d'
sed '/important/!s/print/throw_away/'

| Command                           | Effect                                              |
| --------------------------------- | --------------------------------------------------- |
| `/alpha/s/beta/gamma/`            | Replace `beta` → `gamma` only on lines with `alpha` |
| `/apple/,/orange/d`               | Delete lines from `apple` to `orange`               |
| `/important/!s/print/throw_away/` | Replace `print` unless line has `important`         |


sed 's/@home/@domicile/; s/truck/lorie/'
sed -e 's/[xX]/Y/' -e 's/b.n*/blue/'
sed -f sedscript -n sed4
date | sed 's/j/J/'
sed '1,5p'

-e option- stands for expression. when you want to execute more than one editing command on a file
g flag stands for Global replacemnet for search and replace.
s stands for substitute


| Command                           | Effect                                              |
| --------------------------------- | --------------------------------------------------- | 
| `s/@home/@domicile/; s/truck/lorie/` | Multiple substitutions in one command                |
| `-e 's/[xX]/Y/' -e 's/b.n*/blue/'` | Multiple `-e` expressions for complex edits          |
| `-f sedscript -n sed4`            | Use script file for multiple commands                     |
| `date | sed 's/j/J/'`             | Replace lowercase `j` with uppercase `J` in date output |
| `1,5p`                            | Print lines 1 to 5                                   |

# Linux Boot Process -
Power On  
   ↓
BIOS / UEFI  --> Performs POST, initializes hardware, and loads bootloader from disk
   ↓
GRUB (Bootloader)   --> Presents boot menu, loads Linux kernel into memory
   ↓
Linux Kernel Initialization  --> Detects hardware, mounts root filesystem, and starts init process
   ↓
init process (PID 1)  --> Manages system services and targets, starts essential services
   ↓
Services Start  --> Network, SSH, Web Server, etc. are started based on configuration
   ↓
Login Prompt --> User can log in via console or SSH to access the system

# UUID stands for Universally Unique Identifier.
UUID in Linux is a unique 128-bit identifier assigned to filesystems or partitions, used to reliably identify and mount disks instead of device names like /dev/sda, which may change.

128-bit unique ID assigned to:
Disk partitions
Filesystems
Swap partitions
Sometimes hardware devices
⚠ Problem:
Device names can change after:
Reboot
Adding/removing disks
Changing SATA/NVMe ports
To solve this, Linux uses UUID, which:
✅ Never changes (unless filesystem is recreated)
✅ Uniquely identifies the filesystem
✅ Ensures correct disk mounting

Where UUID is Commonly Used
1️⃣ In /etc/fstab   partitions are usually mounted using UUID
This ensures the correct partition mounts at boot.

How to Check UUID in Linux:
 $ blkid
 $ lsblk -f
 $ ls -l /dev/disk/by-uuid/


LVM is used in Linux to provide flexible disk management. It allows dynamic resizing, combining multiple disks, taking snapshots, and extending storage without downtime, which is difficult with traditional partition

| Setup   | Steps                                                   |
| ------- | ------------------------------------------------------- |
| LVM     | Increase disk → pvresize → lvextend → resize filesystem |
| Non-LVM | Increase disk → grow partition → resize filesystem      |

LVM has 3 layers:
PV (Physical Volume) → Actual disk/partition
VG (Volume Group) → Pool of storage
LV (Logical Volume) → Virtual partition created from VG

1️⃣ Easy Disk Expansion (Most Important) without downtime.
2️⃣ Combine Multiple Disks - merge multiple disks into one large storage pool.
3️⃣ Resize Volumes Easily- Even reduce size (carefully)
4️⃣ Snapshots (For Backup) - Take snapshot before upgrade
5️⃣ Better Resource Utilization- Allocate space dynamically, Expand only when needed


#  5 Productive Linux Commands for Sysadmins-
ncdu - Disk usage analyzer with interactive interface (instead of du -sh *)
tldr find - Simplified command explanations and examples (instead of find --help)
tldr ps - Quick reference for process management commands
rg (ripgrep) - Fast recursive search tool for code and logs (instead of grep -rl "" *)
rg insane - Search for "insane" word in current directory and subdirectories

* wants to find a particular folder- go for find, ls, grep command
fzf & enter

* Open & read the command- cat, less, more, head, tail
bat - A cat clone with syntax highlighting and Git integration (instead of cat)


# what is system call in linux ?
A system call (syscall) is the mechanism by which a user-space program requests a service from the Linux kernel.
Linux separates memory into two privilege levels:
User space — where your programs run (restricted access)
Kernel space — where the OS runs (full hardware access)

A program can't directly touch hardware, files, or network interfaces. It must ask the kernel to do it via a system call.

You can trace every syscall a program makes using strace:  $ strace ls
This shows every syscall ls makes — openat, read, write, close, etc. — with arguments and return values. Very useful for debugging. 


# how do you find particular error messgae word in log file on linux server, with commands?
grep -i "error" logfile.log
grep "connection timeout" logfile.log
grep -r "error" /var/log/
grep -n "error" logfile.log
grep -C 3 "error" logfile.log
Shows 3 lines before and after each match

tail -f logfile.log | grep "error"
less logfile.log


# Even after killing the process in linux, still its coming up on server, what could be the reasons for process running back
1. Modern Linux systems use systemd, which can auto-restart services.
systemctl status <service-name>
Look for:
Restart=always

1. Sometimes a parent process keeps restarting the child.
 ps -ef | grep <process-name>
 ps -fp <PPID>-

3. A cron job may be launching it repeatedly.
crontab -l
cat /etc/crontab
ls /etc/cron.*

4. If it's inside a container, it will restart automatically.
   docker ps
   docker inspect <container-id> | grep RestartPolicy
   
5. Normal kill may not terminate stubborn processes.
kill -9 <PID>

###########################################################################################

1. how do you pick the list of numbers from an excel sheet & print the total of those values using ?
Shell scripts typically don't read .xlsx directly; I'd first convert it to CSV using a tool like xlsx2csv and then use awk to calculate the total.

$ awk -F, '{sum += $2} END {print sum}' file.csv

2. How to stop script if any of its instructions fails
Use set -e at the beginning of the shell script. It makes the script exit immediately if any command returns a non-zero (failure) status."
 $ set -euo pipefail

-e → exit on error
-u → error on undefined variables
pipefail → fail if any command in a pipeline fails

3. write a script to take a input from the user and print whether its a even or odd?

#!/bin/bash

echo "Enter a number:"
read num

if (( num % 2 == 0 ))
then
    echo "$num is Even"
else
    echo "$num is Odd"
fi

4. write a script that recursively checks the directories & list the top 15 utilized/largest files

find /path/to/search -type f -exec du -h {} + 2>/dev/null | sort -hr | head -15

find . -type f -exec du -h {} + 2>/dev/null | sort -hr | head -15

5. what is the difference between apt vs yum vs rpm vs source code based installations?
APT and YUM are package managers that automatically resolve dependencies; 
RPM is a lower-level package installer for RPM files and doesn't handle dependencies automatically; source code installation requires compiling the application manually and managing dependencies yourself."


apt --> Debian-based systems (Ubuntu, Debian)
yum --> Red Hat-based systems (RHEL, CentOS, Fedora)
rpm --> Red Hat Package Manager, used for installing .rpm files

6. how do you handle writing a bash script with multiple linux farms of different distros?
I write portable shell scripts, avoid distro-specific commands where possible, and detect the operating system at runtime to execute distro-specific logic when needed.

#!/bin/bash

if [ -f /etc/redhat-release ]; then
    PKG_MGR="yum"
elif [ -f /etc/debian_version ]; then
    PKG_MGR="apt"
else
    echo "Unsupported OS"
    exit 1
fi
echo "Using package manager: $PKG_MGR"


7. what is the difference between && and || in bash scripting?
In bash scripting, && and || are logical operators used to control the flow of command execution based on the success or failure of previous commands.

&& executes the next command only when the previous command succeeds, 
while || executes the next command only when the previous command fails. 
They are commonly used for conditional execution and error handling in shell scripts.

 $ mkdir test && cd test
cd test executes only if mkdir test succeeds.


 $ mkdir test || echo "Directory creation failed"
The message is printed only if mkdir fails.


8. write a script to list the number of non-empty lines in a file

 $ awk 'NF {count++} END {print count}' "$1"
 NF in awk checks if a line contains at least one field

9. If you want to print the 5th line and the 4th field from a CSV file:
   $ awk -F',' 'NR==5 {print $4}' file.csv
-F',' → comma is the field separator.
NR==5 → process only line 5.
$4 → print the 4th field.

10. If interviewer asks to print both line number and 4th field
 $ awk -F',' 'NR==5 {print "Line:", NR, "Field4:", $4}' file.csv

 Output - Line: 5 Field4: 5000

11. Load average in a Linux server represents the average number of processes that are either running or waiting for CPU time over a specific period.
commands - uptime & top
last 1 minute, 5 minutes, and 15 minutes

A value of 0 → system is idle
A value equal to number of CPU cores → fully utilized
A value higher than CPU cores → system is overloaded


#
# Why top first?
top provides a real-time, high-level view of the entire system in a single screen:
CPU utilization
Memory usage
Load average
Running/sleeping processes
Process-level CPU and memory consumption
System uptime
Zombie processes

top -H -p <PID>

starce or perf - using this pause the process 



# vmstat 1
vmstat = Virtual Memory Statistics
1 = Refresh and display statistics every 1 second

Use after top when you want to understand:
CPU wait time (wa)
Memory pressure
Swapping activity (si, so)
Run queue (r)
Context switches

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b swpd free buff cache si so bi bo in cs us sy id wa st
 1  0    0 2G   1G   4G   0  0  5 10 120 230 10  5 80  5  0

r = Processes waiting for CPU
b = Processes blocked (usually I/O)
si/so = Swap In/Swap Out
bi/bo = Blocks read/written
us = User CPU %
sy = System CPU %
id = Idle CPU %
wa = I/O Wait %

Example:

wa = 5% → CPU is waiting for disk/storage.
si/so > 0 → System is swapping (memory pressure).

# iostat -xz 1
-x = Extended disk statistics
-z = Hide devices with no activity
1 = Refresh every 1 second

It provides:
Disk utilization (%util)
Disk latency (await)

Device    r/s   w/s   rkB/s   wkB/s  await  %util
sda      10    50    1024    4096    25.0   95.0
r/s = Reads per second
w/s = Writes per second
rkB/s = Read throughput
wkB/s = Write throughput
await = Average I/O latency (ms)
%util = Disk utilization

Example:
%util ≈ 95% → Disk is fully busy.
await > 20-30 ms (for SSDs) → Potential storage latency issue.   

