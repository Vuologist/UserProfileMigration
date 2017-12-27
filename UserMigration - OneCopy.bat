@echo on
REM Anthony Vu 12/16/17
REM This script will copy files from the old HDD to the
REM user's new computer as a profile migration. The script will
REM start in a flash drive where the log files will also be
REM stored.
REM
REM Folders: Desktop, Documents, Downloads, Favorites,
REM 		 MicrosoftEdgeBackups, Music, Pictures, Videos
REM 
REM Bookmarks: Firefox, Chrome, IE, Edge
REM
REM Limitations: **only copies the profile of the user logged in
REM 			 **firefox and chrome need to be open first before bookmarks
REM 			   can be copied over
REM 
REM version 2.0 idea: default environment is copied over as well; if on c_admin profile, bark;
REM give an option to either mirror copy the old profile, just default folders, or default folders and extra files; 
REM create a for loop to loop through a user folder and copy ones that contain
REM the user's name even if it's on a different domain;

setlocal EnableDelayedExpansion
set profileName=%USERNAME%
set localComputerFilePath=C:\Users\%USERNAME%
set date=%date:~-4,4%%date:~-7,2%%date:~-10,2%

REM setting up environment if first run
if not exist %~d0\OneCopyExportLogs (
	mkdir OneCopyExportLogs
)

REM location within storage device
mkdir %~d0\ExportLogs\%profileName%-%date%
REM set profileFolder=%profileName%-%date%
set flashDriveLogFilePath=%~d0\ExportLogs\%profileName%-%date%


REM it seem like the old hdd filepath will be different every time account for that
REM  2=Removable(USB,Firewire)
set oldHDDDriveLeter=
for /f "skip=1 tokens=1,2,3 delims=," %%i in ('wmic logicaldisk where "drivetype=2" get volumename,DeviceId /format:csv') do (
    if NOT %%j==%~d0 (
		set %oldHDDDriveLeter%=%%j
	)
)
REM might throw error here
set flashDriveFilePath=%oldHDDDriveLeter%\Users\%profileName%

robocopy %flashDriveFilePath%\Desktop %localComputerFilePath%\Desktop /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\DesktopLog.txt

robocopy %flashDriveFilePath%\Documents %localComputerFilePath%\Documents /MIR /NP /TEE /XD "My Music" "My Pictures" "My Videos" /LOG+:%flashDriveLogFilePath%\Documents.txt

robocopy %flashDriveFilePath%\Downloads %localComputerFilePath%\Downloads /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\Downloads.txt

robocopy %flashDriveFilePath%\Favorites %localComputerFilePath%\Favorites /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\Favorites.txt

robocopy %flashDriveFilePath%\MicrosoftEdgeBackups %localComputerFilePath%\MicrosoftEdgeBackups /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\MicrosoftEdgeBackups.txt

robocopy %flashDriveFilePath%\Music %localComputerFilePath%\Music /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\Music.txt

robocopy %flashDriveFilePath%\Pictures %localComputerFilePath%\Pictures /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\Pictures.txt

robocopy %flashDriveFilePath%\Videos %localComputerFilePath%\Videos /MIR /NP /TEE /LOG+:%flashDriveLogFilePath%\Videos.txt

start chrome.exe /d "C:\Program Files (x86)\Google\Chrome\Application" https://www.google.com
ping 192.0.2.2 -n 1 -w 3000 > nul
taskkill /IM chrome.exe /F
start firefox.exe /d "C:\Program Files\Mozilla Firefox" https://www.google.com
ping 192.0.2.2 -n 1 -w 3000 > nul
taskkill /IM firefox.exe /F

set chromeFolder="C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default"

REM default firefox folder is different on each computer
set profileFolder=
for /d "tokens=1,2 delims=. " %%i in (C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles) do (
	if (%%j=="default") (
		REM might throw error need to check: won't combine strings
		set profileFolder=%%i.%%j
	)
)

set firefoxFolder="C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\%profileFolder%"

if exist %chromeFolder% (
	copy %flashDriveFilePath% %chromeFolder%\Bookmarks
)

if exist %firefoxFolder% (
	copy %flashDriveFilePath% %firefoxFolder%\places.sqlite
)

pause
REM maybe check for printers and add



