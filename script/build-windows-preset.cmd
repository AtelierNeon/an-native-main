@echo off

setlocal
echo [Windows] Applying preset options ...
set MY_PROJECT_EXPAT_WITHOUT_APPS=ON
set MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_EXPAT_WITHOUT_TEST_APPS=ON
set MY_PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS=OFF
set MY_PROJECT_OPENSSL_WITH_SHARED_LIBRARIES=OFF
set MY_PROJECT_OPENSSL_WITH_ZLIB=ON
set MY_PROJECT_OPENSSL_WITHOUT_APPS=ON
set MY_PROJECT_OPENSSL_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PCRE_WITHOUT_APPS=ON
set MY_PROJECT_PCRE_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PCRE_WITHOUT_TEST_APPS=ON
set MY_PROJECT_SQLITE_WITHOUT_APPS=ON
set MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_ZLIB_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_ZLIB_WITHOUT_TEST_APPS=ON
echo [Windows] Applying default options ... DONE
call %~dp0\build-windows.cmd
if "%ERRORLEVEL%" neq "0" (
    exit /b !ERRORLEVEL!
)
endlocal
