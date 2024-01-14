<#
Disable or Kill USB and Netword interfaces.
For More info . visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters
#>

$admin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $admin) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

function Disable-NetworkInterfaces {
    Get-NetAdapter | ForEach-Object {
        Disable-NetAdapter -Name $_.Name
    }
}

function Disable-USBDevices {
    Get-PnpDevice -Class USB | ForEach-Object {
        Disable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false
    }
}

$response = Read-Host "This action will disable all network interfaces and USB devices. Are you sure you want to proceed? (Y/N)"

if ($response -eq 'Y' -or $response -eq 'y') {
    Disable-NetworkInterfaces

    Disable-USBDevices

    Write-Output "All network interfaces and USB devices have been disabled."
} else {
    Write-Output "Action canceled. No changes made."
}
