FROM ubuntu-upstart:14.04
MAINTAINER MidoNet (http://midonet.org)

ONBUILD ADD conf/midonet.list /etc/apt/sources.list.d/midonet.list
ONBUILD ADD bin/run-midolman.sh /run-midolman.sh
ADD src/fake_snort.c /tmp/fake_snort.c

ONBUILD RUN curl -k http://repo.midonet.org/packages.midokura.key | apt-key add -
ONBUILD RUN curl -k http://builds.midonet.org/midorepo.key | apt-key add -
ONBUILD RUN apt-get -qy update
ONBUILD RUN apt-get install -qy --force-yes midolman zkdump python-setproctitle

RUN apt-get -qy update
RUN apt-get -qy install git mz tcpdump nmap iptables telnet traceroute --no-install-recommends

# Install Java 8
RUN apt-get install -qy software-properties-common
RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update && apt-get install -qy openjdk-8-jdk openjdk-7-jdk --no-install-recommends

# get deps and compile fake snort
RUN apt-get install -qy libpcap-dev
RUN gcc -o /usr/bin/fake_snort /tmp/fake_snort.c -lpcap

# Get pipework to allow arbitrary configurations on the container from the host
# Might get included into docker-networking in the future
RUN git clone http://github.com/jpetazzo/pipework /pipework
RUN mv /pipework/pipework /usr/bin/pipework

# Workaround to circumvent limitations with AppArmor profiles and docker
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
RUN mv /sbin/dhclient /usr/bin/dhclient

RUN apt-get update && apt-get install -qy curl && apt-get install -qy git

# Expose bgpd port in case it's a gateway
EXPOSE 179

CMD ["/run-midolman.sh"]
