# version 3.1

$jdk = $args[0]

"Applying 'mvn package -DskipTests' on project..."
./mvnw package -DskipTests
"Copying docker-compose and Dockerfile from C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts..."
if($jdk -eq 21)
{
	"JDK 21"
	Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\docker-jdk21\Dockerfile' -Destination .
}
else
{
	"JDK 17"
	Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\docker-jdk17\Dockerfile' -Destination .

}
Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\docker-compose.yml' -Destination .
"Buidling with 'docker build -t'..."
docker build -t image .
"Starting with 'docker compose up -d'..."
docker compose up -d