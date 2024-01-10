# Get top PID'S Process states such as the resources used and recieve the usage status

$outputFilePath = "$env:USERPROFILE\Desktop\$(hostname)_report.txt"

$outputContent = "System Report - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n`n"

$topProcesses = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 15

$outputContent += "Top Processes Consuming High Resources:`n"
$outputContent += "---------------------------------------`n"
foreach ($process in $topProcesses) {
    $outputContent += "Process Name: $($process.ProcessName)`n"
    $outputContent += "PID: $($process.Id)`n"
    $outputContent += "CPU Usage: $($process.CPU) %`n"
    $outputContent += "Memory Usage: $($process.WorkingSet / 1MB) MB`n"
    $outputContent += "---------------------------------------`n"
}

$users = Get-WmiObject -Class Win32_ComputerSystem
$outputContent += "`nLogged-In Users:`n"
$outputContent += "-----------------`n"
foreach ($user in $users) {
    $outputContent += "Username: $($user.UserName)`n"
    $outputContent += "Is Admin: $($user.Administrator)`n"
    $outputContent += "Total Users: $($users.Count)`n"
    $outputContent += "---------------------------------------`n"
}

$networkInfo = Get-NetAdapter | Select-Object Name, InterfaceDescription, ifIndex, MacAddress, Status, LinkSpeed
$outputContent += "`nNetwork Interface Information:`n"
$outputContent += "---------------------------`n"
foreach ($interface in $networkInfo) {
    $outputContent += "Interface Name: $($interface.Name)`n"
    $outputContent += "Interface Description: $($interface.InterfaceDescription)`n"
    $outputContent += "Index: $($interface.ifIndex)`n"
    $outputContent += "MAC Address: $($interface.MacAddress)`n"
    $outputContent += "Status: $($interface.Status)`n"
    $outputContent += "Link Speed: $($interface.LinkSpeed) Mbps`n"
    $outputContent += "---------------------------------------`n"
}

Pentesters.git`n"
$outputContent += "By: Smukx`n"

$outputContent | Out-File -FilePath $outputFilePath -Encoding utf8

Write-Output "System report generated: $outputFilePath"

