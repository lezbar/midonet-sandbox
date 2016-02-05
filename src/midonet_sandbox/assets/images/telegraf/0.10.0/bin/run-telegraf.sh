#!/bin/bash

CONFIG_FILE="/telegraf_conf/telegraf.conf"
# Parse the IP address of the container
IP=${LISTEN_ADDRESS:-`hostname --ip-address`}

cp ${CONFIG_FILE} /etc/telegraf/telegraf.conf

echo Starting Telegraf on $IP...

#exec /opt/telegraf/telegraf -config ${CONFIG_FILE} -output-filter influxdb -quiet &
exec /sbin/init