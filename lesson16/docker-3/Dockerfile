# Builder docker
FROM maven AS build
WORKDIR /app
COPY ./lesson16-webapp/complete/pom.xml .
COPY ./lesson16-webapp/complete/src ./src
RUN mvn clean package -DskipTests

# RUN docker
FROM openjdk:18-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
