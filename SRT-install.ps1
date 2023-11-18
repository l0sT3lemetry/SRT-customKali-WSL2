# A script to install my custom kali WSL instance on LP+
<# Pre-reqs: 
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Restart-Computer

root CA installed

the ability to download
#>

Write-Host "I hope you won't regret this... installing."
cd ~

Invoke-Webrequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -outfile wsl_update_x64.msi
Invoke-Item .\wsl_update_x64.msi
Write-Host "Complete the install before continuing."
Pause
Remove-Item .\wsl_update_x64.msi

wsl --set-default-version 2

Write-Host "Downloading root filesystem and LxRunOffline, it's up to you to trust these files."
# Add dl=1 to download from cmd line when using dropbox
iwr https://www.dropbox.com/s/<redacted>/kali-linux-rolling-wsl-rootfs-amd64.tar.gz?dl=1 -o kali-linux-rolling-wsl-rootfs-amd64.tar.gz
iwr https://github.com/DDoSolitary/LxRunOffline/releases/download/v3.5.0/LxRunOffline-v3.5.0-msvc.zip -o lxrun.zip

Expand-Archive .\lxrun.zip
Remove-Item .\lxrun.zip
.\lxrun\LxRunOffline.exe install -n kali-WSL2 -d .\kali\ -f .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz

# more cleanup
Remove-Item .\lxrun -Recurse
Remove-Item .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz

wsl --list --verbose
Write-Host "You should see kali above and in a stopped state if this script worked."
