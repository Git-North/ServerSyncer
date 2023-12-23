


$fileformat = (Get-Date).ToUniversalTime().ToString(";d-MM-yyyy,HH.mm.ss")
(test-path Creds) ? $null : (mkdir Creds\Mega,Creds\Git)
$MegaCreds = Get-Credential
$meganew = "./creds/mega/mega.new"
$MegaCreds | Export-Clixml -Path $meganew
#Compare-Object -ReferenceObject (Get-Content -Path $meganew) -DifferenceObject (Get-Content -Path .\Creds\Mega\*.xml) 


$creds = Import-Clixml -Path $meganew
$xmlname = $creds.username #+ $fileformat 
#note for later FIX $creds

$error.clear()

try { Rename-Item "$meganew" "$xmlname.xml" }
catch { "Cannot create a file when that file already exists." }
if (!$error) { "User Created" }
else {
    "User Exists, Would you like to overwrite?"
    Move-Item "$meganew" "$xmlname.xml" -Force -Confirm
}
