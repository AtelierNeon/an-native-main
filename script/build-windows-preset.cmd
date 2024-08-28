@echo off

setlocal
echo [Windows] Applying preset options ...
set MY_PROJECT_EXPAT_WITHOUT_APPS=ON
set MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_EXPAT_WITHOUT_TEST_APPS=ON
set MY_PROJECT_SQLITE_WITHOUT_APPS=ON
set MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL=ON
echo [Windows] Applying default options ... DONE
call %~dp0\build-windows.cmd
if "%ERRORLEVEL%" neq "0" (
    exit /b !ERRORLEVEL!
)
endlocal
