## SILENT INSTALLER

How to install programs in computers using cli using packages . So If you got an reverse shell . If you need to perform any Inter process . you need to isntall the programs without the user Knowledge

### USING POWERSHELL TO INSTALL PROGRAMS 

#### METHOD 1
```
Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i "C:\Path\to\installer.msi" /qn' -Wait
```
This command will install applications in silent Mode . without user known ! 

#### METHOD 2

```
Start-Process C:\New\antivirus.exe -ArgumentList "/S /v/qn"
```

The Alternate for 1st Method .

#### METHOD 3

```
Start-Process "C:\New\antivirus.exe" -Argument "/Silent" -PassThru
```

Here, the “-PassThru” option will ask for the confirmation for once, before executing the specified exe file


### INSTALLING PYTHON USING POWERSHELL

As you all know python makes easy for All to Make tasks Easier . This is applicable to Hackers or Pentesters . so using python you can do active directory within minues, Recon the Whole System 
and Run unlimited payloads and undetectable keylogger . 

* Download the Python Program From Official Website <a href="https://www.python.org/downloads/windows/" > For Windows <a/>
* Run the below Command <br>

```
.\python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
```

In this command the /quiet option is used to run the installation silently without any user interface. The InstallAllUsers=1 option installs Python for all users on the system. 
The PrependPath=1 option adds Python to the system's PATH environment variable, allowing you to run Python from any location. 
The Include_test=0 option excludes the installation of test suite files.


**Note**

After executing the command, the Python programming language will be installed silently on your Windows system using PowerShell. You can verify the installation by opening a new PowerShell window and running python --version to check the Python version.








