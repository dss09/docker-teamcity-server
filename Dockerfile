FROM smalllark/java
MAINTAINER Dmitri Sh <smalllark@gmail.com>

RUN apt-get -qq update && apt-get upgrade -y && \
    apt-get install -y dnsutils telnet git

# Install TeamCity Server.
ENV TEAMCITY_BUILD 71758
ENV TEAMCITY_VERSION 2019.2.1
RUN mkdir -p /usr/local/teamcity && \
    mkdir -p /var/lib/teamcity && \
    wget -nv https://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz -O /tmp/teamcity-$TEAMCITY_VERSION.tar.gz && \
    cd /usr/local/teamcity && tar xf /tmp/teamcity-$TEAMCITY_VERSION.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD ./etc /etc
EXPOSE 8111

CMD ["/sbin/my_init"]
