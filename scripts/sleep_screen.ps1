# Simple Ps Script to put the screen sleep.
# For More Scripts . Visit https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class User32 {
        [DllImport("user32.dll")]
        public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);
    }
"@

[User32]::SendMessage(-1, 0x0112, 0xF130, -1)
[User32]::SendMessage(-1, 0x0112, 0xF170, 2)
