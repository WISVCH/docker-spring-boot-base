# Spring Boot base Docker image

In the following examples, replace the image tag by the correct value:

- `1` for Spring Boot 1.x (Java 8, supported until at least May 2026)
- `2.1` for Spring Boot 2.1 and newer (Java 11, supported until at least October 2024)
- `2.2` for Spring Boot 2.2.6 and newer (Java 14, supported until September 2020)

See the [AdoptOpenJDK release roadmap](https://adoptopenjdk.net/support.html#roadmap) for
more details.

## Multi-stage build example

```Dockerfile
FROM adoptopenjdk:11-hotspot AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew build

FROM docker.pkg.github.com/wisvch/docker-spring-boot-base/2.1
COPY --from=builder /src/build/libs/application.jar /srv/application.jar
CMD ["/srv/application.jar"]
```

## External build example

```Dockerfile
FROM docker.pkg.github.com/wisvch/docker-spring-boot-base/2.1
COPY ./build/libs/application.jar /srv/application.jar
CMD ["/srv/application.jar"]
```
