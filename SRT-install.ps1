# A script to install my custom kali WSL instance using a rootFS on LP+
<# Pre-reqs: 
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Restart-Computer

root CA installed

the ability to download
#>
$kaliHash = "8A8BDCE93B535831E02AF141379EB3FBAC3C811310904180A6C135719B7683FD"

Write-Host "Downloading WSL Kernel.`n"
cd ~\desktop

Invoke-Webrequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -outfile wsl_update_x64.msi
Invoke-Item .\wsl_update_x64.msi
Write-Host "Complete the install before continuing."
Pause
Remove-Item .\wsl_update_x64.msi

Write-Host "Attempting to set WSL Version to 2.`n"
wsl.exe --set-default-version 2

$ProgressPreference = 'SilentlyContinue'
Write-Host "Downloading root filesystem. Progress will not be displayed to improve download speed.`n"
# Add dl=1 to download from cmd line when using dropbox
iwr https://www.dropbox.com/s/<redacted>/kali-linux-rolling-wsl-rootfs-amd64.tar.gz?dl=1 -o kali-linux-rolling-wsl-rootfs-amd64.tar.gz
$dlHash = Get-FileHash -Algorithm sha256 .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz
Write-Host "Original file hash: $kaliHash"
Write-Host "Download file hash: $dlHash.Hash"

Write-Host "Downloading LxRunOffline.`n"
iwr https://github.com/DDoSolitary/LxRunOffline/releases/download/v3.5.0/LxRunOffline-v3.5.0-msvc.zip -o lxrun.zip
Expand-Archive .\lxrun.zip
.\lxrun\LxRunOffline.exe install -n kali -d .\kali\ -f .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz

# More cleanup
Remove-Item .\lxrun.zip
Remove-Item .\lxrun -Recurse
Remove-Item .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz

wsl --list --verbose
Write-Host "You should see kali above and in a stopped state if this script worked. Quite possibly even if it didn't.."
