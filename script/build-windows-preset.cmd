@echo off

setlocal
echo [Windows] Applying preset options ...
set MY_PROJECT_BOOST_WITHOUT_APPS=ON
set MY_PROJECT_BOOST_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_CARES_WITHOUT_APPS=ON
set MY_PROJECT_CARES_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_CARES_WITHOUT_TEST_APPS=ON
set MY_PROJECT_CJSON_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_CJSON_WITHOUT_TEST_APPS=ON
set MY_PROJECT_CURL_WITH_OPENSSL=ON
set MY_PROJECT_CURL_WITH_ZLIB=ON
set MY_PROJECT_CURL_WITHOUT_APPS=ON
set MY_PROJECT_CURL_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_EXPAT_WITHOUT_APPS=ON
set MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_EXPAT_WITHOUT_TEST_APPS=ON
set MY_PROJECT_NETSNMP_WITH_IPV6=ON
set MY_PROJECT_NETSNMP_WITH_SSL=ON
set MY_PROJECT_NETSNMP_WITH_WINEXTDLL=ON
set MY_PROJECT_NETSNMP_WITHOUT_APPS=ON
set MY_PROJECT_NETSNMP_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_NETSNMP_WITHOUT_MIB_LOADING=ON
set MY_PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS=OFF
set MY_PROJECT_OPENSSL_WITH_SHARED_LIBRARIES=OFF
set MY_PROJECT_OPENSSL_WITH_ZLIB=ON
set MY_PROJECT_OPENSSL_WITHOUT_APPS=ON
set MY_PROJECT_OPENSSL_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PAHO_WITH_OPENSSL=ON
set MY_PROJECT_PAHO_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PAHO_WITHOUT_TEST_APPS=ON
set MY_PROJECT_PCRE_WITHOUT_APPS=ON
set MY_PROJECT_PCRE_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PCRE_WITHOUT_TEST_APPS=ON
set MY_PROJECT_POCO_WITHOUT_APPS=OFF
set MY_PROJECT_POCO_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PROTOBUF_WITH_ZLIB=ON
set MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL=ON
set MY_PROJECT_PROTOBUF_WITHOUT_TEST_APPS=ON
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
