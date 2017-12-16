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
set desktop=C:\Users\%USERNAME%\Desktop
set documents=C:\Users\%USERNAME%\Documents
set downloads=C:\Users\%USERNAME%\Downloads
set favorities=C:\Users\%USERNAME%\Favorites
set microsoftEdgeBackups=C:\Users\%USERNAME%\MicrosoftEdgeBackups
set music=C:\Users\%USERNAME%\Music
set pictures=C:\Users\%USERNAME%\Pictures
set vidoes=C:\Users\%USERNAME%\Vidoes

REM location within storage device
mkdir "%profileName% - %date%"
mkdir %~d0\logs\%profileName% - %date%
set profileFolder="%profileName% - %date%"
set fdesktop=%~d0\%profileFolder%\Desktop
set fdocuments=%~d0\%profileFolder%\Documents
set fdownloads=%~d0\%profileFolder%\Downloads
set ffavorities=%~d0\%profileFolder%\Favorites
set fmicrosoftEdgeBackups=%~d0\%profileFolder%\MicrosoftEdgeBackups
set fmusic=%~d0\%profileFolder%\Music
set fpictures=%~d0\%profileFolder%\Pictures
set fvidoes=%~d0\%profileFolder%\Vidoes


robocopy %desktop% %fdesktop% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Desktop"

robocopy %documents% %fdocuments% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Documents"

robocopy %downloads% %fdownloads% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Downloads"

robocopy %favorities% %ffavorities% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Favorites"

robocopy %microsoftEdgeBackups% %fmicrosoftEdgeBackups% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%MicrosoftEdgeBackups"

robocopy %music% %fmusic% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Music"

robocopy %pictures% %fpictures% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Pictures"

robocopy %vidoes% %fvidoes% /MIR /NP /TEE /LOG+:"%~d0\%logs%\%profileName%Videos"













