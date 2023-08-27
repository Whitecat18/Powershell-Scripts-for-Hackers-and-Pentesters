# Quick Registry Scan using Ps Script
# For More Info Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

Get-ChildItem -Path HKLM:\Software\* | Where-Object {$_.Name -like "*.reg"}
Get-ChildItem -Path HKCU:\Software\* | Where-Object {$_.Name -like "*.reg"}

# Check recent logs
Get-WinEvent -LogName Security | Where-Object {$_.EventType -eq "Audit Success"} | Select-Object -Property TimeCreated, EventID, SourceModuleName, UserName, Message
Get-WinEvent -LogName System | Where-Object {$_.EventType -eq "Audit Success"} | Select-Object -Property TimeCreated, EventID, SourceModuleName, UserName, Message

# Find suspicious files
Get-ChildItem -Path C:\Windows\* | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-7)} | Where-Object {$_.Name -like "*.exe" -or $_.Name -like "*.dll" -or $_.Name -like "*.bat" -or $_.Name -like "*.vbs"}
