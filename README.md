# Spring Boot base Docker image

In the following examples, replace the image tag by the correct value:

- `1` for Spring Boot 1.x (Java 8)
- `2.1` for Spring Boot 2.1 and newer (Java 11)

## Multi-stage build example

```Dockerfile
FROM quay.io/wisvch/openjdk:8-jdk AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew build

FROM quay.io/wisvch/spring-boot-base:1
COPY --from=builder /src/build/libs/application.jar /srv/application.jar
CMD ["/srv/application.jar"]
```

## External build example

```Dockerfile
FROM quay.io/wisvch/spring-boot-base:1
COPY ./build/libs/application.jar /srv/application.jar
CMD ["/srv/application.jar"]
```
