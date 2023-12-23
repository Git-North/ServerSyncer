# Check if the 'Creds' directory exists, if not, create it along with 'Mega' and 'Git' subdirectories
(test-path Creds) ? $null : (mkdir Creds\Mega, Creds\Git)

while ($true) {
    # Prompt the user to choose between Mega, Git, or exit
    Write-Host "Choose service (`1` for Mega,` 2` for Git,` 0` to exit)"
    $key = [System.Console]::ReadKey($true).KeyChar

    # Validate the user's choice
    switch ($key) {
        '1' {
            $service = 'Mega'
            break
        }
        '2' {
            $service = 'Git'
            break
        }
        '0' {
            Write-Host "Exiting."
            exit
        }
        default {
            Write-Host "Invalid selection. Press any key to try again or '0' to exit."
            $keyToExit = [System.Console]::ReadKey($true).KeyChar
            if ($keyToExit -eq '0') {
                Write-Host "Exiting."
                exit
            }
            else {
                continue
            }
        }
    }

    # Check if a valid selection was made before prompting for credentials
    if ($service -eq 'Mega' -or $service -eq 'Git') {
        # Get credentials from the user based on the chosen service
        $credPrompt = "Enter $service credentials"
        $serviceCreds = Get-Credential -Message $credPrompt

        # Define the path for the new credentials file
        $newCredsPath = "./creds/$service/$service.new"

        # Export credentials to a new file
        $serviceCreds | Export-Clixml -Path $newCredsPath

        # Import the exported credentials
        $creds = Import-Clixml -Path $newCredsPath

        # Extract the username from the credentials (Note: It's good to fix this as per your comment)
        $xmlname = $creds.username

        # Error handling
        $error.clear()

        try {
            # Try to rename the file from '$service.new' to 'username.xml'
            Rename-Item $newCredsPath "$xmlname.xml"
        }
        catch {
            # Handle the case where the file already exists
            Write-Host "Cannot create a file when that file already exists."
        }

        # Check for errors and provide feedback
        if (!$error) {
            "User Created for $service"
        }
        else {
            "User Exists for $service, Would you like to overwrite?"
            # Move the new file to the desired location, overwriting the existing one if confirmed
            Move-Item $newCredsPath "$xmlname.xml" -Force -Confirm
            
        }
    Remove-Item $newCredsPath -Force 
    }
}
