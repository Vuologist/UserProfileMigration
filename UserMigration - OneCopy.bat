@echo on
REM Anthony Vu 12/16/17
REM This script will import files from the flash drive to the
REM user's computer as a profile migration.
REM
REM Folders: Desktop, Documents, Downloads, Favorites,
REM 		 MicrosoftEdgeBackups, Music, Pictures, Videos
REM 
REM Bookmarks: Firefox, Chrome, IE, Edge
REM
REM default environment is copied over as well; if on c_admin profile
REM bark

REM only copies one profile
REM create dependence files wtf am i suppose to create?!?!?
setlocal

REM this script will start in the flashdrive, but will take the old hdd file path and then copy to the new hdd file path. it seem like the old hdd filepath will be different every time account for that
REM old hdd will come up as "Windows"


REM setting up environment if first run
if not exist %~d0\OneCopyExportLogs (
	mkdir OneCopyExportLogs
)

set profileName=%USERNAME%

REM local computer file locations
set localComputerPrepath=C:\Users\%USERNAME%

REM location within storage device
set date=%date:~-4,4%%date:~-7,2%%date:~-10,2%
mkdir %~d0\ExportLogs\%profileName%-%date%
REM set profileFolder=%profileName%-%date%
set flashDrivePrepath=%~d0\Users\%profileName%
set flashDriveLogPrePath=%~d0\ExportLogs\%profileName%-%date%


robocopy %flashDrivePrepath%\Desktop %localComputerPrepath%\Desktop /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\DesktopLog.txt

robocopy %flashDrivePrepath%\Documents %localComputerPrepath%\Documents /MIR /NP /TEE /XD "My Music" "My Pictures" "My Videos" /LOG+:%flashDriveLogPrePath%\Documents.txt

robocopy %flashDrivePrepath%\Downloads %localComputerPrepath%\Downloads /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Downloads.txt

robocopy %flashDrivePrepath%\Favorites %localComputerPrepath%\Favorites /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Favorites.txt

robocopy %flashDrivePrepath%\MicrosoftEdgeBackups %localComputerPrepath%\MicrosoftEdgeBackups /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\MicrosoftEdgeBackups.txt

robocopy %flashDrivePrepath%\Music %localComputerPrepath%\Music /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Music.txt

robocopy %flashDrivePrepath%\Pictures %localComputerPrepath%\Pictures /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Pictures.txt

robocopy %flashDrivePrepath%\Videos %localComputerPrepath%\Videos /MIR /NP /TEE /LOG+:%flashDriveLogPrePath%\Videos.txt


REM check to see if folder exist and if application is open, wait if fail
set chromeFolder="C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default"
REM check if default folder is same on all computers
set firefoxFolder="C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\s4bm1y53.default"

if exist %chromeFolder% (
	copy %flashDrivePrepath% %chromeFolder%\Bookmarks
)

REM firefox folder changes so use a for loop to look for the default file and substring the beginning

if exist %firefoxFolder% (
	copy %flashDrivePrepath% %firefoxFolder%\places.sqlite
)

REM maybe check for printers and add







