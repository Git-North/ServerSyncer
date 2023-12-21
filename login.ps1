$fileformat = (get-date).ToUniversalTime().ToString(";d-MM-yyyy,HH.mm.ss")
(test-path creds) ? $null : (mkdir creds)
$MegaCreds = Get-Credential
$crednew = "./creds/creds.new"
$MegaCreds | Export-Clixml -Path $crednew
$creds = Import-Clixml -Path $crednew
$xmlname = $creds.username + $fileformat 
Rename-Item "$crednew" "$xmlname.xml"
#$creds.password | ConvertFrom-SecureString
$Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($creds.Password)
$result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
$result