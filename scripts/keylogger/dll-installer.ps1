#################################################################
#.___________..______       __  ___   ___ ... PWENED
#|           ||   _  \     |  | \  \ /  / 
#`---|  |----`|  |_)  |    |  |  \  V  /  
#    |  |     |      /     |  |   >   <   
#    |  |     |  |\  \----.|  |  /  .  \  
#    |__|     | _| `._____||__| /__/ \__\ ... PWENED
#    
#POWERSHELL SCRIPT TO DOWNLOAD dll FILES AND REGISTER IT 
#EXECUTION TIME 1 SECONDS
#CODED BY SMUKX
#GITHUB: https://github.com/Whitecat18
#BLOG: https://smukx.github.io
##################################################################

#NOTE : RUN THIS SCRIPT AS ADMINISTRATOR

$libgccUrl = "https://github.com/Whitecat18/Ps-script-for-Hackers-and-Pentesters/raw/main/scripts/dll%20files/libgcc_s_dw2-1.dll"
$libstdcUrl = "https://github.com/Whitecat18/Ps-script-for-Hackers-and-Pentesters/raw/main/scripts/dll%20files/libstdc%2B%2B-6.dll"

$libgccPath = "$env:TEMP\libgcc_s_dw2-1.dll"
$libstdcPath = "$env:TEMP\libstdc++-6.dll"

Invoke-WebRequest -Uri $libgccUrl -OutFile $libgccPath
Invoke-WebRequest -Uri $libstdcUrl -OutFile $libstdcPath

regsvr32 $libgccPath
regsvr32 $libstdcPath
