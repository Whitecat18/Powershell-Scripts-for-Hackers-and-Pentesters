# Powershell script to Enable Keyboard and Mouse
# For More Scripts Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class InputBlocker
{
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
}

"@

# Enable keyboard and mouse input
[InputBlocker]::BlockInput($false)
