FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD

MAINTAINER Suraj Panda

COPY /workspace/source/pom.xml /build/

COPY /workspace/source/src /build/src/

WORKDIR /build/

RUN mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
