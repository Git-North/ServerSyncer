echo "Please Enter Your Email Address" 
Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath "./mail.encrypted"
echo "Please Enter Your Password"
Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath "./pass.encrypted"
