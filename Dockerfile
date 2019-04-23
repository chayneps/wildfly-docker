FROM jboss/wildfly:14.0.1.Final

ENV MY_NODE_NAME default-node
USER root

COPY vulcan-entrypoint.sh /
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration

RUN chmod +x /vulcan-entrypoint.sh

WORKDIR /

RUN mkdir /webapps && mkdir -p /mnt/logs \
    && chown -R jboss:jboss /webapps \
    && ln -s /opt/jboss/wildfly /webapps/wildfly


EXPOSE 8080

ENTRYPOINT [ "/vulcan-entrypoint.sh" ]
