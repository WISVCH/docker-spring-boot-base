# Spring Boot base Docker image

In the following examples, replace the image tag by the correct value:

- `1` for Spring Boot 1.x (Java 8 LTS, supported until at least November 2026)
- `2.1` for Spring Boot 2.1 and newer (Java 11 LTS, supported until at least October 2027)
- `2.5.5` for Spring Boot 2.5.5 and newer (Java 17 LTS, support until at least October 2027)

See the [Adoptium release roadmap](https://adoptium.net/support#roadmap) for
more details.

## Multi-stage build example

```Dockerfile
FROM eclipse-temurin:17 AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew build

FROM ghcr.io/wisvch/spring-boot-base:2.5.5
COPY --from=builder /src/build/libs/application.jar /srv/application.jar
CMD ["/srv/application.jar"]
```

## External build example

```Dockerfile
FROM ghcr.io/wisvch/spring-boot-base:2.5.5
COPY ./build/libs/application.jar /srv/application.jar
CMD ["/srv/application.jar"]
```
