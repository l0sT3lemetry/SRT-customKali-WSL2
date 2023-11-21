# A script to install my custom kali WSL instance on LP+
<# Pre-reqs: 
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Restart-Computer

root CA installed

the ability to download
#>
$kaliHash = "8A8BDCE93B535831E02AF141379EB3FBAC3C811310904180A6C135719B7683FD"

Write-Host "Attempting to install."
cd ~\desktop

Invoke-Webrequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -outfile wsl_update_x64.msi
Start-Sleep -Seconds 1
Invoke-Item .\wsl_update_x64.msi
Write-Host "Complete the install before continuing."
Pause
#Remove-Item .\wsl_update_x64.msi

Start-Sleep -Seconds 1

wsl.exe --set-default-version 2

Write-Host "Downloading root filesystem."
# Add dl=1 to download from cmd line when using dropbox
iwr https://www.dropbox.com/s/<redacted>/kali-linux-rolling-wsl-rootfs-amd64.tar.gz?dl=1 -o kali-linux-rolling-wsl-rootfs-amd64.tar.gz
$dlHash = Get-FileHash -Algorithm sha256 .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz
$kaliHash
$dlHash.Hash

Write-Host "Downloading LxRunOffline."
iwr https://github.com/DDoSolitary/LxRunOffline/releases/download/v3.5.0/LxRunOffline-v3.5.0-msvc.zip -o lxrun.zip

Start-Sleep -Seconds 1

Expand-Archive .\lxrun.zip

Start-Sleep -Seconds 1

.\lxrun\LxRunOffline.exe install -n kali -d .\kali\ -f .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz

# more cleanup
Remove-Item .\lxrun.zip
Remove-Item .\lxrun -Recurse
Remove-Item .\kali-linux-rolling-wsl-rootfs-amd64.tar.gz

wsl --list --verbose
Write-Host "You should see kali above and in a stopped state if this script worked."
