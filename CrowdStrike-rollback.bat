@echo off
setlocal

:: Check if running in Safe Mode
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system is not in Safe Mode. Please restart in Safe Mode or Windows Recovery Environment.
    exit /b
)

:: Path to the CrowdStrike directory
set "directoryPath=C:\Windows\System32\drivers\CrowdStrike"

:: Check if the directory exists
if exist "%directoryPath%" (
    :: Search for and delete the file matching the pattern
    for %%F in ("%directoryPath%\C-00000291*.sys") do (
        del /f "%%F"
        echo File deleted: %%F
    )

    :: Check if any files were deleted
    if errorlevel 1 (
        echo No files matching the pattern C-00000291*.sys were found
    )
) else (
    echo The directory %directoryPath% does not exist.
)

:: Restart the system
shutdown /r /t 0
