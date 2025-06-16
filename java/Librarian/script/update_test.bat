@echo off
setlocal enabledelayedexpansion

set ZIPFILE=var\update.zip
set DESTDIR=%CD%\var\update_test
set TEMP_UNPACK=%TEMP%\update_unpack

echo Unpack %ZIPFILE% to %TEMP_UNPACK%...
rmdir /s /q "%TEMP_UNPACK%" >nul 2>&1
powershell -Command "Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%TEMP_UNPACK%' -Force"

if errorlevel 1 (
    echo Failed to unpack updade.
    goto end
)

echo Copy files and directory to %DESTDIR%...
xcopy "%TEMP_UNPACK%\*" "%DESTDIR%\" /E /I /Y /Q

echo Cleanup...
rmdir /s /q "%TEMP_UNPACK%" >nul 2>&1

:end
echo Done!
echo Now app would start...
pause
exit 0
endlocal