#!/bin/bash

# Parse the IP address of the container
IP=${LISTEN_ADDRESS:-`hostname --ip-address`}
. /keystonerc
rally deployment create --fromenv --name=docker-rally

echo Starting Rally on $IP...
exec /sbin/init
