# Remove OEM, retail, and volume keys from Windows

# Define variables for different types of product keys
$OEMKeys = "OA3xOriginalProductKey", "OA3xOriginalProductKeyBackup"
$RetailKeys = "DigitalProductId", "DigitalProductId4"
$VolumeKeys = "ProductKey"

# Remove OEM keys
ForEach ($Key in $OEMKeys) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name $Key -Value $null
}

# Remove retail keys
ForEach ($Key in $RetailKeys) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name $Key -Value $null
}

# Remove volume keys
ForEach ($Key in $VolumeKeys) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name $Key -Value $null
}

# Restart the Software Protection Service to apply changes
Restart-Service sppsvc

// Code By Smukx..
