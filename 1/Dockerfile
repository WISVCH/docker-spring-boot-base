# syntax=docker/dockerfile:1.3
FROM eclipse-temurin:8-jre

RUN groupadd -r spring-boot --gid=999 && useradd --no-log-init -r -g spring-boot --uid=999 spring-boot
USER 999
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
WORKDIR /srv
EXPOSE 8080
