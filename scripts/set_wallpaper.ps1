# Change Wallpaper from Link 
# For More Scripts . Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

$userinput1 = Read-Host "Enter the Picture Link Ex [https://image.com/cat.jpg] : "
$userinput2 = Read-Host "Enter name of Pic Ex [cat.jpg , cat.png ..etc ] : "
$url = $userinput1
$tempDirectory = [System.IO.Path]::GetTempPath()
$tempFileName = $userinput2
$output = [System.IO.Path]::Combine($tempDirectory, $tempFileName)
SystemParametersInfo(20, 0, $output, 3)

Invoke-WebRequest -Uri $url -OutFile $output

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
   [DllImport("user32.dll", CharSet = CharSet.Auto)]
   public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(20, 0, $output, 3)
