FROM ubuntu-upstart:14.04
MAINTAINER MidoNet (http://midonet.org)
RUN cd $HOME
RUN apt-get update
RUN apt-get install -y build-essential libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev git wget python-pip
RUN git clone https://github.com/openstack/rally.git
RUN ./rally/install_rally.sh
COPY conf/keystonerc /keystonerc
RUN mkdir -p /rally
#WORKDIR /rally
RUN mkdir -p /root/.rally/plugins
COPY conf/neutron_ports.py /root/.rally/plugins
COPY conf/rally-port-rps-plugin.yaml /root/.rally/plugins
RUN rally-manage db recreate
ADD bin/run-rally.sh /run-rally.sh
CMD ["/run-rally.sh"]
