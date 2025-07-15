@echo off
title BitLocker Removal Tool
setlocal
echo Program Name: BitLocker Removal Tool
echo Version: 2.0.2
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli
"%windir%\System32\net.exe" session > nul 2>&1
if not "%errorlevel%"=="0" goto "NotAdministrator"
goto "Start"

:"NotAdministrator"
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto "Done"

:"Start"
echo.
echo Getting drives attached to this PC details.
"%windir%\System32\manage-bde.exe" -status
echo Got drives attached to this PC details.
goto "DriveLetter"

:"DriveLetter"
echo.
set DriveLetter=
set /p DriveLetter="What is the drive letter of your BitLocker locked/unlocked drive? (A:-Z:) "
if /i "%DriveLetter%"=="A:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="B:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="C:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="D:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="E:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="F:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="G:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="H:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="I:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="J:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="K:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="L:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="M:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="N:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="O:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="P:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="Q:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="R:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="S:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="T:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="U:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="V:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="W:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="X:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="Y:" goto "SureDriveLetter"
if /i "%DriveLetter%"=="Z:" goto "SureDriveLetter"
echo Invalid syntax!
goto "DriveLetter"

:"SureDriveLetter"
echo.
set SureDriveLetter=
set /p SureDriveLetter="Are you sure "%DriveLetter%" is the drive letter of your BitLocker locked/unlocked drive? (Yes/No) "
if /i "%SureDriveLetter%"=="Yes" goto "CheckExistDriveLetter"
if /i "%SureDriveLetter%"=="No" goto "DriveLetter"
echo Invalid syntax!
goto "SureDriveLetter"

:"CheckExistDriveLetter"
if not exist "%DriveLetter%" goto "NotExist"
goto "Status"

:"NotExist"
echo "%DriveLetter%" does not exist. Please try again.
goto "DriveLetter"

:"Status"
echo.
echo Getting BitLocker status for drive "%DriveLetter%".
"%windir%\System32\manage-bde.exe" -status -p "%DriveLetter%" > nul 2>&1
if not "%errorlevel%"=="0" goto "NoBitLocker"
echo Drive "%DriveLetter%" has BitLocker.
goto "Data"

:"NoBitLocker"
echo No BitLocker on drive "%DriveLetter%"! Press any key to continue.
pause > nul 2>&1
goto "Start"

:"Data"
echo.
set Data=
set /p Data="All data on drive "%DriveLetter%" will be deleted. Are you sure you want to continue? (Yes/No) "
if /i "%Data%"=="Yes" goto "Format"
if /i "%Data%"=="No" goto "Done"
echo Invalid syntax!
goto "Data"

:"Format"
if exist "diskpart.txt" goto "DiskPartExist"
echo.
echo Removing BitLocker on drive letter "%DriveLetter%".
(echo sel vol %DriveLetter%) > "DiskPart.txt"
(echo format quick override) >> "DiskPart.txt"
(echo exit) >> "DiskPart.txt"
"%windir%\System32\diskpart.exe" /s "diskpart.txt" > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
if /i "%DiskPart%"=="True" goto "DiskPartDone"
goto "Done"

:"DiskPartExist"
set DiskPart=True
echo.
echo Please temporarily rename to something else or temporarily move to another location "diskpart.txt" in order for this batch file to proceed. "diskpart.txt" is not a system file. "diskpart.txt" is located in the folder "%cd%". Press any key to continue when "diskpart.txt" is renamed to something else or moved to another location. This batch file will let you know when you can rename it back to its original name or move it back to its original location.
pause > nul 2>&1
goto "Format"

:"Error"
echo There has been an error! You can try again.
goto "Start"

:"DiskPartDone"
echo.
echo You can now rename or move the file back to "diskpart.txt". Press any key to continue.
pause > nul 2>&1
goto "Done"

:"Done"
echo BitLocker removed on drive letter "%DriveLetter%"! Press any key to close this batch file.
endlocal
pause > nul 2>&1
exit
