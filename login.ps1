$folderpath = ".\Creds"
$services = Get-ChildItem -Path $folderpath -Recurse -Directory | Sort-Object Name

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

        # Your existing code block using $importedData
        $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($importedData.Password)
        $result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
        [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)

        # Process $result or perform any additional actions
        Write-Host "Password result: $result"
    }
}
