#!/bin/sh
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-857d932e.efs.us-west-2.amazonaws.com:/ /mnt/logs
if [ ! -d /mnt/logs/$MY_NODE_NAME ]; then
  mkdir /mnt/logs/$MY_NODE_NAME
  chmod 666 /mnt/logs/$MY_NODE_NAME
fi
ln -s /mnt/logs/$MY_NODE_NAME /webapps/logsman   
/webapps/wildfly/bin/standalone.sh -b 0.0.0.0 > /webapps/logs/wildfly.log 2>&1
