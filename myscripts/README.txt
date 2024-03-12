INSTALLATIE:

1 Download Docker Desktop
2 plak de 'myscripts'-map in windows\system32\windowspowershell\v1.0
3 open profile.ps1 in windows\system32\windowspowershell\v1.0
4 voeg de regel toe: Set-Alias -Name dockerize -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts/dockerize.ps1'
5 herstart powershell

GEBRUIK:

1 open powershell in de root folder van een SpringBoot project 
  (de map waar o.a. pom.xml en 'src' in staan)
2 type: 'dockerize' (sluit het powershell venster niet)
3 Vouw in Docker Desktop de nieuw gemaakte collectie open, ga naar de 'app' container. 
  Wanneer het icoontje van deze container groen is, is de applicatie gestart. Tevens kun je hier de log van de Spring Boot applicatie zien.
4 Ga naar de 'db' container en klik het 'terminal' tabblad. Hier kun je met psql de database uitlezen. 
  Log in bij psql met: 
	psql -U postgres
  Maak verbinging met de 'testing' database: 
	\c testing
  Bekijke welke tabellen in de database zitten: 
	\dt
  Vraag data van een secifieke tabel op met een SQL query.
  Enkele andere psql commando's: 
	\? list all the commands
	\l list databases
	\conninfo display information about current connection
	\c [DBNAME] connect to new database, e.g., \c template1
	\dt list tables of the public schema
	\dt <schema-name>.* list tables of certain schema, e.g., \dt public.*
	\dt *.* list tables of all schemas
	Then you can run SQL statements, e.g., SELECT * FROM my_table;(Note: a statement must be terminated with semicolon ;)
	\q quit psql

AFSLUITEN:

1 In hetzelfde PowerShell venster waar je 'dockerize' hebt getypt, type je nu:
	docker compose down
2 De container is afgesloten, je kunt het PowerShell venster nu sluiten.