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
}
# 
# $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($creds.Password)
# $result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
# [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
# #$result