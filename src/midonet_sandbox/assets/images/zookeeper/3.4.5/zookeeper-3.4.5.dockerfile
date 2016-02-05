FROM ubuntu-upstart:14.04
MAINTAINER MidoNet (http://midonet.org)

# Install zookeeper and dependences
RUN apt-get -q update && \
#    apt-get install -qqy --no-install-recommends openjdk-7-jre-headless && \
    apt-get install -qqy zookeeper=3.4.5+dfsg-1 zookeeperd=3.4.5+dfsg-1

RUN cd /tmp && \
    wget https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.2/jolokia-jvm-1.3.2-agent.jar && \
    cd
RUN sed -i 's#JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=$JMXLOCALONLY"#JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=$JMXLOCALONLY -javaagent:/tmp/jolokia-jvm-1.3.2-agent.jar=port=8778,host=0.0.0.0"#g' /etc/init/zookeeper.conf

ADD bin/run-zookeeper.sh /run-zookeeper.sh
RUN chmod +x /run-zookeeper.sh

# Expose all zookeeper ports
EXPOSE 2181 2888 3888 8778

CMD ["/run-zookeeper.sh"]
