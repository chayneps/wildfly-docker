#!/bin/sh
ln -s /mnt/logs/$MY_POD_NAME /webapps/logs
/webapps/wildfly/bin/standalone.sh -b 0.0.0.0 > /webapps/logs/wildfly.log 2>&1
