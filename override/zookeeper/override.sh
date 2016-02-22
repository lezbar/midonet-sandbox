#!/bin/bash

cd /tmp && \
   wget https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.2/jolokia-jvm-1.3.2-agent.jar

sed -i 's#JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=$JMXLOCALONLY"#JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=$JMXLOCALONLY -javaagent:/tmp/jolokia-jvm-1.3.2-agent.jar=port=8778,host=0.0.0.0"#g' /etc/init/zookeeper.conf

exec /run-zookeeper.sh
