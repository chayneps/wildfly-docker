FROM jboss/wildfly:14.0.1.Final

USER root

COPY vulcan-entrypoint.sh /
RUN chmod +x /vulcan-entrypoint.sh

WORKDIR /

RUN mkdir /webapps && mkdir /webapps/logs \
    && chown -R jboss:jboss /webapps \
    && ln -s /opt/jboss/wildfly /webapps/wildfly

EXPOSE 8080

ENTRYPOINT [ "/vulcan-entrypoint.sh" ]
