$fileformat = (get-date).ToUniversalTime().ToString(";d-MM-yyyy,HH.mm.ss")
(test-path creds) ? $null : (mkdir creds)
$MegaCreds = Get-Credential
$crednew = "./creds/mega/mega.new"
$MegaCreds | Export-Clixml -Path $crednew
$creds = Import-Clixml -Path $crednew
$xmlname = $creds.username + $fileformat 
Rename-Item "$crednew" "$xmlname.xml"

# note for later FIX $creds


#$creds.password | ConvertFrom-SecureString
$Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($creds.Password)
$result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
$result
Get-ChildItem -Recurse ".\creds" | Where { ! $_.PSIsContainer } | Select Name,FullName,Length