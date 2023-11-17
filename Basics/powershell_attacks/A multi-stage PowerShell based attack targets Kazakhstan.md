![A multi-stage PowerShell based attack targets Kazakhstan](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/asset_upload_file36823_228407.jpeg?w=736)



# A multi-stage PowerShell based attack targets Kazakhstan

Posted: November 12, 2021 by [Threat Intelligence Team](https://www.malwarebytes.com/blog/authors/threatintelligence)

_This blog post was authored by Hossein Jazi._

On November 10 we identified a multi-stage PowerShell attack using a document lure impersonating the Kazakh Ministry of Health Care, leading us to believe it targets Kazakhstan.

A threat actor under the user name of DangerSklif (perhaps in reference to [Moscow’s emergency hospital](https://www.imdb.com/title/tt3781262/)) created a GitHub account and uploaded the first part of the attack on November 8.

In this blog we will review the different steps the attacker took to fly under the radar with the intent on deploying Cobalt Strike onto its victims.

## Overview

The attack started by distributing a RAR archive named “Уведомление.rar” (“Notice.rar”). The archive file contains a lnk file with the same name pretending to be a PDF document from “Ministry of Health Care, Republic of Kazakhstan”. Upon opening the lnk file, a PDF file will be shown to confuse victims while in the background multiple stages of this attack are being executed. The decoy document is an amendment for a Covid 19 policy that has been issued by the Chef State Sanitary of the Republic of Kazakhstan.

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/decoy-2.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/decoy-2.png)

##   
Attack process

The following figure shows the overall process of this attack. The attack started by executing the lnk file that calls PowerShell to perform several techniques such as privilege escalation and persistency through an autorun registry key. We will provide the detailed analysis in the next section. 

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/cobalt.jpg)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/cobalt.jpg)

All stages of this attack have been hosted in one Github repository named _GoogleUpdate_. This repository was created on November 8th by a user named _DangerSklif_. The _DangerSklif_ user was created on GitHub on November 1st. 

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/Screen-Shot-2021-11-11-at-8.20.10-AM.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/Screen-Shot-2021-11-11-at-8.20.10-AM.png)

## Analysis

The embedded lnk file is obfuscated and after de-obfuscation we can see that it used _cmd.exe_ to call PowerShell to download and execute the first stage of the attack from the Github account (_lib7.ps1_).

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lnk.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lnk.png)

The _lib7.ps1_ downloads the decoy PDF file from the same Github account and stores it in the _Downloads_ directory.  In the next step it opens the decoy PDF to confuse the user while it performs the rest of process in the background, which includes getting the OS version and downloading the next stage based on the OS version. 

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lib7.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lib7.png)

If the OS version is 7 or 8, it downloads and executes _lib30.ps1_ and if the OS version is 10 it downloads and executes _lib207.ps1._ The reason the actor is checking the OS version is because it is trying to execute the right privilege escalation method. These techniques previously used by [TA505](https://www.ptsecurity.com/ww-en/analytics/pt-esc-threat-intelligence/operation-ta505-part2/) in their campaign to drop SrvHelper. 

- Using the _SilentCleanup_ task in the Task Scheduler to bypass UAC in Windows 10: Attacker used _Lib207.ps1_ to bypass UAC in Windows 10. The PowerShell commands used to perform the bypass are XOR encrypted using 0x58 key.

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/207-before-deobfuscation.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/207-before-deobfuscation.png)

After decrypting the commands, we can see the process of UAC bypass which includes creating a SilentCleanup task in the Task Scheduler that calls PowerShell to execute the created vbs file with higher privilege.

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/207-after-deobfuscation.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/207-after-deobfuscation.png)

- Using the sysprep.exe system utility and DLL side-loading to bypass UAC in Windows 7 and 8: Lib30.ps1 is used to execute this bypass. Simliar to lib207.ps1 this PowerShell script is also XOR encrypted but using different key (0x02).

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lib30-before-deobfuscation.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lib30-before-deobfuscation.png)

Figure 9 shows PowerShell commands after decryption. The process starts by creating a batch file (_cmd.bat_) in the “_Windows/Temp_” directory.  In the next step, a cab archive file is created containing a DLL (CRYPTBASE.dll for Windows 7 or shcore.dll for Windows 8. Then this cab file is extracted into the C:WindowsSystem32Sysprep directory using wusa.exe.

At the end, the sysprep.exe system utility launches which side loads the CRYPTBASE.dll for Windows 7 or shcore.dll for Windows 8. This DLL executes the created _cmd.bat_ file which leads to executing it with a high privilege.  
  

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lib30-after-deobfuscation-1.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/lib30-after-deobfuscation-1.png)

After bypassing UAC, in all OS versions the next stage payload is downloaded and executed (_lib106.ps1_).

This stage performs the following actions:

- Creates a vbs file (cu.vbs) in _ProgramFiles_ directory and makes this multi-stage attack persistence by adding this vbs file to _HKLMSoftwareMicrosoftWindowsCurrentVersionRun_ registry key_._  
- Makes vbs file hidden using “Attrib.exe +h” command. 
- Downloads and executes the final stage (_updater.ps1_) using PowerShell.

The final stage (_updater.ps1_) is executing Cobalt Strike in PowerShell context. In fact this PowerShell script is PowerShell variant of Cobalt Strike.

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/36932c0f-974e-4f93-a792-8c5f01fdd600.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/36932c0f-974e-4f93-a792-8c5f01fdd600.png)

The Cobalt Strike ShellCode is base64 encoded and XOR encrypted using 35 key. After decoding and decrypting the ShellCode it allocates it into memory using VirtualAlloc and finally execute it by calling Invoke function.

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/cobalt-1.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/cobalt-1.png)

## Kazakhstan in the news

Kazakhstan has been in the news recently for taking over China in the cryptomining industry, [depleting its own electric resources](https://www.reuters.com/business/energy/crypto-boom-strains-kazakhstans-coal-powered-energy-grid-2021-11-10/). The energy-rich country is a very important ally for Russia in particular with lucrative joint oil and gas ventures.

Other than their GitHub profile, we do not have much information on the threat actor or their exact intention with this attack. However, monitoring and espionage are a likely motive.

Malwarebytes users were protected thanks to the Anti-Exploit layer of our product.

[![](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/block-1.png)](https://www.malwarebytes.com/wp-content/uploads/sites/2/2021/11/block-1.png)

## **I**OCs

Уведомление.pdf.lnk:  
574a33ee07e434042bdd1f59fc89120cb7147a1e20b1b3d39465cd6949ba7d99  
Уведомление.rar:  
d0f3c838bb6805c8a360e7b1f28724e73e7504f52147bbbb06551f91f0df3edb  
Updater.ps1:  
08f096134ac92655220d9ad7137e35d3b3c559359c238e034ec7b4f33a246d61  
lib106.ps1:  
81631df5d27761384a99c1f85760ea7fe47acc49ef81003707bb8c4cbf6af4be   
lib2.ps1:  
912434caec48694b4c53a7f83db5f0b44b84ea79be57d460d83f21181ef1acbb  
lib207.ps1:  
893f6cac7bc1a1c3ee72d5f3e6994e902b5af044f401082146a486a0057697e5   
lib30.ps1:  
11d6b0b76d057ac9db775d9a1bb14da2ed9acef325060d0452627d9391be4ea2   
lib63.ps1:  
8f974d8d0741fd1ec9496857d7aabbe0d3ba4d2e52cc311c76c28396edae9eb9   
lib64.ps1:  
301194613cbc11430d67acf7702fd15ec40ee0f9be348cf8a33915809b65bc5e  
lib7.ps1:  
026fcb13e9a4ea6c1eab73c892118a96731b868a1269f348a14a5087713dd9e5  
lib706.ps1:  
36aba78e63825ab47c1421f71ca02422c86c774ba525959f42b8e565a808a7d4   
C2:  
188.165.148.241

