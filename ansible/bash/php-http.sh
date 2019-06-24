#!/bin/bash -eux

# Depends on: php7.0.sh
if ! which php > /dev/null ; then
    echo "PHP was not found. Aborting.."
    exit 1
fi

# Check if http driver is installed and enabled
if ! php -m | grep -q 'http' ; then
    sudo pecl install propro raphf > /dev/null
    echo "extension=propro.so" | sudo tee -a /etc/php/7.0/mods-available/propro.ini 
    echo "extension=raphf.so" | sudo tee -a /etc/php/7.0/mods-available/raphf.ini
    sudo phpenmod propro raphf 

    yes '' | sudo pecl install pecl_http > /dev/null
    echo "extension=http.so" | sudo tee -a /etc/php/7.0/mods-available/http.ini 
    sudo phpenmod http
else
    echo "php http, raphf, and propro drivers were already installed. Skipping..."
fi
