FROM smalllark/java
MAINTAINER Dmitri Sh <smalllark@gmail.com>

# Install Youtrack.
ENV TEAMCITY_VERSION 9.0.3
RUN mkdir -p /usr/local/teamcity
RUN mkdir -p /var/lib/teamcity
RUN wget -nv http://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz -O /tmp/teamcity-$TEAMCITY_VERSION.tar.gz
RUN cd /usr/local/teamcity && tar xvf /tmp/teamcity-$TEAMCITY_VERSION.tar.gz
ADD ./etc /etc
EXPOSE 8111
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
