#!/bin/sh

if [ ! -d /mnt/logs/$MY_POD_NAME ]; then
  mkdir /mnt/logs/$MY_POD_NAME
  chmod 755 /mnt/logs/$MY_POD_NAME
fi
ln -s /mnt/logs/$MY_POD_NAME /webapps/logs   
/webapps/wildfly/bin/standalone.sh -b 0.0.0.0 > /webapps/logs/wildfly.log 2>&1
