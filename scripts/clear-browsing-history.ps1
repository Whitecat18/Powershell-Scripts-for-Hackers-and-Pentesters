# Clear browsing data and history for common browsers - Chrome, Firefox, Edge, Brave
# For More script goto -> https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

$chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
Remove-Item -Path "$chromePath\History" -Force
Remove-Item -Path "$chromePath\Cookies" -Force
Remove-Item -Path "$chromePath\Cache" -Force

$firefoxPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
$firefoxProfiles = Get-ChildItem -Path $firefoxPath -Directory | Where-Object { $_.Name -like '*default*' }
foreach ($profile in $firefoxProfiles) {
    $firefoxDB = Join-Path -Path $profile.FullName -ChildPath "places.sqlite"
    Remove-Item -Path $firefoxDB -Force
}

$edgePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default"
Remove-Item -Path "$edgePath\History" -Force
Remove-Item -Path "$edgePath\Cookies" -Force
Remove-Item -Path "$edgePath\Cache" -Force

$bravePath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default"
Remove-Item -Path "$bravePath\History" -Force
Remove-Item -Path "$bravePath\Cookies" -Force
Remove-Item -Path "$bravePath\Cache" -Force

Write-Output "Browsing data and history cleared for Chrome, Firefox, Edge, and Brave browsers."
