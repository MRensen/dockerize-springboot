# version 4.0
# 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\dockerize.ps1'
# Use the Eclipse Temurin base image with JDK 17 (Alpine version)
FROM eclipse-temurin:17-jdk-alpine

# Install Maven
RUN apk add --no-cache maven
# Install curl
RUN apk --no-cache add curl
# Install jq
RUN apk --no-cache add jq
# Tool for switch line endings
RUN apk add --no-cache dos2unix

# Set the working directory
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml /app
COPY src /app/src

#Copy the kc export
COPY kc /app/kc

#Copy the entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN dos2unix /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Package the application using Maven (compile and build)
RUN mvn clean package -DskipTests

# Expose ports
EXPOSE 8080
EXPOSE 5432
EXPOSE 3307

# Set the entry point to run the application
ENTRYPOINT ["/app/entrypoint.sh"]
