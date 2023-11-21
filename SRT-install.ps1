# A script to install my custom kali WSL instance using a rootFS on LP+
<# Pre-reqs:
Run the following commands in an elevated prompt:
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Restart-Computer

Connect to platform, and enable the ability to download.
#>

$rootFS = "https://www.dropbox.com/s/<redacted>/kali-linux-rolling-wsl-rootfs-amd64.tar.gz?dl=1"
$outFile = "kali-linux-rolling-wsl-rootfs-amd64.tar.gz"
$kaliHash = "8A8BDCE93B535831E02AF141379EB3FBAC3C811310904180A6C135719B7683FD"

Write-Host "Downloading WSL Kernel.`n"
# This is just preference for the most part
cd ~\desktop
Invoke-Webrequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -outfile wsl_update_x64.msi
Invoke-Item .\wsl_update_x64.msi
Write-Host "Complete the install before continuing."
Pause

Write-Host "Setting Default WSL Version to 2."
wsl.exe --set-default-version 2

# This speeds up downloads in certain versions of powershell
$ProgressPreference = 'SilentlyContinue'
Write-Host "`nDownloading root filesystem. Progress will not be displayed to improve download speed.`n"
# Add dl=1 to download from cmd line when using dropbox
iwr $rootFS -o $outFile
$ProgressPreference = 'Continue'
$dlHash = Get-FileHash -Algorithm sha256 $outFile | select Hash
Write-Host "Original file hash: " $kaliHash
Write-Host "Download file hash: " $dlHash.Hash
if ( $kaliHash -eq $dlHash.Hash ) { Write-Host "Match." -ForegroundColor Green }
Else { "Download Corrupt or you didn't change the original file hash." -ForegroundColor Red }

Write-Host "Downloading LxRunOffline.`n"
iwr https://github.com/DDoSolitary/LxRunOffline/releases/download/v3.5.0/LxRunOffline-v3.5.0-msvc.zip -o lxrun.zip
Expand-Archive .\lxrun.zip
.\lxrun\LxRunOffline.exe install -n kali-SRT -d .\kali-SRT\ -f .\$outFile

Remove-Item .\wsl_update_x64.msi
Remove-Item .\lxrun.zip
Remove-Item .\lxrun -Recurse
Remove-Item $outFile

Write-Host "Converting to WSL version 2."
# Comment out the next line if you prefer WSL 1, it will get you started considerably faster
wsl --set-version kali-SRT 2
wsl --list --verbose
Write-Host "`nYou should see kali above and in a stopped state if this script worked." -ForegroundColor Cyan
