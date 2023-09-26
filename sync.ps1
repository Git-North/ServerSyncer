#iex .\login.ps1
$EncryptedMegaMail= Get-Content “./mail.encrypted” 
$SecurePassword= Get-Content “./pass.encrypted”

$SecurePassword = ConvertTo-SecureString $PlainPassword -AsPlainText -Force
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
#mega-login 