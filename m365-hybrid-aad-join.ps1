# Import the required module
Import-Module -Name AzureAD

# Connect to Azure AD
Connect-AzureAD

# Define the domain and OU where the devices are located
$domain = "yourdomain.com"
$ou = "OU=Devices,DC=yourdomain,DC=com"

# Get the list of devices from the specified OU
$devices = Get-ADComputer -Filter * -SearchBase $ou

# Loop through each device and enable hybrid Azure AD join
foreach ($device in $devices) {
    $deviceName = $device.Name
    Write-Host "Enabling hybrid Azure AD join for device: $deviceName"

    # Register the device in Azure AD
    New-AzureADDevice -DisplayName $deviceName -AccountEnabled $true
}

Write-Host "Hybrid Azure AD join enabled for all devices in the specified OU."
