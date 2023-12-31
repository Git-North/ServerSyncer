($ip = Read-Host -Prompt 'Please Enter Your Server IP')
curl -k -s https://api.mcsrvstat.us/2/$ip -O 

   
if(test-path .\*server.json) {

    $file=Get-Item .\*.server.json
    echo $file.Basename
    
    } else {
   echo 0
     }
  
Get-Content .\$ip | % {$_ -replace "§","" } | Out-File .\$ip.server.json -Force
Remove-Item .\$ip -Force
$ip.server.json -replace '(?m)(?<=^([^"]|"[^"]*")*)//.*' -replace '(?ms)/\*.*?\*/'
$server = Get-Content -Raw  ".\$ip.server.json" | ConvertFrom-Json 
$server | Select-Object -ExcludeProperty icon