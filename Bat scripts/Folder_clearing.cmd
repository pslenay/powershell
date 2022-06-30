@echo off
setlocal enableextensions enabledelayedexpansion

if exist "%~1" (
    echo Clearing folders in [%~1].
    pushd "%~1" && (rmdir /s /q "%~1" & popd) 2>nul
) else (
    echo Not found [%~1]
)

endlocal
exit /b 0 