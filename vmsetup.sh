# Paul Molloy
# 15323050
sudo apt update
sudo apt upgrade
sudo apt-get install build-essential
sudo apt-get install linux-image-extra-virtual
#wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.128/NVIDIA-Linux-x86_64-367.128.run
#sudo /bin/bash NVIDIA-Linux-x86_64-367.128.run
wget https://bootstrap.pypa.io/3.2/get-pip.py
chmod +x get-pip.py
sudo apt-get install python
sudo ./get-pip.py
sudo pip install --upgrade pip
sudo pip install hashid
sudo pip install requests
wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-10000.txt -O 10000passwords.txt
