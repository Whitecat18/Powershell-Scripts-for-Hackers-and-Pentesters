# Play an Video From an Website and disable k/m input for certain time 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic


$form = New-Object System.Windows.Forms.Form
$form.Text = "Video Player"
$form.WindowState = "Maximized"
$form.FormBorderStyle = "None"
$form.TopMost = $true


$browser = New-Object System.Windows.Forms.WebBrowser
$browser.Dock = "Fill"
$browser.ScrollBarsEnabled = $false
$browser.AllowNavigation = $false
$browser.Navigate("https://{ Your-video-link-Here(Link Should End with .mp4 )}")

[Microsoft.VisualBasic.Interaction]::AppActivate("Video Player")
$keyboard = Get-Device -Class "Keyboard"
$mouse = Get-Device -Class "Mouse"
Disable-Device -Device $keyboard
Disable-Device -Device $mouse

$form.Controls.Add($browser)

# Add a PlayStateChange event handler to the web browser control

$browser.add_PlayStateChange({
    if ($browser.PlayState -eq 8) {  # 8 = MediaEnded
        # Re-enable keyboard and mouse input
        Enable-Device -Device $keyboard
        Enable-Device -Device $mouse
        # Close the form
        $form.Close()
    }
})

$form.Show()
$browser.Ctlcontrols.play()
