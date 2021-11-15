# syntax=docker/dockerfile:1.3
FROM eclipse-temurin:17 as jre-build

# Create a custom Java runtime
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base,java.compiler,java.datatransfer,java.desktop,java.instrument,java.logging,java.management,java.management.rmi,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.se,java.security.jgss,java.security.sasl,java.smartcardio,java.sql,java.sql.rowset,java.transaction.xa,java.xml,java.xml.crypto,jdk.accessibility,jdk.charsets,jdk.crypto.cryptoki,jdk.crypto.ec,jdk.dynalink,jdk.httpserver,jdk.incubator.foreign,jdk.incubator.vector,jdk.internal.vm.ci,jdk.internal.vm.compiler,jdk.internal.vm.compiler.management,jdk.jdwp.agent,jdk.jfr,jdk.jsobject,jdk.localedata,jdk.management,jdk.management.agent,jdk.management.jfr,jdk.naming.dns,jdk.naming.rmi,jdk.net,jdk.nio.mapmode,jdk.sctp,jdk.security.auth,jdk.security.jgss,jdk.unsupported,jdk.xml.dom,jdk.zipfs \
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
