
$Server = Read-Host -Prompt 'Please Enter Your Server IP'

curl -k -s https://api.mcsrvstat.us/2/$Server -O

Get-Content .\$server | % {$_ -replace "§","" } | Out-File .\$server.server.json -Force
Remove-Item .\$server -Force
$server.server.json -replace '(?m)(?<=^([^"]|"[^"]*")*)//.*' -replace '(?ms)/\*.*?\*/'
Get-Content -Raw  ".\$Server.server.json" | ConvertFrom-Json | Select-Object -Property online 

# https://stackoverflow.com/questions/14406315/how-to-get-an-objects-propertys-value-by-property-name