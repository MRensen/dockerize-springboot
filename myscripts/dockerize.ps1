"applying 'mvn package -DskipTests' on project..."
mvn package -DskipTests
"copying docker-compose and Dockerfile from C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts..."
Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\docker-compose.yml' -Destination .
Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\Dockerfile' -Destination .
"Buidling with 'docker build -t'..."
docker build -t image .
"Starting with 'docker compose up -d'..."
docker compose up -d