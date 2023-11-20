## From Powershell reflective loader to injected dll


Hi! I have lately started delving into maliious powershell payloads and came across a really intriguing
powershell loader for [Netwalker ransomware](https://labs.sentinelone.com/netwalker-ransomware-no-respite-no-english-required/), performing [fileless attack](https://www.trendmicro.com/vinfo/us/security/news/cybercrime-and-digital-threats/security-101-how-fileless-attacks-work-and-persist-in-systems). Fileless techniques enable attackers
to directly load and execute malicious binary in memory without actually storing it on disk by abusing available
legitimate tools on victim machine. Such threats leave no trace of execution and are capable of evading any
traditional security tools. This post thoroughly discusses how first stage powershell script filelessly loads and
executes embedded payload through reflective Dll injection.

SHA-256 hash of the sample being analyzed: [f4656a9af30e98ed2103194f798fa00fd1686618e3e62fba6b15c9959135b7be](https://bazaar.abuse.ch/download/f4656a9af30e98ed2103194f798fa00fd1686618e3e62fba6b15c9959135b7be/)

**Prior knowledge required:**
- Basic Powershell understanding
- using .NET reflection to access Windows API in PowerShell
- Windows APIs for Process/Dll injection


This is around ~5 MBs of powershell script using three layers of encoding, encryption and obfuscation
respectively to hide ransomware dll and supporting powershell commands for reflective Dll injection. The
uppermost layer executes very long base64 encoded command (screenshot covers only a small portion of this
command)

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/67820ea6-d4f2-43a6-97d3-64a0c48990f8)

### Processing Base64 encoded layer 1

In order to get decoded output from initial script, I shall run powershell script into my VM’s Powershell ISE but
as the Invoke-Expression cmdlet will process base64-encoded payload and execute the ransomware therefore,
I’ll modify the script for debugging by replacing this comdlet with a variable to store result of base64 decoded
command and dump output in a file as shown in the figure below

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/9bce1795-ac3b-4886-837e-797d43515731)

### Processing Encrypted layer 2

base64 decoded second layer once again contains a very long bytearray in hex format which is processed in
two steps

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/82b7b260-8c74-4156-a2f5-ea8f0d26901e)

1) bytearray contents are decrypted in a for loop with 1 byte hardcoded xor key

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/5ba178fb-3e03-495f-a26a-5fbc3e8d99cd)

2) decrypted contents are stored as ASCII string in another variable in order to be able to create scriptblock for
decrypted contents and execute it using Invoke-Command cmdlet

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/d387032d-c4d1-46f6-b929-9bcf987488f9)

but I shall also modify second layer to get decrypted layer three contents and dump result into another output
file as shown in the figure below

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/7501d186-4b38-4975-8d5c-c8a8cd4fd098)

decryptedlayer3.ps1 now contains the obfuscated layer three powershell script embedding ransomware dlls in
bytearrays and other commands to process the malicious payload

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/56744390-699e-44cd-bb30-fdcc9e05d810)

### Processing Obfuscated layer 3

Let’s start digging into layer three powershell script which is quite obfuscated having lengthy and random string
variable and routine names responsible to drop final payload. It is required to perform following steps in order to
execute Netwalker ransomware on victim’s machine
- define variables to invoke in-memory Windows API function calls without compilation
- define routines to load dll without using Windows loader
- detect environment
- get PID of a legitimate process from a list of running processes and inject payload via custom loader
- delete shadow copies

First off, it defines required variables and routines:

to invoke in-memory Windows API function calls without compilation, C# code to declare structs and
enums for memory manipulation is defined inside a variable as shown below

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/28d81233-17e1-43a4-8cb2-3b6f59143e8d)

and to invoke kernell32.dll APIs using wrapper .Net methods available in powershell

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/b4de116a-2d5b-4457-a582-519f2dd06d5d)

final command in this case will let us instantiate objects by making Microsoft .Net core classes available in our
powershell session and ensure ransomware’s true memory residence through reflection.

Following set of routines help correctly compute required memory addresses and relocations by casting
integer datatypes (signed integers to Unsigned integers and vice versa) so that the script could act as its own
custom loader and load dll without using Windows loader

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/1b6d6119-ff2b-4eeb-a190-cfbffe07c8f7)

Finally it defines a bunch of routines to write embedded malicious binary into another process’s memory and
execute it.

Script starts its execution by detecting underlying processor’s architecture to know whether it is running on x86
or amd64 and to prepare 32-bit or 64-bit dll accordingly using following if-else block

```
[byte[]]$EbihwfodUZMKtNCBx = $ptFvKdtq
$aukhgaZFiPJBarSpJc = $false
if ( ( Get-WmiObject Win32_processor).AddressWidth -eq 64 )
{
  [byte[]]$EbihwfodUZMKtNCBx = $GxwyKvgEkr
  $aukhgaZFiPJBarSpJc = $true
    if ( $env:PROCESSOR_ARCHITECTURE -ne 'amd64' )
    {
      if ($myInvocation.Line)
      {
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -ExecutionPolicy ByPass -
        NoLogo -NonInteractive -NoProfile -NoExit $myInvocation.Line
      }
      else
      {
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -ExecutionPolicy ByPass -
        NoLogo -NonInteractive -NoProfile -NoExit -file "$($myInvocation.InvocationName)" $args
      }
      exit $lastexitcode
    }
}
```

later it allocates memory in current process’s address space and starts writing dll on the allocated memory
using following for loop

```
for( $dxQpkwU = 0; $dxQpkwU -lt $TKgfkdkQrLMAN.KGcnFrQVhkckQriBC.nKkeCknfm; $dxQpkwU++ )
{
  $PdWhwldJHtQhtsMJe = [System.Runtime.InteropServices.Marshal]::PtrToStructure(
  $lItUIbvCvHxzMmrKtX,[Type][Fvh.wTEWKRjOqBX] )
  $rZKYDiOJE = RBeMnMHvnbNEob $eIr $( ULhnbcyXERLvVtGXUp $PdWhwldJHtQhtsMJe.sUtYsMhA )
  $MxyiIYGMhxakrDbKyjL = RBeMnMHvnbNEob $upEcLTMCGhc $( ULhnbcyXERLvVtGXUp
  $PdWhwldJHtQhtsMJe.cymIspbCOaY )
  $mofiZSsnxylxNuA = $AaauDVCQMlKUXx::PMUN( $VxxHhZYpWSgsPvKNuDx, $MxyiIYGMhxakrDbKyjL, $rZKYDiOJE,
  $PdWhwldJHtQhtsMJe.mkvugoDzrJgTSSJp, [ref]([UInt32]0 ) )
  if ( $mofiZSsnxylxNuA -eq $false )
  {
    return
  }
  $lItUIbvCvHxzMmrKtX = RBeMnMHvnbNEob $lItUIbvCvHxzMmrKtX
  $([System.Runtime.InteropServices.Marshal]::SizeOf([Type][Fvh.wTEWKRjOqBX]))
}
```

snapshot of object containig dll that gets written into current process’s memory

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/d2d40a5b-a400-4eba-b81b-5af1f35c9717)

after that it calls following routine with certain parameters to inject payload by specifying a legitimate target
process which is ‘explorer.exe’ in this case along with memory location pointer for buffer containg Dll and size
of the buffer containing dll

![image](https://github.com/Whitecat18/Powershell-Scripts-for-Hackers-and-Pentesters/assets/96696929/95a2a3ba-c081-4f4e-9c49-91ae472ee136)

this routine finds PID of explorer.exe form a list of running processes and passes obtained PID to final routine

