#!/bin/bash 

# Check if http-related extensions are present
if ! php -m | grep -q 'http' ; then
    pecl install propro raphf > /dev/null
    echo "extension=propro.so" | tee /etc/php/7.0/mods-available/propro.ini 
    echo "extension=raphf.so" | tee /etc/php/7.0/mods-available/raphf.ini
    phpenmod propro raphf 

    yes '' | pecl install pecl_http > /dev/null
    echo "extension=http.so" | tee /etc/php/7.0/mods-available/http.ini 
    phpenmod http
    echo "successfully installed pecl_http"
else
    echo "php http, raphf, and propro drivers were already installed. Skipping..."
    exit 0
fi
