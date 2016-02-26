#!/bin/sh

# Installs newest package (lexicographycally) in override
LATEST=$(ls /override/midonet-api*deb | tail -n1)
dpkg -i $LATEST

exec ./run-midonetapi.sh
