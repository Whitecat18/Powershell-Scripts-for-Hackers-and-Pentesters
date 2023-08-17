<# This script loads your CPU by doing an simple mathematical operation ie computation #>

$cpus=$env:NUMBER_OF_PROCESSORS

# Setting to High Priority :]]
[System.Threading.Thread]::CurrentThread.Priority = 'Highest'

# Peform counters on CPU
$Global:psPerfCPU = new-object System.Diagnostics.PerformanceCounter("Processor","% Processor Time","_Total")
$psPerfCPU.NextValue() | Out-Null

$StartDate = Get-Date

Write-Output "---LOADING STARTED ;)---"

# Loading script
#
foreach ($loopnumber in 1..$cpus){
  Start-Job -ScriptBlock{
  $result = 1
      foreach ($number in 1..0x7FFFFFFF){
          $result = $result * $number
      }
  }
}

#FOR BETTER OPTIMIZATION UNCOMMENT THE BELOW LINES :

Read-Host -Prompt "Press any key to stop the JOBs CTRL+C to quit"

Write-Output "Stopping CPU Jobs"
Receive-Job *
Stop-Job *
Remove-Job *

$EndDate = Get-Date
Write-Output " Load Complete"


# Test it on virtual machine  
 

