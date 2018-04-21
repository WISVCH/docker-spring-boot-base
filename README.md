# Spring Boot base Docker image

## Multi-stage build example
```Dockerfile
FROM wisvch/openjdk:8-jdk AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew build

FROM wisvch/spring-boot-base:1
COPY --from=builder /src/build/libs/application.jar /srv/application.jar
USER 999
CMD ["/srv/application.jar"]
```

## External build example
```Dockerfile
FROM wisvch/spring-boot-base:1
COPY ./build/libs/application.jar /srv/application.jar
USER 999
CMD ["/srv/application.jar"]
```
