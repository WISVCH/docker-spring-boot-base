# syntax=docker/dockerfile:1.3
FROM eclipse-temurin:11-jre

ADD https://ch.tudelft.nl/certs/wisvch.crt /usr/local/share/ca-certificates/wisvch.crt
RUN chmod 0644 /usr/local/share/ca-certificates/wisvch.crt && \
    update-ca-certificates && \
    keytool -noprompt -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -importcert -alias wisvch -file /usr/local/share/ca-certificates/wisvch.crt
RUN groupadd -r spring-boot --gid=999 && useradd --no-log-init -r -g spring-boot --uid=999 spring-boot
USER 999
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
WORKDIR /srv
EXPOSE 8080
