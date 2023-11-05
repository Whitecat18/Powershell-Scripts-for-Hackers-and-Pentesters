# Microsoft Powershell vs Command Prompt(CMD)! 

**Source From : [Newtix](https://www.netwrix.com/)**

## What is the Windows command prompt?

The Windows command prompt (also known as the command line, cmd.exe or simply cmd) is a command shell based on the MS-DOS operating system that provides an environment to run applications and utilities. Output is displayed in the same window. It is the default shell in pre-Windows 10 systems.

To open the command prompt, type **cmd** in the Run dialog box.

The screenshot below shows some command prompt commands.

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture33.png)

## What is Windows PowerShell?

Windows PowerShell is a command shell and scripting language designed for system administration tasks. Introduced in 2006, it was built on top of the .NET framework, a platform for software programming developed by Microsoft. It became the default shell in Windows 10.

**Request One-to-One Demo:**

PowerShell commands, or cmdlets, help administrators manage the Windows infrastructure. In addition, they enable admins to access the registry, file system and Windows Management Instrumentation (WMI) space on systems remotely. Moreover, the PowerShell command shell enables users to create complex scripts with multiple conditions.

To open PowerShell, type **PowerShell** in the Run dialog box.

The screenshot below provides details about getting help with PowerShell:

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture34.png)

## How PowerShell differs from the command prompt

Both the command prompt and PowerShell are included with all modern Windows operating systems. The key difference between them is that PowerShell supports the automation of a much wider range of tasks, such as Active Directory administration, user and permissions management, and extracting data about security configurations.

### Comparing PowerShell and cmd

Below are the key functionality differences between the command prompt and PowerShell:

|   |   |
|---|---|
|**Command Prompt**|**PowerShell**|
|Can run only batch files and system executable programs|Can run all program types|
|Does not support aliases for commands|Supports aliases for both cmdlets and scripts|
|Produces output in text format only, so output cannot be passed to other commands|Can produce output either as text or an object that can be passed to other commands or functions|
|One command must finish before the next can be entered|Multiple cmdlets can be combined into a script for execution|
|Can show information about batch commands or executable commands for switches only, but no syntax or examples are available|Has a Help feature that provides information about a command’s syntax along with examples|
|Has only a command-line interface|Has an integrated scripting environment (ISE)|
|Has no access to programing libraries|Has access to programming libraries (because it is built on the .NET framework)|
|Needs separate plug-ins to interact with Windows Management Instrumentation (WMI)|Can directly integrate with WMI|
|Does not support Microsoft cloud services|Can connect and support Microsoft cloud services, such as Microsoft 365, Azure and Azure|
|Cannot be installed on Linux systems (Linux has its own command prompt)|Can be installed on Linux systems|

### Programming and operational differences between cmd and PowerShell

The following table summarizes the key differences between PowerShell and cmd from a programming and operations perspective:

|   |   |   |
|---|---|---|
|**Features**|**Command Prompt**|**PowerShell**|
|Functions|Yes, with help from “call:label”|Yes|
|Exclusion handling|Not supported|Yes|
|Search and replacement of variables|Yes (set %varname:expression%)|Yes|
|Parallel assignment|Not supported|Yes|
|Variadic functions|Not supported|Yes|
|Default arguments|Not supported|Yes|
|Named arguments|Not supported|Yes|
|Lambda functions|Not supported|Yes|
|Eval functions|Not supported|Yes|
|Pseudorandom number generator|Yes (%random%)|Yes|
|Bytecode (Portable code)|Not supported|Yes|
|Remote execution|Yes, but requires utilities like PsExec|Yes|
|Support for cloud technologies (e.g., Office 365, Azure)|No|Yes|
|Support for Linux systems|No|Yes|
|Default shell in pre-Windows 10 systems|Yes|No|
|Default shell in Windows 10|No|Yes|

## What can be done using the command prompt

Microsoft has regularly added command prompt commands to help address changing work requirements. Today, there are some 280 commands available.

### Common examples

Here are some common tasks that users and administrators perform using cmd:

### Advanced examples

The command prompt also offers more advanced commands, such as:

- Gets information related to all running processes
- Shows folder or directory structure in an organizational way.
- Takes ownership of a file or folder
- Changes the attributes of a file or folder
- Checks a system disk for errors
- Gets the path from a local system to a destination system
- Formats a hard disk drive or external drive
- Shows the content a text document
- Compares two text files
- Checks or modifies the encryption of a file or folder

## What can be done with PowerShell

You can do everything with PowerShell that you can with the command prompt. In fact, PowerShell has over 100 modules with over 2,600 cmdlets available to do different tasks.

### Basic to advanced examples

Below are some basic to advanced level examples of PowerShell usage:

- Creating, managing and deleting files and folders, including xml, html and csv files
- Getting the contents of a folder, including several files simultaneously, along with the count of the content
- Creating scripts using loops, such as _while_, _do-while_,  _for_ and _for-each_ loops, as well as _if_, _if-else_ and _where_ statements
- Creating blocks of code as functions and re-using them in scripts without having to re-write the code
- Creating registries, and getting and changing any value from Windows registry
- Creating Windows Forms
- Checking Windows event logs
- Creating, managing and deleting remote sessions to other systems or online technologies (e.g., Exchange Online)
- Exporting cmdlet results or data from a provider (e.g., Active Directory users, groups or computer objects) to a CSV or text file
- Forcing Group Policy to all computers or selected computers

### More advanced use cases

- Automating system administration processes like adding new local users, controlling services and controlling disk space
- Managing Windows-based environments, including components like Windows Update, Active Directory and Group Policy
- Automating daily operations like report generation, system performance monitoring and backup creation
- Constructing unique tools and scripts to automate particular processes
- Installing PowerShell modules for managing other systems, such the Active Directory and Exchange modules
- Creating data and changing it to different formats, e.g., XML, JSON or YAML
- Creating, managing and deleting virtual machines or performing other actions in Microsoft Hyper-V
- Managing Microsoft SQL Server operations
- Managing HTTP servers and clients
- Performing actions using Windows Management Instrumentation, Component Object Model (COM) or REST APIs, which are all directly integrated with PowerShell
- Managing ACLs for file and folder permissions
- Managing Azure, AWS, VMWare and Google Cloud technologies
- Creating configuration files (using PowerShell DSC) to manage Chef, Puppet or Ansible systems
- Managing Power BI workspaces, datasets, reports and other objects
- Managing almost all Microsoft server products, including Windows Server, Exchange Server, SQL Server and SharePoint Server

## PowerShell vs cmd: which one to choose

Clearly, there are many reasons why Windows PowerShell replaced the command prompt as the default in the Windows 10 operating system and was preinstalled starting with Windows XP.

But if you’re used to using cmd, you don’t need to feel any urgency in switching to PowerShell. In fact, most commands from cmd work fine in the PowerShell environment — Microsoft created command prompt aliases in PowerShell that enable it to interpret old DOS commands as new PowerShell commands. To find out how cmd commands map to PowerShell cmdlets, use the **Get-Alias** command:

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture35-1.png)

However, there is a good case to be made for making the leap to PowerShell. Everything you can do with cmd you can also do with PowerShell — and often it is more convenient, since there is a special environment to develop and test scripts. Additionally, PowerShell is a live language with a strong community ready and willing to help system administrators who are new to scripting.

## Frequently asked questions

1. **How can I run the command prompt as an administrator?**

In the search field beside the Start button in the taskbar, type **cmd**. Right-click the Command Prompt app and choose **Run as Administrator**.

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture36-1.jpg)

2. **How can I change the title of the command prompt?**

You can do this by running the Title command from the command prompt:

**_C:\WINDOWS\system32>Title Bryan’s CMD_**

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture37-1.png)

3. **How do I change to a different directory in the command prompt?**

In the command prompt window, type **CD** followed by a space and then the folder or directory name, as illustrated here:

 C:\WINDOWS\system32> cd C:\Program Files\Google\Chrome

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture38-1-1024x186.png)

**4**. **How can I open PowerShell using the Power User menu?**

Right-click the Start button to view the Power User menu and select the PowerShell option. Alternatively, press the Windows and X keys simultaneously and then choose either **Windows** **PowerShell** or **Windows** **PowerShell (Admin)**.

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture39-1.png)

5. **How can I get a list of installed PowerShell modules?**

To list all installed modules, run this cmdlet in PowerShell:

`Get-Module -ListAvailable

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture40-1-1024x584.png)

6. **How do I install a PowerShell module?**

To install a module from the PowerShell online gallery, use this cmdlet:

`Install-Module -Name _<modulename>_

For example:

`Install-Module -Name AzureAD

You will get two warning messages, as shown below. First, type **Y** to install the required version of NuGet. Then will get a warning that the PowerShell Gallery is not a trusted repository. Type **Y** to continue, and the PowerShell module will be installed in a couple of minutes.

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture41-1-1024x187.png)

To avoid the second warning, you can add PowerShell Gallery as a trusted source before beginning the install process, using this command:

`Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction Stop

Note that this cmdlet will not produce any output.

To verify that the module has been installed, run this cmdlet:

`Get-Module -ListAvailable

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture42-1-1024x202.png)

7. **How do I import a PowerShell module?**

Starting in PowerShell 3.0, installed modules are automatically imported to the session when you use any commands or providers in the module. However, you can use the **Import-Module** cmdlet to import any installed module, as illustrated here:

`Import-Module ActiveDirectory

`Import-Module AzureAD

8. **How can I get information about a particular PowerShell command?**

To see the syntax, parameters and description of a cmdlet, use **Get-Help**:

`Get-Help Set-ADUser

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture43-1-1024x551.png)

To see examples of the cmdlet, add the **-Examples** switch:

`Get-Help Set-ADUser -Examples

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture44-1-1024x553.png)


9. **How can I see the PowerShell cmdlet that is similar to a particular command prompt command?**

The **Get-Alias** command will show you the PowerShell cmdlets that are equivalent to the specified command prompt commands, as illustrated here:

`Get-Alias CD, Dir, CLS

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture45-1.png)

To see the PowerShell equivalents for all command prompt commands, type **Get-Alias** with no parameter. Note that the list will also include simplified aliases for PowerShell cmdlets (in fact, those will be the bulk of the list).

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture46-1.png)

10. **How can I open the PowerShell integrated scripting environment (ISE)?**

Click the **Start** button, scroll down to the **Windows PowerShell** folder, expand it and click **PowerShell ISE**, as shown here:

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture47-1.png)

The screenshot below shows the PowerShell ISE. It has three main sections: the scripting pane, the console, and a list of cmdlets on the right. You can select a different module to see its cmdlets.

![](https://cdn-blog.netwrix.com/wp-content/uploads/2023/10/Picture48-1024x531.png)

