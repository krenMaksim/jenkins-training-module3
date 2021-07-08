
# syntax=docker/dockerfile:1

FROM openjdk:11-jre
RUN groupadd -r spring && useradd --no-log-init -r -g spring spring-app
USER spring-app
EXPOSE 8080
COPY /target/module3-*.jar /module3.jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "-Xms125m", "-Xmx256m", "/module3.jar"]
