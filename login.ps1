# Check if the 'Creds' directory exists, if not, create it along with 'Mega' and 'Git' subdirectories
(test-path .\Creds) ? $null : (mkdir .\Creds\Mega, .\Creds\Git)

# Check if there are any .xml files inside the 'Creds' folder recursively
$xmlFiles = Get-ChildItem -Path ".\Creds" -Recurse -Filter *.xml

if (-not $xmlFiles) {
    Write-Host "No User credential files found. Running registration script..."
    & "register.ps1"
}
else {
    Write-Host "User credential files found. Proceeding with login..."
    # The rest of your login script goes here
    # ...
}

function Get-DecryptedPassword {
    param (
        [securestring]$SecurePassword
    )

    $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($SecurePassword)
    $DecryptedPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)

    return $DecryptedPassword
}

$folderpath = ".\Creds"
$services = Get-ChildItem -Path $folderpath -Recurse -Directory | Sort-Object Name

# Define variables to store usernames and passwords
$GitUsername = $null
$GitPassword = $null
$MegaUsername = $null
$MegaPassword = $null

foreach ($service in $services) {
    $serviceName = $service.Name
    $files = Get-ChildItem -Path $service.FullName -Recurse

    $fileObjects = foreach ($file in $files) {
        [PSCustomObject]@{
            Service       = $serviceName
            Username      = $file.BaseName  # Display only the file name without extension
            LastWriteTime = $file.LastWriteTime
        }
    }

    $fileObjects | Format-Table -AutoSize

    $selectedFile = $null

    while ($selectedFile -eq $null) {
        $selectedFileName = Read-Host "Enter the username (file name without extension) to process (press Enter to end)"
        
        if (-not $selectedFileName) {
            break  # Exit the loop if the user presses Enter without typing anything
        }

        $selectedFile = $files | Where-Object { $_.BaseName -eq $selectedFileName }

        if ($selectedFile -eq $null) {
            Write-Host "File not found. Please enter a valid username."
        }
    }

    if ($selectedFile -ne $null) {
        $importedData = Import-Clixml -Path $selectedFile.FullName

        # Store usernames and passwords in respective variables based on the service name
        switch ($serviceName) {
            'Git' {
                $GitUsername = $selectedFileName
                $GitPassword = Get-DecryptedPassword -SecurePassword $importedData.Password
            }
            'Mega' {
                $MegaUsername = $selectedFileName
                $MegaPassword = Get-DecryptedPassword -SecurePassword $importedData.Password
            }
            # Add more cases for other services if needed
        }
    }
}
# 
# # Use the usernames and passwords as needed
# Write-Host "Git Username: $GitUsername"
# Write-Host "Git Password: $GitPassword"
# Write-Host "Mega Username: $MegaUsername"
# Write-Host "Mega Password: $MegaPassword"
