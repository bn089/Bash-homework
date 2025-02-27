#!/bin/bash

function kpop() {
	sudo useradd lisa
	sudo useradd jisoo
	sudo useradd jenny
	sudo useradd rose
       	sudo groupadd blackpink
        sudo usermod -aG blackpink jisoo
        sudo usermod -aG blackpink jenny
        sudo usermod -aG blackpink lisa
        sudo usermod -aG blackpink rose
}

kpop

function wordpress() {
        echo "Installing Apache, PHP, and MySQL..."
        sudo apt install apache2 ghostscript libapache2-mod-php mysql-server php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip -y > /dev/null 2>&1
        echo "Downloading Wordpress..."
        sudo wget -q https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz
        echo "Extracting Wordpress..."
        sudo tar xzvf /tmp/latest.tar.gz -C /var/www/html > /dev/null 2>&1
        echo "Setting Permissions..."
        sudo chown -R www-data:www-data /var/www/html/wordpress
        sudo chmod -R 755 /var/www/html/wordpress
        echo "Wordpress installation completed!"

        echo "Configuring Wordpress..."
        sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
        sudo sed -i "s/MySQL/$DB_NAME/" /var/www/html/wordpress/wp-config.php
        sudo sed -i "s/bubusara/$DB_USER/" /var/www/html/wordpress/wp-config.php
        sudo sed -i "s/kaizen123/$DB_PASS/" /var/www/html/wordpress/wp-config.php
        sudo sed -i "s/localhost/34.238.232.195/" /var/www/html/wordpress/wp-config.php

        echo "Configuring Apache..."
        sudo bash -c 'cat > /etc/apache2/sites-available/wordpress.conf << EOL
<VirtualHost *:80>
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOL'
sudo a2enmod rewrite
sudo a2ensite wordpress.conf
sudo systemctl restart apache2
echo "WordPress installation complete! You can now visit your server IP to begin WordPress setup (language selection page)."


}

wordpress

function calculator() {
        echo $((12+4))
        echo $((12-4))
        echo $((4-12))
        echo $((12/4))
        echo $((12*4))
}
calculator

function binary() {
        sudo apt install tree -y > /dev/null
        sudo apt-get update && sudo apt-get install -y gnupg software-properties-common > /dev/null
        wget -O- https://apt.releases.hashicorp.com/gpg | \
                gpg --dearmor |
        sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update
        sudo apt-get install terraform
}
binary
