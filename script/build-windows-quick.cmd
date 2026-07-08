@echo off

rem Start delaying variable expansion
setlocal ENABLEDELAYEDEXPANSION

echo [Windows] Running quick (re)build ...
set CCACHE_SLOPPINESS=time_macros
set MY_PROJECT_SHOULD_DISABLE_CLEAN_BUILD=ON
set MY_PROJECT_WITH_COMPILER_CACHE=ON
call "%~dp0\build-windows-preset.cmd"
if "%ERRORLEVEL%" neq "0" (
    exit /b !ERRORLEVEL!
)

rem End delaying variable expansion
endlocal
