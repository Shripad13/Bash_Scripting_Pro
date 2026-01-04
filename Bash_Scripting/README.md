
# Alias
To keep all alias permanently on server, add them in .bash_profile file
ex: alias gp="git pull"

alias ssh="ssh ec2-user@$1"


# .bash_profile
When you want something to be prompted on server whenever login to server, 
that also you can update in .bash_profile file

# type
Ex: type git, type date, type cat , type fdisk 

It will show the path where these applications installed on server


sudo dnf list installed |grep java
sudo dnf list |grep java
sudo dnf list |grep jdk
