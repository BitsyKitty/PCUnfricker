# Check for admin rights
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host "Restarting script as Administrator..."
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
Write-Host  "____   ____   _   _        __      _      _             _ "
Write-Host "|  _ \ / ___| | | | |_ __  / _|_ __(_) ___| | _____ _ __| |"
Write-Host "| |_) | |     | | | | '_ \| |_| '__| |/ __| |/ / _ \ '__| |"
Write-Host "|  __/| |___  | |_| | | | |  _| |  | | (__|   <  __/ |  |_|"
Write-Host "|_|    \____|  \___/|_| |_|_| |_|  |_|\___|_|\_\___|_|  (_)"

Write-Host ""
Write-Host "Welcome to PC Unfricker... Unfrick your stuff! By BitsyKitty"
Write-Host ""

Write-Host "WARNING: This script requires a stable internet connection"
Write-Host ""

Start-Transcript -Path "C:\Users\$env:USERNAME\Desktop\PCUnfrickerLog.txt"

Write-Host ""
Write-Host "Running DISM, this may take a while..."
DISM /Online /Cleanup-Image /RestoreHealth
Write-Host ""
Write-Host "DISM done..."
Write-Host ""

Write-Host ""
Write-Host "Running SFC..."
sfc /scannow
Write-Host ""
Write-Host "SFC done"
Write-Host ""

cls 

Write-Host ""
Write-Host "Updating Applications"
winget upgrade --all --accept-source-agreements --accept-package-agreements
Write-Host ""
Write-Host "Applications updated"
Write-Host ""

cls

Write-Host ""
Write-Host "Clearing the local DNS resolver cache..."
ipconfig /flushdns
Write-Host ""

Start-Sleep -Seconds 2

Write-Host ""
Write-Host "Resetting Windows Socket API..."
netsh winsock reset
Write-Host ""

Start-Sleep -Seconds 2

Write-Host ""
Write-Host "Resetting TCP/IP Stack..."
netsh int ip reset
Write-Host ""

Start-Sleep -Seconds 2

cls


$title = "Run CHKDSK?"
$message = "Would you like to run CHKDSK to attempt to repair any drive errors? NOTE: This requires a restart, and can take up to an hour or more depending on your drive size."
$choices = "&Yes", "&No"
$decision = $Host.UI.PromptForChoice($title, $message, $choices, 1) # Default is No (index 1)

if ($decision -eq 0) {
    Write-Host "Executing CHKDSK upon next restart..."
    Write-Output "Y" | chkdsk /f /r
}


Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "All commands completed. Restarting in 30 seconds"
Write-Host "Press Ctrl+C to cancel restart and close the script"
Write-Host "NOTE: Restarting is highly reccomended after running this script"
for ($i = 30; $i -gt 0; $i--) {
    Write-Host -NoNewLine "`rTime Remaining: $i seconds "
    Start-Sleep -Seconds 1
}   

Write-Host "Press Ctrl+C to cancel restart and close the script"
Write-Host "NOTE: Restarting is highly reccomended after running this script"

Stop-Transcript

Start-Sleep -Seconds 1

Restart-Computer -Force
