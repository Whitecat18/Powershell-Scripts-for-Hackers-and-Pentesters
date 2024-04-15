# Windows Enumeration Using Powershell
### In This Page i will post Windows Enumeration. 


#### (0) List Installed Softwares 

```
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
```

List out the Installed softwares on current Windows machines
#### (1) . Check Partition and spaces 

```
Get-PSDrive -PSProvider FileSystem | format-table -property Name,Root,@{n="Used (GB)";e={[math]::Round($_.Used/1GB,1)}},@{n="Free (GB)";e={[math]::Round($_.Free/1GB,1)}}
```

Display Mounted Partitions and they disk spaces 

#### (2) . List All services Running + stopped

```
Get-Service
```

list only Running part 

```
Get-Service | Where-Object {$_.Status -eq "Running"}
```

#### (3) . Restart Computer
Dont kiddy me Guys, many members dont know this way of restarting PC . If you Know , U R Gud
```
Restart-Computer
```
Dont kiddy me Guys, many members dont know this way of restarting PC . If you Know , U R Gud


#### (4) . Get Process id's , names and their CPU usage !

```
Get-Process | Format-Table -Property Id, @{Label="CPU(s)";Expression={$_.CPU.ToString("N")+"%"};Alignment="Right"}, ProcessName -AutoSize
```

#### (5) . Check Disc Sync 

```
param([string]$Drive = "")

try {
	if ($Drive -eq "" ) { $Drive = read-host "Enter drive (letter) to check" }

	$Result = repair-volume -driveLetter $Drive -scan
	if ($Result -ne "NoErrorsFound") { throw "'repair-volume' failed" }

	& "$PSScriptRoot/speak-english.ps1" "File system on drive $Drive is clean."
	exit 0 # success
} catch {
	"Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

```

#### (6) Powershell Transcript

A PowerShell transcript is a record of all commands and output in a PowerShell session. It allows you to log and save everything that happens in the session, which can be useful for troubleshooting, auditing, or documentation purposes.
<br>
<br>
To Enable Transcript

```
Start-Transcript -Path "C:\Transcripts\MyTranscript.txt"
```

Start in All Sessions

```
Start-Transcript -Path "C:\Transcripts\MyTranscript.txt" -Append
```

To Disable Transcipt

`Stop-Transcript`

#### (7) List all running processes sorted by CPU usage, with the highest usage at the top of the list

```
Get-Process | Sort-Object -Descending CPU
```

#### (8)  Get Process id's , names and their CPU usage !

```
Get-Process | Format-Table -Property Id, @{Label="CPU(s)";Expression={$_.CPU.ToString("N")+"%"};Alignment="Right"}, ProcessName -AutoSize
```
#### (9) List the Default and 3rd party running apps 

Link for PS Script : <a href="https://github.com/Whitecat18/Ps-script-for-Hackers-and-Pentesters/blob/main/scripts/list_process.ps1" > click Here </a>

#### (10) Search for Sensitive configaration files .

```
Get-ChildItem -Path C:\ -Recurse -Include *.conf, *.ini, *.xml, *.cfg | Select-String -Pattern "password|secret|api_key"
```
This command searches for sensitive configuration files on a local or remote machine, and looks for common keywords such as "password", "secret", or "api_key" within those files.

#### (11) List Services 

```
Get-Service | Where-Object {$_.StartType -eq 'Automatic' -and $_.Status -ne 'Running'} | Select-Object -Property Name, DisplayName
```

This command retrieves a list of all services on a local or remote machine that are set to start automatically but are currently not running.

#### (12) Mini TaskManager on terminal 

```
Clear-Host
$Processes = Get-Process | Sort-Object -Property CPU, WorkingSet64 -Descending

while ($true) {
    $Processes | Format-Table -AutoSize | Out-Host
    Start-Sleep 1
}
```
Fetches Windows Task Manager and Displays Process in Bytes . To change the speed increase the Sleep Time or Remove the While Loop . 

Example : 

```
Clear-Host
$Processes = Get-Process | Sort-Object -Property CPU, WorkingSet64 -Descending
$Processes | Format-Table -AutoSize | Out-Host
```

#### (13) Active Directory User Info:

```
Get-ADUser -Identity YourUsername -Properties *
```

Retrieve information about an Active Directory user.

#### (14) Event Log Analysis

```
Get-WinEvent -LogName System -EntryType Error -After (Get-Date).AddDays(-7)
```

**(15) Identify Admin Running Process**

```
Get-Service | Where-Object { $_.Status -eq "Running" }
```

Use this to identify vulnerable running Processes . use it to prives it or manual exploit . 

**(16) BIOS Information**

```
Get-CimInstance -ClassName Win32_BIOS
```

Get PC'S BIOS Information

**(17) Service Status**

```
Get-CimInstance -ClassName Win32_Service | Select-Object -Property Status, Name, DisplayName
```

Display service status 

**(18) Processor Information**

```
Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*"
```

Get CPU Information

**(19) System Disk & Volume Information**

```
Get-Volume | Select-Object DriveLetter, FileSystemLabel, FileSystem, DriveType, @{Name="SizeRemaining";Expression={[math]::Round($_.SizeRemaining/1GB,2)}}, @{Name="Size";Expression={[math]::Round($_.Size/1GB,2)}}
```

Get system's Disk's Information such as volume, Storage info in readable format .

**(20) System Enviroinment Variables**

```
Get-ChildItem Env: | Select-Object Name, Value
```

Get system enviroinment vaiables .

**(21) Windows Workstation was locked**

```
Get-WinEvent -FilterHashtable @{ LogName='security'; Id='4800' }
```

Command to read event logs for Lock/screensaver

**(22)Workstation was unlocked**

```
Get-WinEvent -FilterHashtable @{ LogName='security'; Id='4801' }
```

**(23)Screensaved invoked**

```
Get-WinEvent -FilterHashtable @{ LogName='security'; Id='4802' }
```

**(24)Screensaver dismissed**

```
Get-WinEvent -FilterHashtable @{ LogName='security'; Id='4803' }
```
