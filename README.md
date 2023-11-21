# SRT-customKali-WSL2
This gets a kali custom rootfs installed and ready to use on LP+, it is all hardcoded, will add args later. Pull requests are welcome.
## Install rootfs
Powershell as Admin.
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Restart-Computer
```
Download script
```
iwr https://raw.githubusercontent.com/l0sT3lemetry/SRT-customKali-WSL2/main/SRT-install.ps1 -o SRT-install.ps1
```
Then run the script.
