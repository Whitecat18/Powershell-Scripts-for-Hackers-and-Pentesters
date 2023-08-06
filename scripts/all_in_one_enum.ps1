# Save a copy of Process and Memory Usage , Network speed , Local Address , Running Programs , Network Running Ports on Temp Path
# For More Info Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters 

$processes = Get-Process

$services = Get-Service | Where-Object { $_.Status -eq 'Running' }

$cpuUsage = (Get-WmiObject Win32_Processor).LoadPercentage
$memoryUsageBytes = (Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory
$memoryTotalBytes = (Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory
$memoryUsageMB = [math]::Round(($memoryTotalBytes - $memoryUsageBytes) / 1MB, 2)

$networkStats = Get-NetAdapterStatistics | Select-Object Name, ReceivedBytes, SentBytes

$networkTasks = Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State

$topCpuProcesses = $processes | Sort-Object -Property CPU -Descending | Select-Object -First 5
$topMemoryProcesses = $processes | Sort-Object -Property WS -Descending | Select-Object -First 5

$openPorts = Test-NetConnection -InformationLevel Detailed | Where-Object { $_.TcpTestSucceeded } | Select-Object RemoteAddress, RemotePort

$installedApps = Get-WmiObject Win32_Product | Select-Object Name, Version, Vendor

Write-Host "Running Processes:"
$processes | Format-Table Name, Id, CPU, WorkingSet -AutoSize

Write-Host "Running Services:"
$services | Format-Table DisplayName, Status -AutoSize

Write-Host "Hardware Usage:"
Write-Host "CPU Usage: $cpuUsage%"
Write-Host "Memory Usage: $memoryUsageMB MB"

Write-Host "Network Bandwidth:"
$networkStats | Format-Table Name, ReceivedBytes, SentBytes -AutoSize

Write-Host "Running Network Tasks:"
$networkTasks | Format-Table LocalAddress, LocalPort, RemoteAddress, RemotePort, State -AutoSize

Write-Host "Top CPU Processes:"
$topCpuProcesses | Format-Table Name, CPU, WorkingSet -AutoSize

Write-Host "Top Memory Processes:"
$topMemoryProcesses | Format-Table Name, WS, VM -AutoSize

Write-Host "Open Network Ports:"
$openPorts | Format-Table RemoteAddress, RemotePort -AutoSize

Write-Host "Installed Applications:"
$installedApps | Format-Table Name, Version, Vendor -AutoSize

$outputFilePath = "C:\Windows\Temp\scan_result.txt"
$output = @"
Running Processes:
$($processes | Format-Table -AutoSize | Out-String)

Running Services:
$($services | Format-Table -AutoSize | Out-String)

Hardware Usage:
CPU Usage: $cpuUsage%
Memory Usage: $memoryUsageMB MB

Network Bandwidth:
$($networkStats | Format-Table -AutoSize | Out-String)

Running Network Tasks:
$($networkTasks | Format-Table -AutoSize | Out-String)

Top CPU Processes:
$($topCpuProcesses | Format-Table -AutoSize | Out-String)

Top Memory Processes:
$($topMemoryProcesses | Format-Table -AutoSize | Out-String)

Open Network Ports:
$($openPorts | Format-Table -AutoSize | Out-String)

Installed Applications:
$($installedApps | Format-Table -AutoSize | Out-String)
"@

$output | Out-File -FilePath $outputFilePath

