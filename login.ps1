$date = (get-date).ToUniversalTime().ToString("dd-MM-yyyy,HH.mm.s")
(test-path creds) ? $null : (mkdir creds)
$MegaCreds = Get-Credential
$crednew = "./creds/creds.new"
$MegaCreds | Export-Clixml -Path $crednew
$creds = Import-Clixml -Path $crednew
Rename-Item "$crednew" $creds.UserName
#add $date

#$creds.password | ConvertFrom-SecureString

$Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($creds.Password)
$result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
$result