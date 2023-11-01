FROM maven:3-openjdk-18-slim AS build

COPY src/ /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app/

RUN mvn package

FROM eclipse-temurin:latest

EXPOSE 9000

COPY --from=build /home/app/target/springboot-hello-world.jar /data/springboot-hello-world.jar

CMD ["java","-jar","/data/springboot-hello-world.jar"]
