@echo off

setlocal
echo [Windows] Running clean (re)build ...
set MY_PROJECT_SHOULD_DISABLE_CLEAN_BUILD=OFF
set MY_PROJECT_WITH_COMPILER_CACHE=OFF
call %~dp0\build-windows-preset.cmd
if "%ERRORLEVEL%" neq "0" (
    exit /b !ERRORLEVEL!
)
endlocal
