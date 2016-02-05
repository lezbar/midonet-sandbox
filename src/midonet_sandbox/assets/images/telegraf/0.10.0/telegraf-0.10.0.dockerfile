FROM ubuntu-upstart:14.04
MAINTAINER MidoNet (http://midonet.org)
ENV TELEGRAF_VERSION=0.10.1-1
RUN cd $HOME
RUN apt-get update && apt-get install -y curl
RUN curl -s -o /tmp/telegraf_latest_amd64.deb http://get.influxdb.org/telegraf/telegraf_${TELEGRAF_VERSION}_amd64.deb && \
  dpkg -i /tmp/telegraf_latest_amd64.deb && \
  rm /tmp/telegraf_latest_amd64.deb && \
  rm -rf /var/lib/apt/lists/*
RUN mkdir /telegraf_conf
COPY conf/telegraf.conf /telegraf_conf/telegraf.conf

ADD bin/run-telegraf.sh /run-telegraf.sh
RUN chmod +x /run-telegraf.sh
#RUN telegraf -config /telegraf_conf/telegraf.conf -output-filter influxdb -quiet &
CMD ["/run-telegraf.sh"]

