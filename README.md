# Spring Boot base Docker image

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
