$processes = Get-Process | Sort-Object -Property ProcessName

$basicProcesses = @("csrss", "dwm", "lsass", "lsm", "services", "smss", "spoolsv", "svchost", "system", "wininit", "winlogon")

# Initialize lists for basic necessary processes and third-party software
$basicProcessList = @()
$thirdPartyProcessList = @()

# Iterate through the running processes and check if they are necessary or third-party
foreach ($process in $processes) {
    if ($basicProcesses -contains $process.ProcessName.ToLower()) {
        $basicProcessList += $process.ProcessName
    } else {
        $thirdPartyProcessList += $process.ProcessName
    }
}

Write-Host "Basic necessary processes:"
Write-Host $basicProcessList -ForegroundColor Green

Write-Host "Third-party software:"
Write-Host $thirdPartyProcessList -ForegroundColor Red
Write-Host " "
Write-Host "By Smukx"
