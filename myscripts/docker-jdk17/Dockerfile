# version 3.1
# 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts/dockerize.ps1'
FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
EXPOSE 8080
EXPOSE 5432
COPY target/*.jar application.jar
ENTRYPOINT ["java", "-jar", "application.jar"]
