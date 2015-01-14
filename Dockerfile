FROM influxdb
MAINTAINER "Deven Phillips <dphillips@zanclus.com>"

RUN mkdir /build
WORKDIR /build
RUN apt-get update
RUN apt-get install -y wget vim net-tools tar gzip bzip2 nginx supervisor curl
RUN wget http://grafanarel.s3.amazonaws.com/grafana-1.9.0.tar.gz
RUN tar -xzf grafana-1.9.0.tar.gz
RUN mv grafana-1.9.0 /usr/share/nginx/html/graphana
RUN sed -i 's/listen 80 default_server/listen 6080 default_server/g' /etc/nginx/sites-enabled/default
ADD ./config.js /usr/share/nginx/html/graphana/
RUN chmod 755 /usr/share/nginx/html/graphana/config.js
RUN sed -i '/^exec/i /etc/init.d/nginx start' /run.sh

EXPOSE 6080
