<#
Scripts managed by https://github.com/Whitecat18
For More info, visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters
#>

function Get-PCInformation {
    $pcInfo = @{
        'ComputerName'   = $env:COMPUTERNAME
        'Manufacturer'   = (Get-WmiObject Win32_ComputerSystem).Manufacturer
        'Model'          = (Get-WmiObject Win32_ComputerSystem).Model
        'RAM'            = '{0:N2} GB' -f ((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
        'Processor'      = (Get-WmiObject Win32_Processor).Name
        'Storage'        = (Get-WmiObject Win32_DiskDrive | Measure-Object Size -Sum).Sum / 1TB -as [int]
        'WindowsVersion' = (Get-WmiObject Win32_OperatingSystem).Caption
    }
    
    return $pcInfo
}

$pcInformation = Get-PCInformation

$output = @"
Computer Information:
Computer Name: $($pcInformation['ComputerName'])
Manufacturer: $($pcInformation['Manufacturer'])
Model: $($pcInformation['Model'])
RAM: $($pcInformation['RAM'])
Processor: $($pcInformation['Processor'])
Storage: $($pcInformation['Storage']) TB
Windows Version: $($pcInformation['WindowsVersion'])
"@

Write-Host $output
