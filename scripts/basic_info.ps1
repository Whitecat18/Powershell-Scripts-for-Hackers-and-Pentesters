<#
    Scripts managed by https://github.com/Whitecat18
    For more info, visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters
    This script lists out BIOS Version, Network Adapters, Installed System software, and System Uptime.
#>

function Get-PCInformation {
    try {
        $computerSystem = Get-WmiObject Win32_ComputerSystem
        $processor = Get-WmiObject Win32_Processor
        $diskDrives = Get-WmiObject Win32_DiskDrive
        $operatingSystem = Get-WmiObject Win32_OperatingSystem
        $bios = Get-WmiObject Win32_BIOS
        $networkAdapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
        $installedSoftware = Get-WmiObject Win32_Product
        $lastBootUpTime = (Get-WmiObject Win32_OperatingSystem).LastBootUpTime
        $uptime = (Get-Date) - ([System.Management.ManagementDateTimeConverter]::ToDateTime($lastBootUpTime))

        $networkAdaptersInfo = $networkAdapters | ForEach-Object { "$($_.Description): $($_.IPAddress -join ', ')" }
        $installedSoftwareInfo = $installedSoftware | ForEach-Object { $_.Name }

        $pcInfo = @{
            'ComputerName'       = $env:COMPUTERNAME
            'Manufacturer'       = $computerSystem.Manufacturer
            'Model'              = $computerSystem.Model
            'RAM'                = '{0:N2} GB' -f ($computerSystem.TotalPhysicalMemory / 1GB)
            'Processor'          = $processor.Name
            'Storage'            = '{0:N2} TB' -f (($diskDrives | Measure-Object Size -Sum).Sum / 1TB)
            'WindowsVersion'     = $operatingSystem.Caption
            'BIOSVersion'        = $bios.SMBIOSBIOSVersion
            'NetworkAdapters'    = $networkAdaptersInfo -join '; '
            'InstalledSoftware'  = $installedSoftwareInfo -join ', '
            'SystemUptime'       = "$($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"
        }

        return $pcInfo
    }
    catch {
        Write-Error "An error occurred while retrieving PC information: $_"
        return $null
    }
}

$pcInformation = Get-PCInformation

if ($pcInformation -ne $null) {
    $output = @"
Computer Information:
Computer Name: $($pcInformation['ComputerName'])
Manufacturer: $($pcInformation['Manufacturer'])
Model: $($pcInformation['Model'])
RAM: $($pcInformation['RAM'])
Processor: $($pcInformation['Processor'])
Storage: $($pcInformation['Storage'])
Windows Version: $($pcInformation['WindowsVersion'])
BIOS Version: $($pcInformation['BIOSVersion'])
Network Adapters: $($pcInformation['NetworkAdapters'])
Installed Software: $($pcInformation['InstalledSoftware'])
System Uptime: $($pcInformation['SystemUptime'])
"@

    $outputPath = Join-Path $env:TEMP "PC_Information.txt"

    try {
        $output | Out-File -FilePath $outputPath -Force
        Write-Host "Information saved to $outputPath"
    }
    catch {
        Write-Error "Failed to write PC information to file: $_"
    }
}
else {
    Write-Error "PC information could not be retrieved."
}

