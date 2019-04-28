FROM jboss/wildfly:14.0.1.Final

ENV MY_NODE_NAME default-node

USER jboss

COPY standalone.xml /opt/jboss/wildfly/standalone/configuration

USER root
WORKDIR /
COPY init.sh /
COPY entrypoint.sh /

RUN chmod +x /init.sh /entrypoint.sh \
	&& mkdir /webapps && mkdir -p /mnt/logs \
    && chown -R jboss:jboss /mnt/logs \
    && chown -R jboss:jboss /webapps \
    && ln -s /opt/jboss/wildfly /webapps/wildfly \
    && rm -rf /opt/jboss/wildfly/welcome-content/* \
    && touch /opt/jboss/wildfly/welcome-content/test.html

EXPOSE 8080

USER jboss
ENTRYPOINT [ "/entrypoint.sh" ]
