#!/bin/bash 

LIBRDKAFKA_VERSION=${1:-"1.1.0"}

# Depends on: php
if ! which php > /dev/null ; then
    echo "PHP was not found. Aborting.."
    exit 1
fi

#  Check if rdkafka driver is present
if ! php -m | grep -q 'rdkafka' ; then
    mkdir -p /tmp/lib
    wget -qO /tmp/lib/librdkafka.tar.gz https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz 
    tar -C /tmp/lib -xzf /tmp/lib/librdkafka.tar.gz
    pushd /tmp/lib/librdkafka-${LIBRDKAFKA_VERSION}
    ./configure --install-deps
    make
    make install
    popd

    pecl install rdkafka > /dev/null
    echo "extension=rdkafka.so" | tee /etc/php/7.0/mods-available/rdkafka.ini 
    phpenmod rdkafka
else
    echo "php rdkafka driver was already installed. Skipping..."
    exit 0
fi
