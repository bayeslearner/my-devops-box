#!/bin/bash -e

hosts="
192.168.56.11    pgsql01
192.168.56.12    pgsql02
192.168.56.13    pgsql03
"

echo "$hosts" >> /etc/hosts