Version 3.3

# INSTALLATIE:

1. Zorg dat java en maven op je computer geinstalleerd staan en op je PATH staan. (Instructies:[java](https://www.java.com/nl/download/help/path.html), [maven](https://www.baeldung.com/install-maven-on-windows-linux-mac))
2. Download Docker Desktop
3. plak de 'myscripts'-map in _windows\system32\windowspowershell\v1.0_
4. open profile.ps1 in _windows\system32\windowspowershell\v1.0_
5. voeg de regel toe: `Set-Alias -Name dockerize -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\dockerize.ps1'
6. (Optioneel) Voeg ook `Set-Alias -Name dedockerize -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\dedockerize.ps1'` toe aan profile.ps1.
7. (Optioneel) Voeg ook `Set-Alias -Name authreset -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\MyScripts\authreset.ps1`
7. herstart powershell

# GEBRUIK:

1. open powershell in de root folder van een SpringBoot project (zie ook [bonus](#BONUS))
  (de map waar o.a. pom.xml en 'src' in staan)
2. type: 'dockerize' (sluit het powershell venster niet)
3. Voeg optioneel een parameter toe voor de JDK, zoals 'dockerize 21'. Op dit moment wordt alleen JDK 21 ondersteund en JDK 17 is de default.
4. Vouw in Docker Desktop de nieuw gemaakte collectie open, ga naar de 'app' container. 
  Wanneer het icoontje van deze container groen is, is de applicatie gestart. Tevens kun je hier de log van de Spring Boot applicatie zien.
5. Ga naar de 'db' container en klik het 'terminal' tabblad. Hier kun je met psql de database uitlezen. 

- Het "dedockerize" commando is een makkelijke manier om je docker instance weer af te sluiten als je klaar bent. 
Dit doe je door een powershell venster te openen in de root map van het project (of het zelfde powershell venster dat je voor "dockerize" gebruikt hebt) en daar "dedockerize" uit te voeren.
- Het "authreset" commando is een makkelijke manier om alle auth headers van je postman collectie op default te zetten (inherit from parent).
Je gebruikt dit commando door het in powershell uit te voeren in de folder waar het .postman_collection.json file staat.

# PSQL
  Log in bij psql met: 
  
	`psql -U postgres`
	
  Maak verbinging met de 'testing' database: 
  
	`\c testing`
	
  Bekijke welke tabellen in de database zitten: 
  
	`\dt`
	
  Vraag data van een secifieke tabel op met een SQL query, zoals
  
	`select * from users;` (vergeet de ; niet)
	
  Enkele andere psql commando's:
  - `\?` list all the commands
  - `\l` list databases
  - `\conninfo` display information about current connection
  - `\c [DBNAME]` connect to new database, e.g., \c template1
  - `\dt` list tables of the public schema
  - `\dt` <schema-name>.* list tables of certain schema, e.g., \dt public.*
  - `\dt` *.* list tables of all schemas


Then you can run SQL statements, e.g., SELECT * FROM my_table;(Note: a statement must be terminated with semicolon ;)
  - `\q` quit psql

# AFSLUITEN:

1. In hetzelfde PowerShell venster waar je 'dockerize' hebt getypt, type je nu:
	`docker compose down` of `dedockerize` (als je dat hebt ingesteld bij de installatie)
2. De container is afgesloten, je kunt het PowerShell venster nu sluiten.

# BONUS
Een makkelijke manier om Powershell te openen in de root folder van een springboot project is door er een context menu item voor te maken.

1. Type `Windows + R` 
2. Run `regedit`
3. Navigeer naar `Computer\HKEY_CLASSES_ROOT\Directory\Background\shell\`
4. Rechter muisknop op de "shell" key (ziet er uit als een map) en selecteer "new" en dan "key". Noem de nieuwe key `PowerShell`
5. In de nieuwe "PowerShell" key, dubbelklik op de "(Default)" entry en zet die waarde naar "Open PowerShell here"
6. Rechter muisknop op de "PowerShell" key en selecteer "new" en dan "key". Noem de nieuwe key `command`.
7. In de nieuwe "command" key, dubbelklik op de "(Default)" entry en zet die waarde naar `powershell.exe -noexit -command Set-Location -literalPath '%V'`

Wanneer je nu een nieuwe map opent en `shift + rechter muisknop` doet, dan zie je als het goed is de optie "Open PowerShell here"

# TROUBLESHOOTING

- De volgende error: 
`java.lang.NoSuchFieldError: Class com.sun.tools.javac.tree.JCTree$JCImport does not have member field 'com.sun.tools.javac.tree.JCTree qualid'`
Kan veroorzaakt worden door een oude lombok versie. Update de lombok dependency in de pom.xml van het project naar versie 1.18.32 of hoger
  
# Changelog
- v3.3: De compose file kopieert nu ook de /src map naar de container, zodat de applicatie daar toegang toe heeft. 
Projecten met hardcoded file paths crashen hierdoor niet meer.