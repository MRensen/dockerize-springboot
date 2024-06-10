#version 1

$content = Get-Content ./*postman_collection.json -Raw
$modifiedContent = $content -replace '"auth": \{[^}]*\}\s+]\s+\},', ''
Set-Content ./*postman_collection.json -Value $modifiedContent