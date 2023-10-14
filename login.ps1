$MegaCreds = Get-Credential
$credpath = "./creds/mega.encrypted"
$MegaCreds | Export-Clixml -Path $credpath
$credpath = Import-Clixml -Path $credpath








#$pw = Read-Host -AsSecureString
#[pscredential]::new('user',$pw).GetNetworkCredential().Password
#$pw | ConvertFrom-SecureString | Out-File -FilePath "./pass.encrypted"
#$encStr = Get-Content "./pass.encrypted"
#$encStr | ConvertFrom-SecureString 


#echo "Please Enter Your Email Address" 
# Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath "./mail.encrypted"
# echo "Please Enter Your Password"
# Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath "./pass.encrypted"
