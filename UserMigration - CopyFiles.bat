@echo on
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

REM create dependence files wtf am i suppose to create?!?!?
setlocal

REM setting up environment if first run
if not exist %~d0\logs (
	mkdir logs
	mkdir profiles
REM	mkdir "dependence files"
)

set profileName=%USERNAME%
set date=%date:~-4,4%%date:~-7,2%%date:~-10,2%

REM local computer file locations
set localComputerPrepath=C:\Users\%USERNAME%

REM location within storage device
mkdir %~d0\profiles\%profileName%-%date%
mkdir %~d0\logs\%profileName%-%date%
set profileFolder=%profileName%-%date%
set flashDrivePrepath=%~d0\profiles\%profileFolder%
set flashDriveLogPrePath=%~d0\logs\%profileName%-%date%


robocopy %localComputerPrepath%\Desktop %flashDrivePrepath%\Desktop /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\DesktopLog.txt

robocopy %localComputerPrepath%\Documents %flashDrivePrepath%\Documents /MIR /NP /TEE /XD "My Music" "My Pictures" "My Videos" /LOG+:%flashDriveLogPrePath%\Documents.txt

robocopy %localComputerPrepath%\Downloads %flashDrivePrepath%\Downloads /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Downloads.txt

robocopy %localComputerPrepath%\Favorites %flashDrivePrepath%\Favorites /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Favorites.txt

robocopy %localComputerPrepath%\MicrosoftEdgeBackups %flashDrivePrepath%\MicrosoftEdgeBackups /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\MicrosoftEdgeBackups.txt

robocopy %localComputerPrepath%\Music %flashDrivePrepath%\Music /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Music.txt

robocopy %localComputerPrepath%\Pictures %flashDrivePrepath%\Pictures /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Pictures.txt

robocopy %localComputerPrepath%\Videos %flashDrivePrepath%\Videos /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Videos.txt

set chromeFolder="C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default"
REM check if default folder is same on all computers
set firefoxFolder="C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\s4bm1y53.default"

if exist %chromeFolder% (
	copy %chromeFolder%\Bookmarks %flashDrivePrepath%
)

if exist %firefoxFolder% (
	copy %firefoxFolder%\places.sqlite %flashDrivePrepath%
)









