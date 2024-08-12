# Define the path to the existing RDP file
$rdpFilePath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "SPM Incloud.rdp")

# Ensure the file is not read-only
if ((Get-Item $rdpFilePath).Attributes -band [System.IO.FileAttributes]::ReadOnly) {
    (Get-Item $rdpFilePath).Attributes = (Get-Item $rdpFilePath).Attributes -bxor [System.IO.FileAttributes]::ReadOnly
}

# Get the current user's Microsoft Entra account
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

# Debugging output to check the current user
Write-Output "Current User (WindowsIdentity): $currentUser"

# Define a mapping of Microsoft Entra usernames to RemoteApp credentials
$userCredentials = @{
    "RickyCunningham" = @{ Username = "incloud\colorectal08"; Password = "colonicPOLYp08" }
    "Sally"           = @{ Username = "incloud\colorectal01"; Password = "colonicPOLYp01" }
    # Add more users as needed
}

# Extract the username part of the current user
$currentUserName = $currentUser.Split('\')[-1].Split('@')[0]

# Debugging output to check the extracted username
Write-Output "Extracted Username: $currentUserName"

# Check if the current user has a corresponding RemoteApp credential
if ($userCredentials.ContainsKey($currentUserName)) {
    $remoteAppUsername = $userCredentials[$currentUserName].Username
    $remoteAppPassword = $userCredentials[$currentUserName].Password

    # Read the existing RDP file content
    $rdpContent = Get-Content -Path $rdpFilePath

    # Update the RDP file content with the new username
    $rdpContent = $rdpContent -replace 'username:s:.*', "username:s:$remoteAppUsername"

    # Save the modified RDP file
    $rdpContent | Set-Content -Path $rdpFilePath -Encoding ASCII

    # Store the credentials in the Windows Credential Manager
    cmdkey /generic:"$remoteAppUsername" /user:"$remoteAppUsername" /pass:"$remoteAppPassword"

    # Output the current user and RemoteApp configuration
    Write-Output "Current User: $currentUserName"
    Write-Output "RemoteApp Username: $remoteAppUsername"
    Write-Output "RDP file updated at: $rdpFilePath"

    # Launch the RemoteApp
    & "mstsc" $rdpFilePath

    # Remove the stored credentials after use
    Start-Sleep -Seconds 5
    cmdkey /delete:"$remoteAppUsername"
} else {
    Write-Output "No RemoteApp credentials found for user: $currentUserName"
}

