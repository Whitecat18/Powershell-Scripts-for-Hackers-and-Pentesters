# Saves the Recon Results in the Desktop as recon.txt 
# For More Script visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters
# by Smukx

function Get-AndDisplayInformation {
    param (
        [string]$ClassName,
        [string]$PropertyFilter
    )

    $info = Get-CimInstance -ClassName $ClassName | Select-Object -Property $PropertyFilter
    $outputFilePath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'recon.txt')

    Add-Content -Path $outputFilePath -Value "$ClassName Information:`n"
    $info | Format-Table -AutoSize | Out-File -FilePath $outputFilePath -Append -Force
    Add-Content -Path $outputFilePath -Value "`n"
}

Get-AndDisplayInformation -ClassName "Win32_Desktop"
Get-AndDisplayInformation -ClassName "Win32_BIOS"
Get-AndDisplayInformation -ClassName "Win32_Processor" -PropertyFilter *
Get-AndDisplayInformation -ClassName "Win32_ComputerSystem"
Get-AndDisplayInformation -ClassName "Win32_QuickFixEngineering" -PropertyFilter HotFixId
Get-AndDisplayInformation -ClassName "Win32_OperatingSystem" -PropertyFilter Build*,OSType,ServicePack*
Get-AndDisplayInformation -ClassName "Win32_OperatingSystem" -PropertyFilter user
Get-AndDisplayInformation -ClassName "Win32_LogicalDisk" -PropertyFilter DeviceID,DriveType,ProviderName,VolumeName,Size,FreeSpace,PSComputerName
Get-AndDisplayInformation -ClassName "Win32_LogonSession"
Get-AndDisplayInformation -ClassName "Win32_ComputerSystem" -PropertyFilter UserName
Get-AndDisplayInformation -ClassName "Win32_LocalTime"
Get-AndDisplayInformation -ClassName "Win32_Service" -PropertyFilter Status,Name,DisplayName
