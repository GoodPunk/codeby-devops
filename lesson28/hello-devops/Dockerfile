FROM maven:3.9.6-eclipse-temurin-17 AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml -DskipTests

FROM eclipse-temurin:17-jdk-jammy
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]
