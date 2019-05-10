#!/bin/bash
ln -s /mnt/logs/$MY_POD_NAME /webapps/logs
exec /webapps/wildfly/bin/standalone.sh -b 0.0.0.0 > /webapps/logs/wildfly.log 2>&1
