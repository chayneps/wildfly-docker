#!/bin/sh

if [ ! -d /mnt/logs/$MY_POD_NAME ]; then
  mkdir /mnt/logs/$MY_POD_NAME
fi

chmod 755 /mnt/logs/$MY_POD_NAME
chown jboss:jboss /mnt/logs/$MY_POD_NAME
 
