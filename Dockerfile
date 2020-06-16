FROM adoptopenjdk/openjdk8-openj9:slim

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 14.0.1.Final
ENV WILDFLY_SHA1 757d89d86d01a9a3144f34243878393102d57384
ENV JBOSS_HOME /opt/jboss/wildfly

USER root
RUN groupadd --gid 1000 jboss \
    && useradd --uid 1000 --gid 1000 jboss

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN mkdir -p /opt/jboss \
    && cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true
#
ENV MY_NODE_NAME default-node

WORKDIR /
COPY init.sh /

RUN chmod +x /init.sh \
    && mkdir /webapps \
    && mkdir -p /mnt/logs \
    && mkdir -p /mnt/aft \
    && chown -R jboss:jboss /mnt/logs \
    && chown -R jboss:jboss /webapps \
    && ln -s /opt/jboss/wildfly /webapps/wildfly \
    && rm -rf /opt/jboss/wildfly/welcome-content/* \
    && touch /opt/jboss/wildfly/welcome-content/test.html

RUN apt-get update \
    && apt-get install -y unzip \
    && apt-get install -y less \
    && apt-get install -y lnav \
    && apt-get install -y busybox

RUN busybox --install

EXPOSE 8080

USER jboss
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration

ENTRYPOINT [ "bash","-c","exec /webapps/wildfly/bin/standalone.sh -b 0.0.0.0 > /webapps/logs/wildfly.log 2>&1" ]
