*Currently this script does not work as expected due to dropbox downloads stopping before completion without warning or error. You can replace the download link with one of your own. Also it fails to install as a WSL2 instance and is also not upgradable.*
# SRT-customKali-WSL2
This gets a kali custom rootfs installed and ready to use on LP+, it is all hardcoded. sorry..
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
