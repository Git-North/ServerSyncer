$folderpath = ".\Creds"
$service = Get-Childitem -Path $folderpath -recurse -Dir
$user = Get-Childitem -Path $service -recurse 
$user | Select-Object Name,LastWriteTime
