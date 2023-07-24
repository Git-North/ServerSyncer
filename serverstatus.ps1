function new-ip {
    ($ip = Read-Host -Prompt 'Please Enter Your Server IP')
}
curl -k -s https://api.mcsrvstat.us/2/$ip -O 

if(test-path *server.json) {
    echo 1
     }else {
        echo 0
     }
new-ip
Get-Content .\$ip | % {$_ -replace "§","" } | Out-File .\$ip.server.json -Force
Remove-Item .\$ip -Force
$ip.server.json -replace '(?m)(?<=^([^"]|"[^"]*")*)//.*' -replace '(?ms)/\*.*?\*/'
$server = Get-Content -Raw  ".\$ip.server.json" | ConvertFrom-Json 
$server | Select-Object -ExcludeProperty icon
