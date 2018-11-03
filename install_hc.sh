# Paul Molloy
# 15323050
#mkdir code
#cd code
#git clone https://github.com/paulmolloy/cs7ns1ScalableAssignments.git
if [ -d hashcat-4.2.1 ]; then
  rm -r "hashcat-4.2.1"
fi
if [ ! -f hashcat-4.2.1.7z ]; then
  wget https://hashcat.net/files/hashcat-4.2.1.7z 
fi
sudo apt-get install p7zip
p7zip -d  hashcat*.7z
echo 'alias hashcat="$HOME/code/hashcat-4.2.1/hashcat64.bin"' >> ~/.bashrc
source ~/.bashrc
wget https://github.com/DavidWittman/wpxmlrpcbrute/raw/master/wordlists/1000-most-common-passwords.txt
wget http://downloads.skullsecurity.org/passwords/english.txt.bz2
wget https://github.com/dwyl/english-words/raw/master/words.txt
bzip2 -d english.txt.bz2
sort <(grep -x '.\{4,4\}' english.txt) <(grep -x '.\{4,4\}' words.txt) | uniq > bigger4eng.txt
sudo apt-get install pwgen
uniq <(pwgen -0 -A 5 -N 4000000) | tr ' ' '\n' > unique5.txt

