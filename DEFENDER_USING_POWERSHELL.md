## Windows Defender Act using powershell 

Use Powershell to Defend attack and Protect Windows Defender . In this page i will show you , how you can manage security using powershell. 

**Note : The Following commands need to run in Powershell(Admin) console.**


#### (1) Disable Windows Defender Real-Time Protection
```
Set-MpPreference -DisableRealtimeMonitoring $true
```

#### (2) Disable Windows Defender Antivirus 
```
Set-MpPreference -DisableAntivirus $true
```

#### (3) Disable Windows Defender Behavior Monitoring
```
Disable Windows Defender Behavior Monitoring
```
#### (4) Disable Windows Defender Cloud-Based Protection
```
Set-MpPreference -DisableBlockAtFirstSeen $true
```
#### (5) Restart the Windows Security Service 
To apply the changes, you need to restart the Windows Security service . To do that
```
Restart-Service -Name "WinDefend"
```

### Windows Defender Commands to Try out

#### (6) Check Windows Defender status
```
Get-MpComputerStatus
```
