# For more scripts visit : https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters
# Simple LoTL Exploration method. I just tried :(

$outputFile = "$($env:USERPROFILE)\Desktop\LOTL.txt"


Start-Transcript -Path $outputFile -Append

function Get-DetailedNetworkInfo {
    $networkInfo = [ordered]@{
        IPAddresses = Get-NetIPAddress | Select-Object -Property IPAddress, InterfaceAlias, AddressFamily
        TCPConnections = Get-NetTCPConnection | Select-Object -Property LocalAddress, LocalPort, RemoteAddress, RemotePort, State
    }
    return $networkInfo
}

function Get-DetailedProcessAndServiceInfo {
    $processAndServiceInfo = [ordered]@{
        Processes = Get-Process | Select-Object -Property Name, Id, StartTime, CPU, PM
        Services = Get-Service | Select-Object -Property Name, Status, StartType
    }
    return $processAndServiceInfo
}


Write-Host "Network Information:"
Get-DetailedNetworkInfo | Out-Default

Write-Host "Process and Service Information:"
Get-DetailedProcessAndServiceInfo | Out-Default


Write-Host "WMI Namespace Information:"
Get-WmiObject -List | Format-Table | Out-Default

Stop-Transcript

Write-Host "Results saved to $outputFile"
