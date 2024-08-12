# Import the required module
Import-Module -Name 'AADConnect'

# Define the domain and OU where the devices are located
$domain = "yourdomain.com"
$ou = "OU=Devices,DC=yourdomain,DC=com"

# Get the list of devices from the specified OU
$devices = Get-ADComputer -Filter * -SearchBase $ou

# Loop through each device and enable hybrid Azure AD join
foreach ($device in $devices) {
    $deviceName = $device.Name
    Write-Host "Enabling hybrid Azure AD join for device: $deviceName"

    # Enable hybrid Azure AD join
    Set-AADIntDevice -DeviceName $deviceName -Domain $domain -EnableHybridAzureADJoin $true
}

Write-Host "Hybrid Azure AD join enabled for all devices in the specified OU."
