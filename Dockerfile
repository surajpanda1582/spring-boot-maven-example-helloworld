FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD

MAINTAINER Suraj Panda

COPY pom.xml /build/

COPY src/main /build/src

WORKDIR /build/

RUN mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/*.war /app/app.war
ENTRYPOINT ["java", "-jar", "app.war"]
