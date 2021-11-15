# syntax=docker/dockerfile:1.3
FROM eclipse-temurin:17 as jre-build

# Create a custom Java runtime
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base,java.logging \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# Build base image with JRE
FROM ghcr.io/wisvch/debian:bullseye-slim
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# Trust CH CA certificate by adding it to the JRE cacerts keystore
RUN keytool -noprompt -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -importcert -alias wisvch -file /usr/local/share/ca-certificates/wisvch.crt

# Download Datadog Java agent
ADD --chmod=0444 https://search.maven.org/remote_content?g=com.datadoghq&a=dd-java-agent&v=LATEST /opt/datadog/dd-java-agent.jar

# Create spring-boot user
RUN groupadd -r spring-boot --gid=999 && useradd --no-log-init -r -g spring-boot --uid=999 spring-boot
USER 999

# Set up entrypoint
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
WORKDIR /srv
EXPOSE 8080
