#!/bin/bash -eux

# install glusterfs-client
if ! [ -x "$(command -v glusterfs)" ]; then
  apt-get install -yq glusterfs-client attr
  glusterfs --version
fi

# feed hosts file
if ! $(cat /etc/hosts | grep -q 'glusterfs') ; then
  cat /tmp/hosts.conf | tee -a /etc/hosts
fi

mkdir -p /etc/glusterfs 
mkdir -p /mnt/gluster/

cp /tmp/gluster.conf /etc/glusterfs/gluster.conf

# append config to fstab is not already present
grep -q "glusterfs" /etc/fstab || echo "/etc/glusterfs/gluster.conf  /mnt/gluster/    glusterfs   rw    0   0" | tee -a /etc/fstab
mount -a
