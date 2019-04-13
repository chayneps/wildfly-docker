FROM openjdk:8u201-jdk-alpine3.9

ENV WILDFLY_VERSION 14.0.1.Final

RUN apk add bash
RUN apk add curl

COPY vulcan-entrypoint.sh /
RUN chmod +x /vulcan-entrypoint.sh

WORKDIR /

RUN mkdir /webapps && mkdir /webapps/logs \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar -C /webapps -zxf wildfly-$WILDFLY_VERSION.tar.gz \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

EXPOSE 8080

ENTRYPOINT [ "/vulcan-entrypoint.sh" ]
