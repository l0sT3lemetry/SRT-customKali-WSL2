# SRT-customKali-WSL2
This gets a kali custom rootfs installed and ready to use on LP+
## Install rootfs
Powershell as Admin.
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Restart-Computer
```
Then run the script.
