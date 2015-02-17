FROM ubuntu:14.04

MAINTAINER <stephane.rault@radicalspam.org>

ENV DEFAULT_USER root
ENV DEFAULT_PASSWORD root

RUN apt-get update -y -q

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ca-certificates \
  software-properties-common \
  unzip \
  wget

RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y -q
RUN apt-get install -y --no-install-recommends nginx
  
RUN wget https://github.com/joewalnes/websocketd/releases/download/v0.2.10/websocketd-0.2.10-linux_amd64.zip && \
  unzip websocketd-0.2.10-linux_amd64.zip -d . && \
  mv websocketd /usr/local/bin && \
  rm -f websocketd-0.2.10-linux_amd64.zip
  
RUN git clone https://github.com/joewalnes/web-vmstats.git /usr/local/web-vmstats
  
RUN rm -f /etc/nginx/sites-enabled/* /etc/nginx/sites-available/*
RUN mkdir -vp /var/log/nginx && chown www-data /var/log/nginx

ADD nginx.conf /etc/nginx/

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /usr/local/web-vmstats

CMD ["/usr/local/bin/start.sh"]

EXPOSE 80
EXPOSE 8010
