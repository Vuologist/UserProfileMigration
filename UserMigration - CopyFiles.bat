@echo off
REM Anthony Vu 12/16/17
REM This script will copy specific folders and files from the
REM user's computer in order to be migrated to a new computer.
REM
REM Folders: Desktop, Documents, Downloads, Favorites,
REM 		 MicrosoftEdgeBackups, Music, Pictures, Videos
REM 
REM Bookmarks: Firefox, Chrome, IE, Edge
REM
REM Version 2 idea: make sure a new file or folder not apart of
REM default environment is copied over as well; if on c_admin profile
REM bark

REM create support files such as log and dependence files
REM need to create log files
setlocal

REM setting up environment if first run
if not exist %~d0\logs (
	mkdir logs
	mkdir dependence files
)

set profileName=%USERNAME%
set date=%date:~-4,4%%date:~-7,2%%date:~-10,2%

REM local computer file locations
set localComputerPrepath=C:\Users\%USERNAME%

REM location within storage device
mkdir "%profileName% - %date%"
mkdir %~d0\logs\%profileName% - %date%
set profileFolder="%profileName% - %date%"
set flashDrivePrepath=%~d0\%profileFolder%


robocopy %localComputerPrepath%\Desktop %flashDrivePrepath%\Desktop /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Desktop"

robocopy %localComputerPrepath%\Documents %flashDrivePrepath%\Documents /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Documents"

robocopy %localComputerPrepath%\Downloads %flashDrivePrepath%\Downloads /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Downloads"

robocopy %localComputerPrepath%\Favorites %flashDrivePrepath%\Favorites /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Favorites"

robocopy %localComputerPrepath%\MicrosoftEdgeBackups %flashDrivePrepath%\MicrosoftEdgeBackups /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%MicrosoftEdgeBackups"

robocopy %localComputerPrepath%\Music %flashDrivePrepath%\Music /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Music"

robocopy %localComputerPrepath%\Pictures %flashDrivePrepath%\Pictures /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Pictures"

robocopy %localComputerPrepath%\Videos %flashDrivePrepath%\Videos /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Videos"













