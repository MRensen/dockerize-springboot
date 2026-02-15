

<#
.SYNOPSIS
    A script to Dockerize an application with a specific JDK version and sql dialect.

.DESCRIPTION
    This script allows you to run a Springboot application with Maven in docker. 
	You can specify the JDK version and sql dialect. 
	The -jdk parameter is optional (defaults to 17), and -sql is optional (defaults to postgesql).

.PARAMETER jdk
    The JDK version to use. This is an optional integer parameter. You can choose 17 or 21 (default)

.PARAMETER sql
    The sql database to use. This is an optional string parameter. You can choose "mysql" or "postgresql" (default)

.EXAMPLE
    ./dockerize.ps1 -jdk 21 -sql mysql
	This will Dockerize the application using JDK version 21 and using a mysql database.
    

.EXAMPLE
    ./dockerize.ps1
	This will Dockerize the application using JDK version 17 (default) and using the postgresql database (default)

.NOTES
    Author: Mark Rensen
    Date: 2024-09-30
	Version: 4.0
#>

Param(
    [Parameter(Mandatory=$false)]
    [int]$jdk = 17,
    
    [Parameter(Mandatory=$false)]
    [string]$sql = "postgresql" # Optional flag with a default value

    [Parameter(Mandatory=$false)]
    [switch]$kc
)

#Deze twee bewerkingen worden nu in de Dockerfile gedaan

#"setting up maven wrapper..."
#mvn -N wrapper:wrapper

#"applying 'mvn package -DskipTests' on project..."
#./mvnw package -DskipTests
"copying docker-compose and Dockerfile from C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts..."
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

if($sql -eq "mysql")
{
	"MySql"
	Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\mysql-compose\docker-compose.yml' -Destination .
}
else{
	"PostgreSql"
	Copy-Item 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\postgresql-compose\docker-compose.yml' -Destination .
}

if($kc)
{
    "Using kc"
    $rootDir = Get-Location
    $resourcesDir = "$rootDir/src/main/resources"

    # Functie om realm-bestanden te kopiëren naar resources directory
    function Copy-RealmFiles {
        param (
            [string]$sourceDir
        )

        # Haal realm bestanden in de opgegeven directory
        $realmFiles = Get-ChildItem -Path $sourceDir -Filter '*.json' | Where-Object { $_.Name -match 'realm' }

        foreach ($file in $realmFiles) {
            # Kopieer elk bestand naar de resources map
            Copy-Item -Path $file.FullName -Destination $resourcesDir -Force
        }
    }

    # Kopieer realm-bestanden vanuit het root project directory
    Copy-RealmFiles -sourceDir $rootDir

    # Kopieer realm-bestanden vanuit de bovenliggende directory
    $parentDir = (Get-Item $rootDir).Parent.FullName
    Copy-RealmFiles -sourceDir $parentDir
}


"Buidling with 'docker build -t'..."
docker build -t image .
"Starting with 'docker compose up -d'..."
docker compose up -d