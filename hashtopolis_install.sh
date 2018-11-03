# Paul Molloy
# Partially https://www.trillsecurity.com/tutorials/automating-hashtopolis-with-terraform-part-i/
mysql_rootpass="$1"
mysql_apppass="$2"
web_adminpass="$3"
voucher_name="$4"
echo "running"
sudo apt autoremove
sudo apt-get install mysql-server
sudo apt-get install apache2
sudo apt-get install libapache2-mod-php
sudo apt-get install php-mcrypt
sudo apt-get install php-mysql
sudo apt-get install  php php-gd
sudo apt-get install php-pear 
sudo apt-get install php-curl
sudo apt-get install git

sudo apt-get install -y mysql-server apache2 libapache2-mod-php php-mcrypt php-mysql php php-gd php-pear php-curl git

# set password for non-interactive mysql install
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password ${mysql_rootpass}'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ${mysql_rootpass}'


# give user data time to finish
sleep 60
sudo awk '/^password/ {print $3; exit}' /etc/mysql/debian.cnf 
# MySQL Setup
sudo mysql -u debian-sys-maint -p${mysql_rootpass} -e "create database hashtopolis; GRANT all PRIVILEGES ON hashtopolis.* TO 'hashtopolis'@'localhost' IDENTIFIED BY '${mysql_apppass}';"

# server files
git clone https://github.com/s3inlc/hashtopolis.git
cd hashtopolis/src
sudo mkdir /var/www/hashtopolis
sudo cp -r * /var/www/hashtopolis
sudo chown -R www-data:www-data /var/www/hashtopolis

sudo tee /etc/apache2/sites-available/000-default.conf << YOLO
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/hashtopolis/
        <Directory /var/www/hashtopolis>
                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
YOLO

sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin.conf

sudo service apache2 reload
sleep 5
# use web app to configure hashtopolis
cd ~/
curl -c cookie.txt http://127.0.0.1/
sleep 5
echo "initial load done."
curl -b cookie.txt http://127.0.0.1/install/ -c cookie.txt
sleep 5
curl -b cookie.txt http://127.0.0.1/install/index.php?type=install -c cookie.txt
sleep 5
curl -b cookie.txt http://127.0.0.1/install/index.php -c cookie.txt
sleep 5
curl -b cookie.txt -d "server=localhost&port=3306&user=hashtopolis&pass=${mysql_apppass}&db=hashtopolis&check=Continue" http://127.0.0.1/install/index.php -c cookie.txt
sleep 5
curl -b cookie.txt http://127.0.0.1/install/index.php -c cookie.txt
sleep 5
curl -b cookie.txt http://127.0.0.1/install/index.php?next=true -c cookie.txt
sleep 5
curl -b cookie.txt http://127.0.0.1/install/index.php -c cookie.txt
sleep 5
curl -b cookie.txt -d "username=admin&email=test@example.com&password=${web_adminpass}&repeat=${web_adminpass}&create=Create" http://127.0.0.1/install/index.php -c cookie.txt
sleep 5
curl -b cookie.txt http://127.0.0.1/install/index.php -c cookie.txt

# remove web server configuration scripts
sudo rm -r /var/www/hashtopolis/install
rm -rf ~/hashtopolis
rm cookie.txt
sudo systemctl status apache2
# setup hashtopolis vouchers
mysql -u debian-sys-maint -p${mysql_rootpass} -e "UPDATE hashtopolis.Config SET value = 1 WHERE item='voucherDeletion'; INSERT INTO hashtopolis.RegVoucher (voucher,time) VALUES ('${voucher_name}', UNIX_TIMESTAMP());"
