# Delete ALL Temp files from Windows Temp Directories .
# For More info . 
# Please visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

$currentUser = $env:UserName
$systemTempDirectory = "C:\Windows\Temp"
$userTempDirectories = @(Join-Path $env:SystemDrive "Users\$currentUser\AppData\Local\Temp")
$tempDirectories = $userTempDirectories + $systemTempDirectory

foreach ($tempDir in $tempDirectories) {
    $filesToDelete = Get-ChildItem -Path $tempDir -File -Force
    foreach ($file in $filesToDelete) {
        try {
            Remove-Item -Path $file.FullName -Force -ErrorAction Stop
            Write-Host "Deleted: $($file.FullName)"
        } catch {
            Write-Host "Failed to delete: $($file.FullName) - $($_.Exception.Message)"
        }
    }
}

Write-Host "Temporary files deleted from all Temp directories."


