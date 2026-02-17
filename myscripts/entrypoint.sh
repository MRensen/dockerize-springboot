#!/bin/sh

# Haal de realm uit JSON
REALM=$(jq -r '.realm' ./kc/*.json)
JAVA_OPTS="-Dspring.security.oauth2.resourceserver.jwt.issuer-uri=http://kc:9090/realms/$REALM"

# Wacht tot Keycloak beschikbaar is
until curl -s http://kc:9000/health/ready | grep 'UP' > /dev/null; do
  echo 'Wachten op Keycloak...'
  sleep 5
done

# Start de Java applicatie
exec java $JAVA_OPTS -jar target/*.jar
#exec java -jar target/*.jar