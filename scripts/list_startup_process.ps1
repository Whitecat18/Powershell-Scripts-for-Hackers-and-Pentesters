$StartupProcesses = Get-WmiObject Win32_StartupCommand

foreach ($Process in $StartupProcesses) {
    Write-Output "Name: $($Process.Name)"
    Write-Output "Command: $($Process.Command)"
    Write-Output "Location: $($Process.Location)"
    Write-Output "User: $($Process.User)"
    Write-Output "----------------------------------------"
}
