# PCUnfricker
PowerShell scripting project I started to learn the language. The script is meant to execute commands to help a PC run better, and was made mainly for my friends to use. 

PCUnfricker first checks for admin rights to run the script due to the commands that it executes. Then will restart the script as administrator if needed.

Once the script has the necessary rights, it starts a transcript that saves to a text file on the active user's Desktop folder.

The first command that the script runs is ‘DISM /Online /Cleanup-Image /Restorehealth’, followed by ‘SFC /scannow’ to verify integrity of the files after DISM runs. Next, it looks for available application updates using winget with the -all, --accept-source-agreements and, --accept-package-agreements flags. 

Next PCUnfricker runs commands meant to help with network issues. The first being 'ipconfig /flushdns', then 'netsh winsock reset', followed by 'netsh int ip reset'. 

The last command that PCUnfricker can run is 'chkdsk /f /r' which does not run automatically. Since this command only works upon next restart, and can take up to an hour or more, I used a ‘$decsion’ variable that relies on a  Y/N input from the user to confirm if they'd like to run it or not upon next restart.

After the user makes their choice, PCUnfricker will notify that all commands are completed and start a 30 countdown timer to automatic restart, with a note that restarting is highly recommended (since some commands rely on a restart to take effect). The user is also notified that they can cancel the restart by doing Ctrl+C to close the script, in case they have anything to take care of that may take longer than 30 seconds. 

Right before restart, PCUnfricker stops the transcript, and will wait 1 more second.

I tried to add blank lines to space out the commands, as well as add brief pauses and screen clears between the commands to make the script slightly more visible and readable in terms of what is showing up on the PowerShell screen, rather than a blur of command after command.

