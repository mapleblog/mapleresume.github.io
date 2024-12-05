---
title: SnipeIT ( Ubuntu 22.04 )
date: 2024-12-03 09:58:53
categories:
- System
- Platform
tags:
---

# 安装SnipeIT资产管理平台

##### 1. Update the server and install dependencies:
```bash
sudo apt update -y && apt upgrade -y
```
##### 1.1 Install unzip dependency
```shell
sudo apt-get install unzip git -y
```

##### 2. Install Apache Webserver
```shell
sudo apt install apache2 -y
```
*In case, you enabled firewall and firewall block requests of the apache web server, 
open a port in the firewall.*
```shell
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload
```
*Now, verify the Apache installation. Open browser and test default page.*
```shell
http://localhost
```
*Enable Apache’s mod_rewrite module. Snipe-IT requires this extension to rewrite URLs more cleanly.*
```shell
sudo a2enmod rewrite
```

*Restart your Apache web server to apply the changes.*
```shell
sudo systemctl restart apache2
```

##### 3. Install MariaDB
```shell
sudo apt install mariadb-server mariadb-client -y
```

*The default configuration of the MariaDB will not be secured. Let’s secured the installation using the following command:*
```shell
sudo mysql_secure_installation
```

*Once the script gets executed, it will ask multiple questions.
It will ask you to enter the current password for root (enter for none):
Then enter yes/y to the following security questions:*
```shell
Set a root password? [Y/n]: y
Remove anonymous users? : y
Disallow root login remotely? : y
Remove test database and access to it? : y
Reload privilege tables now? : y
```

##### 4. Install PHP and PHP Composer
*Here we are installing the default PHP version 8.1 and other modules for web deployments using the following command:*

```shell
sudo apt install php php-common php-bcmath php-bz2 php-intl php-gd php-mbstring php-mysql php-zip php-opcache php-intl php-json php-mysqli php-readline php-tokenizer php-curl php-ldap -y
```

*Install PHP Composer, which is a PHP dependency management tool to install and update libraries in your Snipe-IT.
Download the Composer installer.*

```shell
sudo curl -sS https://getcomposer.org/installer | php
```

*Move the composer.phar executable to /usr/local/bin/.*

```shell
sudo mv composer.phar /usr/local/bin/composer
```

##### 5. Create a Database
*Create a database and database user for Snipe-IT. First login into MySQL/MariaDB as a root user.*
```shell
sudo mysql -u root -p
```

*Run following commands to perform this task:*

```shell
CREATE DATABASE snipe_it;
CREATE USER 'snipe_it_user'@'localhost' IDENTIFIED BY 'EXAMPLE_PASSWORD';
GRANT ALL PRIVILEGES ON snipe_it.* TO 'snipe_it_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

*Note: Replace snipe_it_user to your choice username and replace **EXAMPLE_PASSWORD** to you choice password.*

##### 6. Install Snipe-IT
*Navigate to the root directory of your web server.*
```shell
cd /var/www/
```

*Use git to clone the latest Snipe-IT repository from the https://github.com/snipe/snipe-it URL and copy the downloaded files to a snipe-it directory.*

```shell
sudo git clone https://github.com/snipe/snipe-it snipe-it
```

*Switch to the snipe-it directory.*

```shell
cd snipe-it
```

*Snipe-IT ships with a sample configuration file. Copy it to /var/www/snipe-it/.env.*

```shell
sudo cp /var/www/snipe-it/.env.example /var/www/snipe-it/.env
```

*Edit the configuration file.*

```shell
sudo nano /var/www/snipe-it/.env
```

*In the Snipe-IT configuration file, locate these settings.*

```shell
APP_URL=null
APP_TIMEZONE='UTC'
```

*Set APP_URL to your server’s Fully Qualified Domain Name, or it’s public IP address. If you use a time zone other than UTC, change the timezone to a PHP-supported timezone, and enclose it in single quotes.*

```shell
APP_URL=example.com
APP_TIMEZONE='America/New_York'
```

*Locate these settings.*

```shell
DB_DATABASE=null
DB_USERNAME=null
DB_PASSWORD=null
```

*Change those values to the database information you set up in Step 3.*

```shell
DB_DATABASE=snipe_it
DB_USERNAME=snipe_it_user
DB_PASSWORD=EXAMPLE_PASSWORD
```

*Save and close the file.*

*Install the Snipe-IT dependencies with Composer. You’ll receive a warning not to run this as root on each command. It’s okay to continue as root for the Snipe-IT install, so type yes and hit ENTER.*

```shell
composer update — no-plugins — no-scripts
composer install — no-dev — prefer-source — no-plugins — no-scripts
```

*Set the correct ownership and permission for the Snipe-IT data directory.*

```shell
sudo chown -R www-data:www-data /var/www/snipe-it
sudo chmod -R 777 storage
```

*Once the Composer finishes running, generate a Laravel APP_Key value in the /var/www/snipe-it/.env configuration file you created earlier. Type yes and hit ENTER when prompted to continue.*

```shell
sudo php artisan key:generate
```

##### 7. Create a Virtual Host File
*First we’ll disable default Apacheconf file and create new vhost conf file.
Disable the default Apache configuration file.*

```shell
sudo a2dissite 000-default.conf
```

*Create a new Apache configuration file.*

```shell
sudo nano /etc/apache2/sites-available/snipe-it.conf
```

*Paste the information below and replace example.com with your server’s domain name or public IP address.*

```shell
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot /var/www/snipe-it/public

    <Directory /var/www/snipe-it/public>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

*Save and exit the file*

*Enable your new configuration file*

```shell
sudo a2ensite snipe-it.conf
```

*Restart your Apache web server to apply the changes.*

```shell
sudo systemctl restart apache2
```

##### 8. Run the Setup Wizard

*Navigate to your browser and access the setup wizard using your server IP or domain name you have mentioned in vhost conf file.*

More info : [Documentation](https://hostnextra.medium.com/install-snipe-it-on-ubuntu-22-04-hostnextra-9fec546373c9)