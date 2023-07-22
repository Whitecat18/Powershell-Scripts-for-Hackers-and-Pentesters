## For More info Visit https://github.com/Whitecat18
### Run the script as Admin 
### Create New User in Windows within minutes 

$name = Read-Host "Enter the first name and surname for the new user" 
$login = Read-Host "Enter the Login name for the New user: "
$password = Read-Host "Password for the New user: "

New-ADUser -Name $user $SamAccountName $login -Password $password-ChangePasswordAtLogon $true

Write-Host "The user $login has been Created "
