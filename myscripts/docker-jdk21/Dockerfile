# version 4.0
# 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\dockerize.ps1'
# Use the Eclipse Temurin base image with JDK 17 (Alpine version)
FROM eclipse-temurin:21-jdk-alpine

# Install Maven
RUN apk add --no-cache maven

# Set the working directory
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml /app
COPY src /app/src

# Package the application using Maven (compile and build)
RUN mvn clean package -DskipTests

# Expose ports
EXPOSE 8080
EXPOSE 5432
EXPOSE 3307

## Copy the built JAR file to the container
#COPY target/*.jar application.jar

# Set the entry point to run the application
ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]
