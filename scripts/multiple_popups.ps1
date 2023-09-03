# Open Multiple Popups using Windows Forms.
# For More Scripts Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters 

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function Show-Popup {
    param (
        [string]$message,
        [int]$popupNumber
    )
    
    $form = New-Object Windows.Forms.Form
    $form.Text = "Popup $popupNumber"
    $form.Size = New-Object Drawing.Size(300, 150)
    $form.StartPosition = "CenterScreen"
    
    $label = New-Object Windows.Forms.Label
    $label.Text = $message
    $label.AutoSize = $true
    $label.Dock = "Fill"
    $label.TextAlign = "MiddleCenter"
    
    $form.Controls.Add($label)
    
    $form.Add_Shown({ 
        Start-Sleep -Seconds 5 # durations you want the popup to remain open
        $form.Close()
    })
    
    $form.ShowDialog()
}

# Generate a random popups between certain numbers. You can modify for ur neads ..
$numberOfPopups = Get-Random -Minimum 5 -Maximum 11

for ($i = 1; $i -le $numberOfPopups; $i++) {
    $message = "This is popup number $i"
    Show-Popup -message $message -popupNumber $i
}
