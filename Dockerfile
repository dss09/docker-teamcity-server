FROM smalllark/java
MAINTAINER Dmitri Sh <smalllark@gmail.com>

RUN apt-get install -y dnsutils telnet

# Install TeamCity Server.
ENV TEAMCITY_VERSION 9.1.1
RUN mkdir -p /usr/local/teamcity && \
    mkdir -p /var/lib/teamcity && \
    wget -nv http://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz -O /tmp/teamcity-$TEAMCITY_VERSION.tar.gz && \
    cd /usr/local/teamcity && tar xvf /tmp/teamcity-$TEAMCITY_VERSION.tar.gz
ADD ./etc /etc
EXPOSE 8111

CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
