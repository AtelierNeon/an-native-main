##
## Built-in config
##
$InformationPreference = 'Continue'
#$VerbosePreference = 'Continue'

##
## Global config
##
$CmakeCli = 'cmake'
$CmakeToolsetToGeneratorMap = @{
        'v120' = 'Visual Studio 12 2013'
        'v140' = 'Visual Studio 14 2015'
        'v141' = 'Visual Studio 15 2017'
        'v142' = 'Visual Studio 16 2019'
        'v143' = 'Visual Studio 17 2022'
}
$ProtocCli = 'protoc'
$ProtocVersionArchitectureToArchiveNameMap = @{
        '3.9.1_AMD64' = 'protoc-3.9.1-win64.zip'
        '3.9.1_ARM64' = 'protoc-3.9.1-win32.zip'
}
$ProjectFolder = Join-Path -Path $PSScriptRoot -ChildPath '..'
$SourceFolder = $ProjectFolder
$TempRootFolder = Join-Path -Path $ProjectFolder -ChildPath 'build'
$TempBuildFolder = Join-Path -Path $TempRootFolder -ChildPath 't'
$TempInstallFolder = Join-Path -Path $TempRootFolder -ChildPath 'i'

##
## Project config
##
####
#### Project level config
####
$ProjectProtocVersion = if ($Env:MY_PROJECT_PROTOC_VERSION) {$Env:MY_PROJECT_PROTOC_VERSION} else {'3.9.1'}
$ProjectReleaseType = if ($Env:MY_PROJECT_RELEASE_TYPE) {$Env:MY_PROJECT_RELEASE_TYPE} else {'Debug'}
$ProjectRevision = if ($Env:BUILD_NUMBER) {$Env:BUILD_NUMBER} else {'9999'}
$ProjectShouldDisableCleanBuild = if ($Env:MY_PROJECT_SHOULD_DISABLE_CLEAN_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_CLEAN_BUILD} else {'OFF'}
$ProjectShouldDisableParallelBuild = if ($Env:MY_PROJECT_SHOULD_DISABLE_PARALLEL_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_PARALLEL_BUILD} else {'OFF'}
$ProjectShouldDisable32BitBuild = if ($Env:MY_PROJECT_SHOULD_DISABLE_32BIT_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_32BIT_BUILD} else {'OFF'}
$ProjectShouldDisable64BitBuild = if ($Env:MY_PROJECT_SHOULD_DISABLE_64BIT_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_64BIT_BUILD} else {'OFF'}
$ProjectShouldDisableArmBuild = if ($Env:MY_PROJECT_SHOULD_DISABLE_ARM_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_ARM_BUILD} else {'OFF'}
$ProjectShouldDisableArm64ecBuild = if ($Env:MY_PROJECT_SHOULD_DISABLE_ARM64EC_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_ARM64EC_BUILD} else {'OFF'}
$ProjectShouldDisableX86Build = if ($Env:MY_PROJECT_SHOULD_DISABLE_X86_BUILD) {$Env:MY_PROJECT_SHOULD_DISABLE_X86_BUILD} else {'OFF'}
$ProjectToolset = if ($Env:MY_PROJECT_CMAKE_TOOLSET) {$Env:MY_PROJECT_CMAKE_TOOLSET} else {'v142'}
$ProjectWithCompilerCache = if ($Env:MY_PROJECT_WITH_COMPILER_CACHE) {$Env:MY_PROJECT_WITH_COMPILER_CACHE} else {'OFF'}
$ProjectWithCompilerPrecheck = if ($Env:MY_PROJECT_WITH_COMPILER_PRECHECK) {$Env:MY_PROJECT_WITH_COMPILER_PRECHECK} else {'OFF'}
$ProjectWithSharedVcrt = if ($Env:MY_PROJECT_WITH_SHARED_VCRT) {$Env:MY_PROJECT_WITH_SHARED_VCRT} else {'OFF'}
$ProjectWithStaticVcrt = if ($Env:MY_PROJECT_WITH_STATIC_VCRT) {$Env:MY_PROJECT_WITH_STATIC_VCRT} else {'ON'}
$ProjectWithWorkaroundArm64rt = if ($Env:MY_PROJECT_WITH_WORKAROUND_ARM64RT) {$Env:MY_PROJECT_WITH_WORKAROUND_ARM64RT} else {'OFF'}
$ProjectWithWorkaroundOptGy = if ($Env:MY_PROJECT_WITH_WORKAROUND_OPT_GY) {$Env:MY_PROJECT_WITH_WORKAROUND_OPT_GY} else {'OFF'}
$ProjectWithWorkaroundSpectre = if ($Env:MY_PROJECT_WITH_WORKAROUND_SPECTRE) {$Env:MY_PROJECT_WITH_WORKAROUND_SPECTRE} else {'OFF'}
####
#### Project component level config
####
$ProjectBoostWithSharedLibraries = if ($Env:MY_PROJECT_BOOST_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_BOOST_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectBoostWithoutApps = if ($Env:MY_PROJECT_BOOST_WITHOUT_APPS) {$Env:MY_PROJECT_BOOST_WITHOUT_APPS} else {'OFF'}
$ProjectBoostWithoutInstallAll = if ($Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectBoostWithoutInstallFiles = if ($Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectBoostWithoutInstallHeaders = if ($Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectBoostWithoutInstallLibraries = if ($Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectCaresWithoutApps = if ($Env:MY_PROJECT_CARES_WITHOUT_APPS) {$Env:MY_PROJECT_CARES_WITHOUT_APPS} else {'OFF'}
$ProjectCaresWithoutInstallAll = if ($Env:MY_PROJECT_CARES_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_CARES_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectCaresWithoutInstallFiles = if ($Env:MY_PROJECT_CARES_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_CARES_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectCaresWithoutInstallHeaders = if ($Env:MY_PROJECT_CARES_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_CARES_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectCaresWithoutInstallLibraries = if ($Env:MY_PROJECT_CARES_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_CARES_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectCaresWithoutTestApps = if ($Env:MY_PROJECT_CARES_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_CARES_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectCjsonWithoutInstallAll = if ($Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectCjsonWithoutInstallFiles = if ($Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectCjsonWithoutInstallHeaders = if ($Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectCjsonWithoutInstallLibraries = if ($Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_CJSON_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectCjsonWithoutTestApps = if ($Env:MY_PROJECT_CJSON_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_CJSON_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectCurlWithCares = if ($Env:MY_PROJECT_CURL_WITH_CARES) {$Env:MY_PROJECT_CURL_WITH_CARES} else {'OFF'}
$ProjectCurlWithLibSsh2 = if ($Env:MY_PROJECT_CURL_WITH_LIBSSH2) {$Env:MY_PROJECT_CURL_WITH_LIBSSH2} else {'OFF'}
$ProjectCurlWithNgHttp2 = if ($Env:MY_PROJECT_CURL_WITH_NGHTTP2) {$Env:MY_PROJECT_CURL_WITH_NGHTTP2} else {'OFF'}
$ProjectCurlWithOpenSsl = if ($Env:MY_PROJECT_CURL_WITH_OPENSSL) {$Env:MY_PROJECT_CURL_WITH_OPENSSL} else {'OFF'}
$ProjectCurlWithSharedCares = if ($Env:MY_PROJECT_CURL_WITH_SHARED_CARES) {$Env:MY_PROJECT_CURL_WITH_SHARED_CARES} else {'OFF'}
$ProjectCurlWithSharedLibraries = if ($Env:MY_PROJECT_CURL_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_CURL_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectCurlWithSharedLibSsh2 = if ($Env:MY_PROJECT_CURL_WITH_SHARED_LIBSSH2) {$Env:MY_PROJECT_CURL_WITH_SHARED_LIBSSH2} else {'OFF'}
$ProjectCurlWithSharedNgHttp2 = if ($Env:MY_PROJECT_CURL_WITH_SHARED_NGHTTP2) {$Env:MY_PROJECT_CURL_WITH_SHARED_NGHTTP2} else {'OFF'}
$ProjectCurlWithSharedZlib = if ($Env:MY_PROJECT_CURL_WITH_SHARED_ZLIB) {$Env:MY_PROJECT_CURL_WITH_SHARED_ZLIB} else {'OFF'}
$ProjectCurlWithZlib = if ($Env:MY_PROJECT_CURL_WITH_ZLIB) {$Env:MY_PROJECT_CURL_WITH_ZLIB} else {'OFF'}
$ProjectCurlWithoutApps = if ($Env:MY_PROJECT_CURL_WITHOUT_APPS) {$Env:MY_PROJECT_CURL_WITHOUT_APPS} else {'OFF'}
$ProjectCurlWithoutInstallAll = if ($Env:MY_PROJECT_CURL_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_CURL_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectCurlWithoutInstallFiles = if ($Env:MY_PROJECT_CURL_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_CURL_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectCurlWithoutInstallHeaders = if ($Env:MY_PROJECT_CURL_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_CURL_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectCurlWithoutInstallLibraries = if ($Env:MY_PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectExpatWithSharedLibraries = if ($Env:MY_PROJECT_EXPAT_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_EXPAT_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectExpatWithoutApps = if ($Env:MY_PROJECT_EXPAT_WITHOUT_APPS) {$Env:MY_PROJECT_EXPAT_WITHOUT_APPS} else {'OFF'}
$ProjectExpatWithoutInstallAll = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectExpatWithoutInstallFiles = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectExpatWithoutInstallHeaders = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectExpatWithoutInstallLibraries = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectExpatWithoutTestApps = if ($Env:MY_PROJECT_EXPAT_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_EXPAT_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectLibSsh2WithSharedLibraries = if ($Env:MY_PROJECT_LIBSSH2_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_LIBSSH2_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectLibSsh2WithSharedZlib = if ($Env:MY_PROJECT_LIBSSH2_WITH_SHARED_ZLIB) {$Env:MY_PROJECT_LIBSSH2_WITH_SHARED_ZLIB} else {'OFF'}
$ProjectLibSsh2WithZlib = if ($Env:MY_PROJECT_LIBSSH2_WITH_ZLIB) {$Env:MY_PROJECT_LIBSSH2_WITH_ZLIB} else {'OFF'}
$ProjectLibSsh2WithoutInstallAll = if ($Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectLibSsh2WithoutInstallFiles = if ($Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectLibSsh2WithoutInstallHeaders = if ($Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectLibSsh2WithoutInstallLibraries = if ($Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_LIBSSH2_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectLibSsh2WithoutTestApps = if ($Env:MY_PROJECT_LIBSSH2_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_LIBSSH2_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectLibWebSocketsWithExternalPoll = if ($Env:MY_PROJECT_LIBWEBSOCKETS_WITH_EXTERNAL_POLL) {$Env:MY_PROJECT_LIBWEBSOCKETS_WITH_EXTERNAL_POLL} else {'OFF'}
$ProjectLibWebSocketsWithoutInstallAll = if ($Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectLibWebSocketsWithoutInstallFiles = if ($Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectLibWebSocketsWithoutInstallHeaders = if ($Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectLibWebSocketsWithoutInstallLibraries = if ($Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectLibWebSocketsWithoutTestApps = if ($Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_LIBWEBSOCKETS_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectNetSnmpWithIpv6 = if ($Env:MY_PROJECT_NETSNMP_WITH_IPV6) {$Env:MY_PROJECT_NETSNMP_WITH_IPV6} else {'OFF'}
$ProjectNetSnmpWithSharedLibraries = if ($Env:MY_PROJECT_NETSNMP_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_NETSNMP_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectNetSnmpWithSsh = if ($Env:MY_PROJECT_NETSNMP_WITH_SSH) {$Env:MY_PROJECT_NETSNMP_WITH_SSH} else {'OFF'}
$ProjectNetSnmpWithSsl = if ($Env:MY_PROJECT_NETSNMP_WITH_SSL) {$Env:MY_PROJECT_NETSNMP_WITH_SSL} else {'OFF'}
$ProjectNetSnmpWithWinExtDll = if ($Env:MY_PROJECT_NETSNMP_WITH_WINEXTDLL) {$Env:MY_PROJECT_NETSNMP_WITH_WINEXTDLL} else {'OFF'}
$ProjectNetSnmpWithoutApps = if ($Env:MY_PROJECT_NETSNMP_WITHOUT_APPS) {$Env:MY_PROJECT_NETSNMP_WITHOUT_APPS} else {'OFF'}
$ProjectNetSnmpWithoutInstallAll = if ($Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectNetSnmpWithoutInstallFiles = if ($Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectNetSnmpWithoutInstallHeaders = if ($Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectNetSnmpWithoutInstallLibraries = if ($Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectNetSnmpWithoutMibLoading = if ($Env:MY_PROJECT_NETSNMP_WITHOUT_MIB_LOADING) {$Env:MY_PROJECT_NETSNMP_WITHOUT_MIB_LOADING} else {'OFF'}
$ProjectNgHttp2WithoutInstallAll = if ($Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectNgHttp2WithoutInstallFiles = if ($Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectNgHttp2WithoutInstallHeaders = if ($Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectNgHttp2WithoutInstallLibraries = if ($Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_NGHTTP2_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectNgHttp2WithoutTestApps = if ($Env:MY_PROJECT_NGHTTP2_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_NGHTTP2_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectOpenSslWithDeprecatedCiphers = if ($Env:MY_PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS) {$Env:MY_PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS} else {'OFF'}
$ProjectOpenSslWithSharedLibraries = if ($Env:MY_PROJECT_OPENSSL_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_OPENSSL_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectOpenSslWithSharedZlib = if ($Env:MY_PROJECT_OPENSSL_WITH_SHARED_ZLIB) {$Env:MY_PROJECT_OPENSSL_WITH_SHARED_ZLIB} else {'OFF'}
$ProjectOpenSslWithZlib = if ($Env:MY_PROJECT_OPENSSL_WITH_ZLIB) {$Env:MY_PROJECT_OPENSSL_WITH_ZLIB} else {'OFF'}
$ProjectOpenSslWithoutApps = if ($Env:MY_PROJECT_OPENSSL_WITHOUT_APPS) {$Env:MY_PROJECT_OPENSSL_WITHOUT_APPS} else {'OFF'}
$ProjectOpenSslWithoutInstallAll = if ($Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectOpenSslWithoutInstallFiles = if ($Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectOpenSslWithoutInstallHeaders = if ($Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectOpenSslWithoutInstallLibraries = if ($Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectPahoWithOpenSsl = if ($Env:MY_PROJECT_PAHO_WITH_OPENSSL) {$Env:MY_PROJECT_PAHO_WITH_OPENSSL} else {'OFF'}
$ProjectPahoWithSharedLibraries = if ($Env:MY_PROJECT_PAHO_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_PAHO_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectPahoWithoutInstallAll = if ($Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectPahoWithoutInstallFiles = if ($Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectPahoWithoutInstallHeaders = if ($Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectPahoWithoutInstallLibraries = if ($Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectPahoWithoutTestApps = if ($Env:MY_PROJECT_PAHO_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_PAHO_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectPcreWithSharedLibraries = if ($Env:MY_PROJECT_PCRE_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_PCRE_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectPcreWithoutApps = if ($Env:MY_PROJECT_PCRE_WITHOUT_APPS) {$Env:MY_PROJECT_PCRE_WITHOUT_APPS} else {'OFF'}
$ProjectPcreWithoutInstallAll = if ($Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectPcreWithoutInstallFiles = if ($Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectPcreWithoutInstallHeaders = if ($Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectPcreWithoutInstallLibraries = if ($Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectPcreWithoutTestApps = if ($Env:MY_PROJECT_PCRE_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_PCRE_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectPocoWithSharedLibraries = if ($Env:MY_PROJECT_POCO_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_POCO_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectPocoWithSharedZlib = if ($Env:MY_PROJECT_POCO_WITH_SHARED_ZLIB) {$Env:MY_PROJECT_POCO_WITH_SHARED_ZLIB} else {'OFF'}
$ProjectPocoWithoutApps = if ($Env:MY_PROJECT_POCO_WITHOUT_APPS) {$Env:MY_PROJECT_POCO_WITHOUT_APPS} else {'OFF'}
$ProjectPocoWithoutInstallAll = if ($Env:MY_PROJECT_POCO_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_POCO_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectPocoWithoutInstallFiles = if ($Env:MY_PROJECT_POCO_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_POCO_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectPocoWithoutInstallHeaders = if ($Env:MY_PROJECT_POCO_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_POCO_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectPocoWithoutInstallLibraries = if ($Env:MY_PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectProtoBufWithExternalProtoc = if ($Env:MY_PROJECT_PROTOBUF_WITH_EXTERNAL_PROTOC) {$Env:MY_PROJECT_PROTOBUF_WITH_EXTERNAL_PROTOC} else {'OFF'}
$ProjectProtoBufWithSharedLibraries = if ($Env:MY_PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectProtoBufWithSharedZlib = if ($Env:MY_PROJECT_PROTOBUF_WITH_SHARED_ZLIB) {$Env:MY_PROJECT_PROTOBUF_WITH_SHARED_ZLIB} else {'OFF'}
$ProjectProtoBufWithZlib = if ($Env:MY_PROJECT_PROTOBUF_WITH_ZLIB) {$Env:MY_PROJECT_PROTOBUF_WITH_ZLIB} else {'OFF'}
$ProjectProtoBufWithoutInstallAll = if ($Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectProtoBufWithoutInstallFiles = if ($Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectProtoBufWithoutInstallHeaders = if ($Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectProtoBufWithoutInstallLibraries = if ($Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectProtoBufWithoutTestApps = if ($Env:MY_PROJECT_PROTOBUF_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_PROTOBUF_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectPthreads4wWithoutInstallAll = if ($Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectPthreads4wWithoutInstallFiles = if ($Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectPthreads4wWithoutInstallHeaders = if ($Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectPthreads4wWithoutInstallLibraries = if ($Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_PTHREADS4W_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectPthreads4wWithoutTestApps = if ($Env:MY_PROJECT_PTHREADS4W_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_PTHREADS4W_WITHOUT_TEST_APPS} else {'OFF'}
$ProjectSqliteWithSharedLibraries = if ($Env:MY_PROJECT_SQLITE_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_SQLITE_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectSqliteWithoutApps = if ($Env:MY_PROJECT_SQLITE_WITHOUT_APPS) {$Env:MY_PROJECT_SQLITE_WITHOUT_APPS} else {'OFF'}
$ProjectSqliteWithoutInstallAll = if ($Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectSqliteWithoutInstallFiles = if ($Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectSqliteWithoutInstallHeaders = if ($Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectSqliteWithoutInstallLibraries = if ($Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectZlibWithoutInstallAll = if ($Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectZlibWithoutInstallFiles = if ($Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectZlibWithoutInstallHeaders = if ($Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectZlibWithoutInstallLibraries = if ($Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectZlibWithoutTestApps = if ($Env:MY_PROJECT_ZLIB_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_ZLIB_WITHOUT_TEST_APPS} else {'OFF'}

##
## My variables
##
$MyCmakeCommonArgumentList = @(
        "-S $SourceFolder",
        "-T $ProjectToolset",
        "-DCMAKE_BUILD_TYPE=$ProjectReleaseType",
        "-DCMAKE_CONFIGURATION_TYPES=$ProjectReleaseType",
        "-DMY_REVISION=$ProjectRevision"
)
if ('ON'.Equals($ProjectBoostWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DBOOST_WITH_SHARED_LIBRARIES=$ProjectBoostWithSharedLibraries"
}
if ('ON'.Equals($ProjectBoostWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DBOOST_WITHOUT_APPS=$ProjectBoostWithoutApps"
}
if ('ON'.Equals($ProjectBoostWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DBOOST_WITHOUT_INSTALL_ALL=$ProjectBoostWithoutInstallAll"
}
if ('ON'.Equals($ProjectBoostWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DBOOST_WITHOUT_INSTALL_FILES=$ProjectBoostWithoutInstallFiles"
}
if ('ON'.Equals($ProjectBoostWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DBOOST_WITHOUT_INSTALL_HEADERS=$ProjectBoostWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectBoostWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DBOOST_WITHOUT_INSTALL_LIBRARIES=$ProjectBoostWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectCaresWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DCARES_WITHOUT_APPS=$ProjectCaresWithoutApps"
}
if ('ON'.Equals($ProjectCaresWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DCARES_WITHOUT_INSTALL_ALL=$ProjectCaresWithoutInstallAll"
}
if ('ON'.Equals($ProjectCaresWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DCARES_WITHOUT_INSTALL_FILES=$ProjectCaresWithoutInstallFiles"
}
if ('ON'.Equals($ProjectCaresWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DCARES_WITHOUT_INSTALL_HEADERS=$ProjectCaresWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectCaresWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DCARES_WITHOUT_INSTALL_LIBRARIES=$ProjectCaresWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectCaresWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DCARES_WITHOUT_TEST_APPS=$ProjectCaresWithoutTestApps"
}
if ('ON'.Equals($ProjectCjsonWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DCJSON_WITHOUT_INSTALL_ALL=$ProjectCjsonWithoutInstallAll"
}
if ('ON'.Equals($ProjectCjsonWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DCJSON_WITHOUT_INSTALL_FILES=$ProjectCjsonWithoutInstallFiles"
}
if ('ON'.Equals($ProjectCjsonWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DCJSON_WITHOUT_INSTALL_HEADERS=$ProjectCjsonWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectCjsonWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DCJSON_WITHOUT_INSTALL_LIBRARIES=$ProjectCjsonWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectCjsonWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DCJSON_WITHOUT_TEST_APPS=$ProjectCjsonWithoutTestApps"
}
if ('ON'.Equals($ProjectCurlWithCares)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_CARES=$ProjectCurlWithCares"
}
if ('ON'.Equals($ProjectCurlWithLibSsh2)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_LIBSSH2=$ProjectCurlWithLibSsh2"
}
if ('ON'.Equals($ProjectCurlWithNgHttp2)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_NGHTTP2=$ProjectCurlWithNgHttp2"
}
if ('ON'.Equals($ProjectCurlWithOpenSsl)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_OPENSSL=$ProjectCurlWithOpenSsl"
}
if ('ON'.Equals($ProjectCurlWithSharedCares)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_SHARED_CARES=$ProjectCurlWithSharedCares"
}
if ('ON'.Equals($ProjectCurlWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_SHARED_LIBRARIES=$ProjectCurlWithSharedLibraries"
}
if ('ON'.Equals($ProjectCurlWithSharedLibSsh2)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_SHARED_LIBSSH2=$ProjectCurlWithSharedLibSsh2"
}
if ('ON'.Equals($ProjectCurlWithSharedNgHttp2)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_SHARED_NGHTTP2=$ProjectCurlWithSharedNgHttp2"
}
if ('ON'.Equals($ProjectCurlWithSharedZlib)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_SHARED_ZLIB=$ProjectCurlWithSharedZlib"
}
if ('ON'.Equals($ProjectCurlWithZlib)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITH_ZLIB=$ProjectCurlWithZlib"
}
if ('ON'.Equals($ProjectCurlWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITHOUT_APPS=$ProjectCurlWithoutApps"
}
if ('ON'.Equals($ProjectCurlWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITHOUT_INSTALL_ALL=$ProjectCurlWithoutInstallAll"
}
if ('ON'.Equals($ProjectCurlWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITHOUT_INSTALL_FILES=$ProjectCurlWithoutInstallFiles"
}
if ('ON'.Equals($ProjectCurlWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITHOUT_INSTALL_HEADERS=$ProjectCurlWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectCurlWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DCURL_WITHOUT_INSTALL_LIBRARIES=$ProjectCurlWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectExpatWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITH_SHARED_LIBRARIES=$ProjectExpatWithSharedLibraries"
}
if ('ON'.Equals($ProjectExpatWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITHOUT_APPS=$ProjectExpatWithoutApps"
}
if ('ON'.Equals($ProjectExpatWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITHOUT_INSTALL_ALL=$ProjectExpatWithoutInstallAll"
}
if ('ON'.Equals($ProjectExpatWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITHOUT_INSTALL_FILES=$ProjectExpatWithoutInstallFiles"
}
if ('ON'.Equals($ProjectExpatWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITHOUT_INSTALL_HEADERS=$ProjectExpatWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectExpatWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITHOUT_INSTALL_LIBRARIES=$ProjectExpatWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectExpatWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DEXPAT_WITHOUT_TEST_APPS=$ProjectExpatWithoutTestApps"
}
if ('ON'.Equals($ProjectLibSsh2WithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITH_SHARED_LIBRARIES=$ProjectLibSsh2WithSharedLibraries"
}
if ('ON'.Equals($ProjectLibSsh2WithSharedZlib)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITH_SHARED_ZLIB=$ProjectLibSsh2WithSharedZlib"
}
if ('ON'.Equals($ProjectLibSsh2WithZlib)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITH_ZLIB=$ProjectLibSsh2WithZlib"
}
if ('ON'.Equals($ProjectLibSsh2WithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITHOUT_INSTALL_ALL=$ProjectLibSsh2WithoutInstallAll"
}
if ('ON'.Equals($ProjectLibSsh2WithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITHOUT_INSTALL_FILES=$ProjectLibSsh2WithoutInstallFiles"
}
if ('ON'.Equals($ProjectLibSsh2WithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITHOUT_INSTALL_HEADERS=$ProjectLibSsh2WithoutInstallHeaders"
}
if ('ON'.Equals($ProjectLibSsh2WithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITHOUT_INSTALL_LIBRARIES=$ProjectLibSsh2WithoutInstallLibraries"
}
if ('ON'.Equals($ProjectLibSsh2WithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DLIBSSH2_WITHOUT_TEST_APPS=$ProjectLibSsh2WithoutTestApps"
}
if ('ON'.Equals($ProjectLibWebSocketsWithExternalPoll)) {
    $MyCmakeCommonArgumentList += "-DLIBWEBSOCKETS_WITH_EXTERNAL_POLL=$ProjectLibWebSocketsWithExternalPoll"
}
if ('ON'.Equals($ProjectLibWebSocketsWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DLIBWEBSOCKETS_WITHOUT_INSTALL_ALL=$ProjectLibWebSocketsWithoutInstallAll"
}
if ('ON'.Equals($ProjectLibWebSocketsWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DLIBWEBSOCKETS_WITHOUT_INSTALL_FILES=$ProjectLibWebSocketsWithoutInstallFiles"
}
if ('ON'.Equals($ProjectLibWebSocketsWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DLIBWEBSOCKETS_WITHOUT_INSTALL_HEADERS=$ProjectLibWebSocketsWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectLibWebSocketsWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DLIBWEBSOCKETS_WITHOUT_INSTALL_LIBRARIES=$ProjectLibWebSocketsWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectLibWebSocketsWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DLIBWEBSOCKETS_WITHOUT_TEST_APPS=$ProjectLibWebSocketsWithoutTestApps"
}
if ('ON'.Equals($ProjectNetSnmpWithIpv6)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITH_IPV6=$ProjectNetSnmpWithIpv6"
}
if ('ON'.Equals($ProjectNetSnmpWithSsh)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITH_SSH=$ProjectNetSnmpWithSsh"
}
if ('ON'.Equals($ProjectNetSnmpWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITH_SHARED_LIBRARIES=$ProjectNetSnmpWithSharedLibraries"
}
if ('ON'.Equals($ProjectNetSnmpWithSsl)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITH_SSL=$ProjectNetSnmpWithSsl"
}
if ('ON'.Equals($ProjectNetSnmpWithWinExtDll)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITH_WINEXTDLL=$ProjectNetSnmpWithWinExtDll"
}
if ('ON'.Equals($ProjectNetSnmpWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITHOUT_APPS=$ProjectNetSnmpWithoutApps"
}
if ('ON'.Equals($ProjectNetSnmpWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITHOUT_INSTALL_ALL=$ProjectNetSnmpWithoutInstallAll"
}
if ('ON'.Equals($ProjectNetSnmpWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITHOUT_INSTALL_FILES=$ProjectNetSnmpWithoutInstallFiles"
}
if ('ON'.Equals($ProjectNetSnmpWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITHOUT_INSTALL_HEADERS=$ProjectNetSnmpWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectNetSnmpWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITHOUT_INSTALL_LIBRARIES=$ProjectNetSnmpWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectNetSnmpWithoutMibLoading)) {
    $MyCmakeCommonArgumentList += "-DNETSNMP_WITHOUT_MIB_LOADING=$ProjectNetSnmpWithoutMibLoading"
}
if ('ON'.Equals($ProjectNgHttp2WithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DNGHTTP2_WITHOUT_INSTALL_ALL=$ProjectNgHttp2WithoutInstallAll"
}
if ('ON'.Equals($ProjectNgHttp2WithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DNGHTTP2_WITHOUT_INSTALL_FILES=$ProjectNgHttp2WithoutInstallFiles"
}
if ('ON'.Equals($ProjectNgHttp2WithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DNGHTTP2_WITHOUT_INSTALL_HEADERS=$ProjectNgHttp2WithoutInstallHeaders"
}
if ('ON'.Equals($ProjectNgHttp2WithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DNGHTTP2_WITHOUT_INSTALL_LIBRARIES=$ProjectNgHttp2WithoutInstallLibraries"
}
if ('ON'.Equals($ProjectNgHttp2WithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DNGHTTP2_WITHOUT_TEST_APPS=$ProjectNgHttp2WithoutTestApps"
}
if ('ON'.Equals($ProjectOpenSslWithDeprecatedCiphers)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITH_DEPRECATED_CIPHERS=$ProjectOpenSslWithDeprecatedCiphers"
}
if ('ON'.Equals($ProjectOpenSslWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITH_SHARED_LIBRARIES=$ProjectOpenSslWithSharedLibraries"
}
if ('ON'.Equals($ProjectOpenSslWithSharedZlib)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITH_SHARED_ZLIB=$ProjectOpenSslWithSharedZlib"
}
if ('ON'.Equals($ProjectOpenSslWithZlib)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITH_ZLIB=$ProjectOpenSslWithZlib"
}
if ('ON'.Equals($ProjectOpenSslWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITHOUT_APPS=$ProjectOpenSslWithoutApps"
}
if ('ON'.Equals($ProjectOpenSslWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITHOUT_INSTALL_ALL=$ProjectOpenSslWithoutInstallAll"
}
if ('ON'.Equals($ProjectOpenSslWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITHOUT_INSTALL_FILES=$ProjectOpenSslWithoutInstallFiles"
}
if ('ON'.Equals($ProjectOpenSslWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITHOUT_INSTALL_HEADERS=$ProjectOpenSslWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectOpenSslWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DOPENSSL_WITHOUT_INSTALL_LIBRARIES=$ProjectOpenSslWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectPahoWithOpenSsl)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITH_OPENSSL=$ProjectPahoWithOpenSsl"
}
if ('ON'.Equals($ProjectPahoWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITH_SHARED_LIBRARIES=$ProjectPahoWithSharedLibraries"
}
if ('ON'.Equals($ProjectPahoWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITHOUT_INSTALL_ALL=$ProjectPahoWithoutInstallAll"
}
if ('ON'.Equals($ProjectPahoWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITHOUT_INSTALL_FILES=$ProjectPahoWithoutInstallFiles"
}
if ('ON'.Equals($ProjectPahoWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITHOUT_INSTALL_HEADERS=$ProjectPahoWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectPahoWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITHOUT_INSTALL_LIBRARIES=$ProjectPahoWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectPahoWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DPAHO_WITHOUT_TEST_APPS=$ProjectPahoWithoutTestApps"
}
if ('ON'.Equals($ProjectPcreWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITH_SHARED_LIBRARIES=$ProjectPcreWithSharedLibraries"
}
if ('ON'.Equals($ProjectPcreWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITHOUT_APPS=$ProjectPcreWithoutApps"
}
if ('ON'.Equals($ProjectPcreWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITHOUT_INSTALL_ALL=$ProjectPcreWithoutInstallAll"
}
if ('ON'.Equals($ProjectPcreWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITHOUT_INSTALL_FILES=$ProjectPcreWithoutInstallFiles"
}
if ('ON'.Equals($ProjectPcreWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITHOUT_INSTALL_HEADERS=$ProjectPcreWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectPcreWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITHOUT_INSTALL_LIBRARIES=$ProjectPcreWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectPcreWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DPCRE_WITHOUT_TEST_APPS=$ProjectPcreWithoutTestApps"
}
if ('ON'.Equals($ProjectPocoWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITH_SHARED_LIBRARIES=$ProjectPocoWithSharedLibraries"
}
if ('ON'.Equals($ProjectPocoWithSharedZlib)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITH_SHARED_ZLIB=$ProjectPocoWithSharedZlib"
}
if ('ON'.Equals($ProjectPocoWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITHOUT_APPS=$ProjectPocoWithoutApps"
}
if ('ON'.Equals($ProjectPocoWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITHOUT_INSTALL_ALL=$ProjectPocoWithoutInstallAll"
}
if ('ON'.Equals($ProjectPocoWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITHOUT_INSTALL_FILES=$ProjectPocoWithoutInstallFiles"
}
if ('ON'.Equals($ProjectPocoWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITHOUT_INSTALL_HEADERS=$ProjectPocoWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectPocoWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DPOCO_WITHOUT_INSTALL_LIBRARIES=$ProjectPocoWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectProtoBufWithExternalProtoc)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITH_EXTERNAL_PROTOC=$ProjectProtoBufWithExternalProtoc"
}
if ('ON'.Equals($ProjectProtoBufWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITH_SHARED_LIBRARIES=$ProjectProtoBufWithSharedLibraries"
}
if ('ON'.Equals($ProjectProtoBufWithSharedZlib)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITH_SHARED_ZLIB=$ProjectProtoBufWithSharedZlib"
}
if ('ON'.Equals($ProjectProtoBufWithZlib)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITH_ZLIB=$ProjectProtoBufWithZlib"
}
if ('ON'.Equals($ProjectProtoBufWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITHOUT_INSTALL_ALL=$ProjectProtoBufWithoutInstallAll"
}
if ('ON'.Equals($ProjectProtoBufWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITHOUT_INSTALL_FILES=$ProjectProtoBufWithoutInstallFiles"
}
if ('ON'.Equals($ProjectProtoBufWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITHOUT_INSTALL_HEADERS=$ProjectProtoBufWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectProtoBufWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITHOUT_INSTALL_LIBRARIES=$ProjectProtoBufWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectProtoBufWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DPROTOBUF_WITHOUT_TEST_APPS=$ProjectProtoBufWithoutTestApps"
}
if ('ON'.Equals($ProjectPthreads4wWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DPTHREADS4W_WITHOUT_INSTALL_ALL=$ProjectPthreads4wWithoutInstallAll"
}
if ('ON'.Equals($ProjectPthreads4wWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DPTHREADS4W_WITHOUT_INSTALL_FILES=$ProjectPthreads4wWithoutInstallFiles"
}
if ('ON'.Equals($ProjectPthreads4wWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DPTHREADS4W_WITHOUT_INSTALL_HEADERS=$ProjectPthreads4wWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectPthreads4wWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DPTHREADS4W_WITHOUT_INSTALL_LIBRARIES=$ProjectPthreads4wWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectPthreads4wWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DPTHREADS4W_WITHOUT_TEST_APPS=$ProjectPthreads4wWithoutTestApps"
}
if ('ON'.Equals($ProjectSqliteWithSharedLibraries)) {
    $MyCmakeCommonArgumentList += "-DSQLITE_WITH_SHARED_LIBRARIES=$ProjectSqliteWithSharedLibraries"
}
if ('ON'.Equals($ProjectSqliteWithoutApps)) {
    $MyCmakeCommonArgumentList += "-DSQLITE_WITHOUT_APPS=$ProjectSqliteWithoutApps"
}
if ('ON'.Equals($ProjectSqliteWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DSQLITE_WITHOUT_INSTALL_ALL=$ProjectSqliteWithoutInstallAll"
}
if ('ON'.Equals($ProjectSqliteWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DSQLITE_WITHOUT_INSTALL_FILES=$ProjectSqliteWithoutInstallFiles"
}
if ('ON'.Equals($ProjectSqliteWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DSQLITE_WITHOUT_INSTALL_HEADERS=$ProjectSqliteWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectSqliteWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DSQLITE_WITHOUT_INSTALL_LIBRARIES=$ProjectSqliteWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectZlibWithoutInstallAll)) {
    $MyCmakeCommonArgumentList += "-DZLIB_WITHOUT_INSTALL_ALL=$ProjectZlibWithoutInstallAll"
}
if ('ON'.Equals($ProjectZlibWithoutInstallFiles)) {
    $MyCmakeCommonArgumentList += "-DZLIB_WITHOUT_INSTALL_FILES=$ProjectZlibWithoutInstallFiles"
}
if ('ON'.Equals($ProjectZlibWithoutInstallHeaders)) {
    $MyCmakeCommonArgumentList += "-DZLIB_WITHOUT_INSTALL_HEADERS=$ProjectZlibWithoutInstallHeaders"
}
if ('ON'.Equals($ProjectZlibWithoutInstallLibraries)) {
    $MyCmakeCommonArgumentList += "-DZLIB_WITHOUT_INSTALL_LIBRARIES=$ProjectZlibWithoutInstallLibraries"
}
if ('ON'.Equals($ProjectZlibWithoutTestApps)) {
    $MyCmakeCommonArgumentList += "-DZLIB_WITHOUT_TEST_APPS=$ProjectZlibWithoutTestApps"
}
if ('ON'.Equals($ProjectWithCompilerCache)) {
    $MyCmakeCommonArgumentList += "-DBUILD_WITH_COMPILER_CACHE=$ProjectWithCompilerCache"
}
if ('ON'.Equals($ProjectWithCompilerPrecheck)) {
    $MyCmakeCommonArgumentList += "-DBUILD_WITH_COMPILER_PRECHECK=$ProjectWithCompilerPrecheck"
}
if ('ON'.Equals($ProjectWithSharedVcrt)) {
    $MyCmakeCommonArgumentList += "-DBUILD_WITH_SHARED_VCRT=$ProjectWithSharedVcrt"
}
if ('ON'.Equals($ProjectWithStaticVcrt)) {
    $MyCmakeCommonArgumentList += "-DBUILD_WITH_STATIC_VCRT=$ProjectWithStaticVcrt"
}
if ('ON'.Equals($ProjectWithWorkaroundSpectre)) {
    $MyCmakeCommonArgumentList += "-DBUILD_WITH_WORKAROUND_SPECTRE=$ProjectWithWorkaroundSpectre"
}
$MyCmakeGenerator = $CmakeToolsetToGeneratorMap[$ProjectToolset]
$MyCmakeCommonArgumentList += "-G `"$MyCmakeGenerator`""
$MyCmakePlatformList = @(
        'Win32',
        'ARM',
        'x64',
        'ARM64',
        'ARM64EC'
)
$MyCmakePlatformToBuildToggleMap = @{
        'ARM' = 'ON'
        'ARM64' = 'ON'
        'ARM64EC' = 'ON'
        'Win32' = 'ON'
        'x64' = 'ON'
}
if ('ON'.Equals($ProjectShouldDisable32BitBuild)) {
    $MyCmakePlatformToBuildToggleMap['ARM'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['Win32'] = 'OFF'
}
if ('ON'.Equals($ProjectShouldDisable64BitBuild)) {
    $MyCmakePlatformToBuildToggleMap['ARM64'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['ARM64EC'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['x64'] = 'OFF'
}
if ('ON'.Equals($ProjectShouldDisableArmBuild)) {
    $MyCmakePlatformToBuildToggleMap['ARM'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['ARM64'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['ARM64EC'] = 'OFF'
}
if ('ON'.Equals($ProjectShouldDisableArm64ecBuild)) {
    $MyCmakePlatformToBuildToggleMap['ARM64EC'] = 'OFF'
}
if ('ON'.Equals($ProjectShouldDisableX86Build)) {
    $MyCmakePlatformToBuildToggleMap['Win32'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['x64'] = 'OFF'
}
if ('v120'.Equals($ProjectToolset)) {
    $MyCmakePlatformToBuildToggleMap['ARM'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['ARM64'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['ARM64EC'] = 'OFF'
}
if ('v140'.Equals($ProjectToolset)) {
    $MyCmakePlatformToBuildToggleMap['ARM64'] = 'OFF'
    $MyCmakePlatformToBuildToggleMap['ARM64EC'] = 'OFF'
}
if ('v141'.Equals($ProjectToolset)) {
    $MyCmakePlatformToBuildToggleMap['ARM64EC'] = 'OFF'
}
$MyCmakePlatformToBuildList = @()
foreach ($Platform in $MyCmakePlatformToBuildToggleMap.Keys) {
    if ('ON'.Equals($MyCmakePlatformToBuildToggleMap[$Platform])) {
        $MyCmakePlatformToBuildList += $Platform
    }
}
$MyCmakePlatformToBuildListString = $MyCmakePlatformToBuildList -join ", "
$MyProjectProtocCli = "${ProtocCli}-${ProjectProtocVersion}"
$MyProjectProtocCliDetected = $false



## Print build information
Write-Information "[PowerShell] Project information: version: `"$MyProjectVersion`""
Write-Information "[PowerShell] Project information: revision: `"$ProjectRevision`""
Write-Information "[PowerShell] Project information: release type: `"$ProjectReleaseType`""
Write-Information "[PowerShell] Project information: disable clean build: $ProjectShouldDisableCleanBuild"
Write-Information "[PowerShell] Project information: disable parallel build: $ProjectShouldDisableParallelBuild"
Write-Information "[PowerShell] Project information: enable compiler cache: $ProjectWithCompilerCache"
Write-Information "[PowerShell] Project information: enable compiler precheck: $ProjectWithCompilerPrecheck"
Write-Information "[PowerShell] Project information: CMake generator: `"$MyCmakeGenerator`""
Write-Information "[PowerShell] Project information: CMake toolset: `"$ProjectToolset`""
Write-Information "[PowerShell] Project information: CMake platform to build: $MyCmakePlatformToBuildListString"
Write-Information "[PowerShell] Component information: Boost with shared libraries: $ProjectBoostWithSharedLibraries"
Write-Information "[PowerShell] Component information: Boost without apps: $ProjectBoostWithoutApps"
Write-Information "[PowerShell] Component information: Boost without installing all artifacts: $ProjectBoostWithoutInstallAll"
Write-Information "[PowerShell] Component information: Boost without installing files: $ProjectBoostWithoutInstallFiles"
Write-Information "[PowerShell] Component information: Boost without installing headers: $ProjectBoostWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: Boost without installing libraries: $ProjectBoostWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: c-ares without apps: $ProjectCaresWithoutApps"
Write-Information "[PowerShell] Component information: c-ares without installing all artifacts: $ProjectCaresWithoutInstallAll"
Write-Information "[PowerShell] Component information: c-ares without installing files: $ProjectCaresWithoutInstallFiles"
Write-Information "[PowerShell] Component information: c-ares without installing headers: $ProjectCaresWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: c-ares without installing libraries: $ProjectCaresWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: c-ares without test apps: $ProjectCaresWithoutTestApps"
Write-Information "[PowerShell] Component information: cJSON without installing all artifacts: $ProjectCjsonWithoutInstallAll"
Write-Information "[PowerShell] Component information: cJSON without installing files: $ProjectCjsonWithoutInstallFiles"
Write-Information "[PowerShell] Component information: cJSON without installing headers: $ProjectCjsonWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: cJSON without installing libraries: $ProjectCjsonWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: cJSON without test apps: $ProjectCjsonWithoutTestApps"
Write-Information "[PowerShell] Component information: CURL with c-ares: $ProjectCurlWithCares"
Write-Information "[PowerShell] Component information: CURL with libssh2: $ProjectCurlWithLibSsh2"
Write-Information "[PowerShell] Component information: CURL with nghttp2: $ProjectCurlWithNgHttp2"
Write-Information "[PowerShell] Component information: CURL with OpenSSL: $ProjectCurlWithOpenSsl"
Write-Information "[PowerShell] Component information: CURL with shared c-ares: $ProjectCurlWithSharedCares"
Write-Information "[PowerShell] Component information: CURL with shared libraries: $ProjectCurlWithSharedLibraries"
Write-Information "[PowerShell] Component information: CURL with shared libssh2: $ProjectCurlWithSharedLibSsh2"
Write-Information "[PowerShell] Component information: CURL with shared nghttp2: $ProjectCurlWithSharedNgHttp2"
Write-Information "[PowerShell] Component information: CURL with shared Zlib: $ProjectCurlWithSharedZlib"
Write-Information "[PowerShell] Component information: CURL with Zlib: $ProjectCurlWithZlib"
Write-Information "[PowerShell] Component information: CURL without apps: $ProjectCurlWithoutApps"
Write-Information "[PowerShell] Component information: CURL without installing all artifacts: $ProjectCurlWithoutInstallAll"
Write-Information "[PowerShell] Component information: CURL without installing files: $ProjectCurlWithoutInstallFiles"
Write-Information "[PowerShell] Component information: CURL without installing headers: $ProjectCurlWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: CURL without installing libraries: $ProjectCurlWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: expat with shared libraries: $ProjectExpatWithSharedLibraries"
Write-Information "[PowerShell] Component information: expat without apps: $ProjectExpatWithoutApps"
Write-Information "[PowerShell] Component information: expat without installing all artifacts: $ProjectExpatWithoutInstallAll"
Write-Information "[PowerShell] Component information: expat without installing files: $ProjectExpatWithoutInstallFiles"
Write-Information "[PowerShell] Component information: expat without installing headers: $ProjectExpatWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: expat without installing libraries: $ProjectExpatWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: expat without test apps: $ProjectExpatWithoutTestApps"
Write-Information "[PowerShell] Component information: libssh2 with shared libraries: $ProjectLibSsh2WithSharedLibraries"
Write-Information "[PowerShell] Component information: libssh2 with shared Zlib: $ProjectLibSsh2WithSharedZlib"
Write-Information "[PowerShell] Component information: libssh2 with Zlib: $ProjectLibSsh2WithZlib"
Write-Information "[PowerShell] Component information: libssh2 without installing all artifacts: $ProjectLibSsh2WithoutInstallAll"
Write-Information "[PowerShell] Component information: libssh2 without installing files: $ProjectLibSsh2WithoutInstallFiles"
Write-Information "[PowerShell] Component information: libssh2 without installing headers: $ProjectLibSsh2WithoutInstallHeaders"
Write-Information "[PowerShell] Component information: libssh2 without installing libraries: $ProjectLibSsh2WithoutInstallLibraries"
Write-Information "[PowerShell] Component information: libssh2 without test apps: $ProjectLibSsh2WithoutTestApps"
Write-Information "[PowerShell] Component information: libwebsockets with external poll: $ProjectLibWebSocketsWithExternalPoll"
Write-Information "[PowerShell] Component information: libwebsockets without installing all artifacts: $ProjectLibWebSocketsWithoutInstallAll"
Write-Information "[PowerShell] Component information: libwebsockets without installing files: $ProjectLibWebSocketsWithoutInstallFiles"
Write-Information "[PowerShell] Component information: libwebsockets without installing headers: $ProjectLibWebSocketsWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: libwebsockets without installing libraries: $ProjectLibWebSocketsWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: libwebsockets without test apps: $ProjectLibWebSocketsWithoutTestApps"
Write-Information "[PowerShell] Component information: Net-SNMP with IPv6: $ProjectNetSnmpWithIpv6"
Write-Information "[PowerShell] Component information: Net-SNMP with shared libraries: $ProjectNetSnmpWithSharedLibraries"
Write-Information "[PowerShell] Component information: Net-SNMP with SSH: $ProjectNetSnmpWithSsh"
Write-Information "[PowerShell] Component information: Net-SNMP with SSL: $ProjectNetSnmpWithSsl"
Write-Information "[PowerShell] Component information: Net-SNMP with WinExtDll: $ProjectNetSnmpWithWinExtDll"
Write-Information "[PowerShell] Component information: Net-SNMP without apps: $ProjectNetSnmpWithoutApps"
Write-Information "[PowerShell] Component information: Net-SNMP without installing all artifacts: $ProjectNetSnmpWithoutInstallAll"
Write-Information "[PowerShell] Component information: Net-SNMP without installing files: $ProjectNetSnmpWithoutInstallFiles"
Write-Information "[PowerShell] Component information: Net-SNMP without installing headers: $ProjectNetSnmpWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: Net-SNMP without installing libraries: $ProjectNetSnmpWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Net-SNMP without MIB loading: $ProjectNetSnmpWithoutMibLoading"
Write-Information "[PowerShell] Component information: nghttp2 without installing all artifacts: $ProjectNgHttp2WithoutInstallAll"
Write-Information "[PowerShell] Component information: nghttp2 without installing files: $ProjectNgHttp2WithoutInstallFiles"
Write-Information "[PowerShell] Component information: nghttp2 without installing headers: $ProjectNgHttp2WithoutInstallHeaders"
Write-Information "[PowerShell] Component information: nghttp2 without installing libraries: $ProjectNgHttp2WithoutInstallLibraries"
Write-Information "[PowerShell] Component information: nghttp2 without test apps: $ProjectNgHttp2WithoutTestApps"
Write-Information "[PowerShell] Component information: OpenSSL with deprecated ciphers: $ProjectOpenSslWithDeprecatedCiphers"
Write-Information "[PowerShell] Component information: OpenSSL with shared libraries: $ProjectOpenSslWithSharedLibraries"
Write-Information "[PowerShell] Component information: OpenSSL with shared Zlib: $ProjectOpenSslWithSharedZlib"
Write-Information "[PowerShell] Component information: OpenSSL with Zlib: $ProjectOpenSslWithZlib"
Write-Information "[PowerShell] Component information: OpenSSL without apps: $ProjectOpenSslWithoutApps"
Write-Information "[PowerShell] Component information: OpenSSL without installing all artifacts: $ProjectOpenSslWithoutInstallAll"
Write-Information "[PowerShell] Component information: OpenSSL without installing files: $ProjectOpenSslWithoutInstallFiles"
Write-Information "[PowerShell] Component information: OpenSSL without installing headers: $ProjectOpenSslWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: OpenSSL without installing libraries: $ProjectOpenSslWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Eclipse Paho with OpenSSL: $ProjectPahoWithOpenSsl"
Write-Information "[PowerShell] Component information: Eclipse Paho with shared libraries: $ProjectPahoWithSharedLibraries"
Write-Information "[PowerShell] Component information: Eclipse Paho without installing all artifacts: $ProjectPahoWithoutInstallAll"
Write-Information "[PowerShell] Component information: Eclipse Paho without installing files: $ProjectPahoWithoutInstallFiles"
Write-Information "[PowerShell] Component information: Eclipse Paho without installing headers: $ProjectPahoWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: Eclipse Paho without installing libraries: $ProjectPahoWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Eclipse Paho without test apps: $ProjectPahoWithoutTestApps"
Write-Information "[PowerShell] Component information: PCRE with shared libraries: $ProjectPcreWithSharedLibraries"
Write-Information "[PowerShell] Component information: PCRE without apps: $ProjectPcreWithoutApps"
Write-Information "[PowerShell] Component information: PCRE without installing all artifacts: $ProjectPcreWithoutInstallAll"
Write-Information "[PowerShell] Component information: PCRE without installing files: $ProjectPcreWithoutInstallFiles"
Write-Information "[PowerShell] Component information: PCRE without installing headers: $ProjectPcreWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: PCRE without installing libraries: $ProjectPcreWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: PCRE without test apps: $ProjectPcreWithoutTestApps"
Write-Information "[PowerShell] Component information: POCO with shared libraries: $ProjectPocoWithSharedLibraries"
Write-Information "[PowerShell] Component information: POCO with shared Zlib: $ProjectPocoWithSharedZlib"
Write-Information "[PowerShell] Component information: POCO without apps: $ProjectPocoWithoutApps"
Write-Information "[PowerShell] Component information: POCO without installing all artifacts: $ProjectPocoWithoutInstallAll"
Write-Information "[PowerShell] Component information: POCO without installing files: $ProjectPocoWithoutInstallFiles"
Write-Information "[PowerShell] Component information: POCO without installing headers: $ProjectPocoWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: POCO without installing libraries: $ProjectPocoWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Protocol Buffer with external Protocol Buffer Compiler: $ProjectProtoBufWithExternalProtoc"
Write-Information "[PowerShell] Component information: Protocol Buffer with shared libraries: $ProjectProtoBufWithSharedLibraries"
Write-Information "[PowerShell] Component information: Protocol Buffer with shared Zlib: $ProjectProtoBufWithSharedZlib"
Write-Information "[PowerShell] Component information: Protocol Buffer with Zlib: $ProjectProtoBufWithZlib"
Write-Information "[PowerShell] Component information: Protocol Buffer without installing all artifacts: $ProjectProtoBufWithoutInstallAll"
Write-Information "[PowerShell] Component information: Protocol Buffer without installing files: $ProjectProtoBufWithoutInstallFiles"
Write-Information "[PowerShell] Component information: Protocol Buffer without installing headers: $ProjectProtoBufWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: Protocol Buffer without installing libraries: $ProjectProtoBufWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Protocol Buffer without test apps: $ProjectProtoBufWithoutTestApps"
Write-Information "[PowerShell] Component information: PThreads4W without installing all artifacts: $ProjectPthreads4wWithoutInstallAll"
Write-Information "[PowerShell] Component information: PThreads4W without installing files: $ProjectPthreads4wWithoutInstallFiles"
Write-Information "[PowerShell] Component information: PThreads4W without installing headers: $ProjectPthreads4wWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: PThreads4W without installing libraries: $ProjectPthreads4wWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: PThreads4W without test apps: $ProjectPthreads4wWithoutTestApps"
Write-Information "[PowerShell] Component information: SQLite with shared libraries: $ProjectSqliteWithSharedLibraries"
Write-Information "[PowerShell] Component information: SQLite without apps: $ProjectSqliteWithoutApps"
Write-Information "[PowerShell] Component information: SQLite without installing all artifacts: $ProjectSqliteWithoutInstallAll"
Write-Information "[PowerShell] Component information: SQLite without installing files: $ProjectSqliteWithoutInstallFiles"
Write-Information "[PowerShell] Component information: SQLite without installing headers: $ProjectSqliteWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: SQLite without installing libraries: $ProjectSqliteWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Zlib without installing all artifacts: $ProjectZlibWithoutInstallAll"
Write-Information "[PowerShell] Component information: Zlib without installing files: $ProjectZlibWithoutInstallFiles"
Write-Information "[PowerShell] Component information: Zlib without installing headers: $ProjectZlibWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: Zlib without installing libraries: $ProjectZlibWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: Zlib without test apps: $ProjectZlibWithoutTestApps"



## Detect source folder
Write-Information "[PowerShell] Detecting $SourceFolder folder ..."
if (-not (Test-Path -Path $SourceFolder)) {
    Write-Error "[PowerShell] Detecting $SourceFolder folder ... NOT FOUND"
    Exit 1
}
Write-Information "[PowerShell] Detecting $SourceFolder folder ... FOUND"



## Create or clean temp folder
if (-not ('ON'.Equals($ProjectShouldDisableCleanBuild))) {
    $MyIoError = $null
    Write-Information "[PowerShell] Cleaning $TempRootFolder folder ..."
    if (Test-Path -Path $TempRootFolder) {
        Write-Verbose "[PowerShell] Removing $TempRootFolder folder ..."
        Remove-Item -Recurse -Force $TempRootFolder -ErrorVariable MyIoError
        if ($MyIoError) {
            Write-Error "[PowerShell] Remove $TempRootFolder folder ... FAILED"
            Exit 1
        }
    }
    Write-Information "[PowerShell] Cleaning $TempRootFolder folder ... DONE"
}
if (-not (Test-Path -Path $TempBuildFolder)) {
    $MyIoError = $null
    Write-Verbose "[PowerShell] Creating $TempBuildFolder folder ..."
    New-Item -ItemType Directory -Path $TempBuildFolder -ErrorVariable MyIoError | Out-Null
    if ($MyIoError) {
        Write-Error "[PowerShell] Creating $TempBuildFolder folder ... FAILED"
        Exit 1
    }
    Write-Verbose "[PowerShell] Creating $TempBuildFolder folder ... DONE"
}
if (-not (Test-Path -Path $TempInstallFolder)) {
    $MyIoError = $null
    Write-Verbose "[PowerShell] Creating $TempInstallFolder folder ..."
    New-Item -ItemType Directory -Path $TempInstallFolder -ErrorVariable MyIoError | Out-Null
    if ($MyIoError) {
        Write-Error "[PowerShell] Creating $TempInstallFolder folder ... FAILED"
        Exit 1
    }
    Write-Verbose "[PowerShell] Creating $TempInstallFolder folder ... DONE"
}



## Detect CMake
$MyCmakeProcess = $null
$MyCmakeProcessHandle = $null
Write-Information "[PowerShell] Detecting CMake ..."
try {
    $MyCmakeProcess = Start-Process -FilePath "${Env:ProgramFiles}\CMake\bin\$CmakeCli" -WindowStyle Hidden -PassThru `
            -ArgumentList "--help"
    $MyCmakeProcessHandle = $MyCmakeProcess.Handle
    $MyCmakeProcess.WaitForExit()
    $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
    if ($MyCmakeProcessExitCode -ne 0) {
        Write-Error "[PowerShell] Detecting CMake ... INCORRECT (ExitCode: $MyCmakeProcessExitCode)"
        Exit 1
    }
} catch {
    Write-Error "[PowerShell] Detecting CMake ... NOT FOUND"
    Exit 1
} finally {
    if ($null -ne $MyCmakeProcessHandle) {
        $MyCmakeProcessHandle = $null
    }
    if ($null -ne $MyCmakeProcess) {
        $MyCmakeProcess.Dispose()
        $MyCmakeProcess = $null
    }
}
Write-Information "[PowerShell] Detecting CMake ... FOUND"



## Append Protoc user folder into PATH
$MyProtocTargetPath = "${Env:USERPROFILE}\.protoc\${ProjectProtocVersion}"
$Env:PATH = $Env:PATH + ';' + "${MyProtocTargetPath}\bin"



## Detect Project Protoc
Write-Information "[PowerShell] Detecting Project Protoc ..."
if (-not $MyProjectProtocCliDetected) {
    $MyProtocProcess = $null
    $MyProtocProcessHandle = $null
    try {
        $MyProtocProcess = Start-Process -FilePath "$MyProjectProtocCli" -WindowStyle Hidden -PassThru `
                -ArgumentList "--version"
        $MyProtocProcessHandle = $MyProtocProcess.Handle
        $MyProtocProcess.WaitForExit()
        $MyProtocProcessExitCode = $MyProtocProcess.ExitCode
        if ($MyProtocProcessExitCode -ne 0) {
            Write-Error "[PowerShell] Detecting Project Protoc ... INCORRECT (ExitCode: $MyProtocProcessExitCode)"
            $MyProjectProtocCliDetected = $false
        } else {
            Write-Information "[PowerShell] Detecting Project Protoc ... FOUND"
            $MyProjectProtocCliDetected = $true
        }
    } catch {
        Write-Information "[PowerShell] Detecting Project Protoc ... NOT FOUND (Project Protoc is missing)"
        $MyProjectProtocCliDetected = $false
    } finally {
        if ($null -ne $MyProtocProcessHandle) {
            $MyProtocProcessHandle = $null
        }
        if ($null -ne $MyProtocProcess) {
            $MyProtocProcess.Dispose()
            $MyProtocProcess = $null
        }
    }
}



## Restore Project Protoc
if (-not $MyProjectProtocCliDetected) {
    Write-Information "[PowerShell] Restoring Project Protoc ..."

    ## Restore Project Protoc - Download archive file
    $MyProtocArchiveName = $ProtocVersionArchitectureToArchiveNameMap["${ProjectProtocVersion}_${Env:PROCESSOR_ARCHITECTURE}"]
    $MyProtocArchiveUrl = "https://github.com/protocolbuffers/protobuf/releases/download/v${ProjectProtocVersion}/${MyProtocArchiveName}"
    $MyProtocTempPath = [System.guid]::NewGuid().toString()
    $MyProtocTempPath = "${Env:Temp}\${MyProtocTempPath}_${MyProtocArchiveName}"
    Write-Information "[PowerShell] Restoring Project Protoc ... Downloading archive file from ${MyProtocArchiveUrl} ..."
    try {
        Invoke-WebRequest $MyProtocArchiveUrl -OutFile $MyProtocTempPath
    } catch {
        Write-Error "[PowerShell] Restoring Project Protoc ... Downloading archive file from ${MyProtocArchiveUrl} ... FAILED"
        Exit 1
    }
    Write-Information "[PowerShell] Restoring Project Protoc ... Downloading archive file from ${MyProtocArchiveUrl} ... DONE"

    ## Restore Project Protoc - Extract archive file
    Write-Information "[PowerShell] Restoring Project Protoc ... Extracting archive file to ${MyProtocTargetPath} ..."
    try {
        Expand-Archive -Path $MyProtocTempPath -DestinationPath $MyProtocTargetPath
    } catch {
        Write-Error "[PowerShell] Restoring Project Protoc ... Extracting archive file to ${MyProtocTargetPath} ... FAILED"
        Exit 1
    }
    Write-Information "[PowerShell] Restoring Project Protoc ... Extracting archive file to ${MyProtocTargetPath} ... DONE"

    ## Restore Project Protoc - Check binary file
    Write-Information "[PowerShell] Restoring Project Protoc ... Checking binary file ..."
    if (-not (Test-Path "${MyProtocTargetPath}\bin")) {
        Write-Error "[PowerShell] Restoring Project Protoc ... Checking binary file ... FAILED (Folder does not exist)"
        Exit 1
    }
    if (Test-Path "${MyProtocTargetPath}\bin\${MyProjectProtocCli}.exe") {
        Write-Information "[PowerShell] Restoring Project Protoc ... Checking binary file ... FOUND"
    } elseif (-not (Test-Path "${MyProtocTargetPath}\bin\${ProtocCli}.exe")) {
        Write-Error "[PowerShell] Restoring Project Protoc ... Checking binary file ... NOT FOUND (Protoc is missing)"
        Exit 1
    } else {
        Move-Item -Path "${MyProtocTargetPath}\bin\${ProtocCli}.exe" -Destination "${MyProtocTargetPath}\bin\${MyProjectProtocCli}.exe" -Force -ErrorVariable MyIoError | Out-Null
        if ($MyIoError) {
            Write-Error "[PowerShell] Restoring Project Protoc ... Checking binary file ... FAILED (Can not move resource)"
            Exit 1
        }
        $MyProtocProcess = $null
        $MyProtocProcessHandle = $null
        try {
            $MyProtocProcess = Start-Process -FilePath "$MyProjectProtocCli" -WindowStyle Hidden -PassThru `
                    -ArgumentList "--version"
            $MyProtocProcessHandle = $MyProtocProcess.Handle
            $MyProtocProcess.WaitForExit()
            $MyProtocProcessExitCode = $MyProtocProcess.ExitCode
            if ($MyProtocProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Restoring Project Protoc ... Checking binary file ... INCORRECT (ExitCode: $MyProtocProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Information "[PowerShell] Restoring Project Protoc ... Checking binary file ... NOT FOUND (Project Protoc is missing)"
            Exit 1
        } finally {
            if ($null -ne $MyProtocProcessHandle) {
                $MyProtocProcessHandle = $null
            }
            if ($null -ne $MyProtocProcess) {
                $MyProtocProcess.Dispose()
                $MyProtocProcess = $null
            }
        }
        Write-Information "[PowerShell] Restoring Project Protoc ... Checking binary file ... DONE"
    }
}



## Build project
Write-Information "[PowerShell] Building project ..."
foreach ($MyCmakePlatform in $MyCmakePlatformList) {
    ## Build project for arch $MyCmakePlatform
    Write-Information "[PowerShell] Building project for arch $MyCmakePlatform ..."
    if (-not ('ON'.Equals($MyCmakePlatformToBuildToggleMap[$MyCmakePlatform]))) {
        Write-Information "[PowerShell] Building project for arch $MyCmakePlatform ... SKIPPED"
    } else {
        $MyTempBuildFolder = Join-Path -Path $TempBuildFolder -ChildPath $ProjectReleaseType
        $MyTempBuildFolder = Join-Path -Path $MyTempBuildFolder -ChildPath $MyCmakePlatform
        $MyTempInstallFolderAbs = Resolve-Path $TempInstallFolder
        $MyTempInstallFolderAbs = Join-Path -Path $MyTempInstallFolderAbs -ChildPath $ProjectReleaseType
        $MyTempInstallFolderAbs = Join-Path -Path $MyTempInstallFolderAbs -ChildPath $MyCmakePlatform

        ## Build project for arch $MyCmakePlatform - Generate project
        $MyCmakeProcess = $null
        $MyCmakeProcessHandle = $null
        Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Generating project ..."
        try {
            $MyCmakeArgumentList = $MyCmakeCommonArgumentList + @(
                    "-B $MyTempBuildFolder",
                    "-A $MyCmakePlatform",
                    "--install-prefix `"$MyTempInstallFolderAbs`""
            )
            if ('ON'.Equals($ProjectWithWorkaroundArm64rt)) {
                if ('ARM64'.Equals($MyCmakePlatform)) {
                    $MyCmakeArgumentList += "-DBUILD_WITH_WORKAROUND_ARM64RT=$ProjectWithWorkaroundArm64rt"
                }
            }
            if ('ON'.Equals($ProjectWithWorkaroundOptGy)) {
                if ('ARM'.Equals($MyCmakePlatform)) {
                    $MyCmakeArgumentList += "-DBUILD_WITH_WORKAROUND_OPT_GY=$ProjectWithWorkaroundOptGy"
                }
            }
            $MyCmakeArgumentListString = $MyCmakeArgumentList -join " "
            Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Generating project ... argument list: $MyCmakeArgumentListString"
            $MyCmakeProcess = Start-Process -FilePath "${Env:ProgramFiles}\CMake\bin\$CmakeCli" -NoNewWindow -PassThru `
                    -ArgumentList $MyCmakeArgumentListString
            $MyCmakeProcessHandle = $MyCmakeProcess.Handle
            $MyCmakeProcess.WaitForExit()
            $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
            if ($MyCmakeProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Building project for arch $MyCmakePlatform ... Generating project ... FAILED (ExitCode: $MyCmakeProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Error "[PowerShell] Building project for arch $MyCmakePlatform ... Generating project ... FAILED (CMake is missing)"
            Exit 1
        } finally {
            if ($null -ne $MyCmakeProcessHandle) {
                $MyCmakeProcessHandle = $null
            }
            if ($null -ne $MyCmakeProcess) {
                $MyCmakeProcess.Dispose()
                $MyCmakeProcess = $null
            }
        }
        Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Generating project ... DONE"

        ## Build project for arch $MyCmakePlatform - Compile project
        $MyCmakeProcess = $null
        $MyCmakeProcessHandle = $null
        Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Compiling project ..."
        try {
            $MyCmakeParaParallel = '-- /m'
            if ('ON'.Equals($ProjectShouldDisableParallelBuild)) {
                $MyCmakeParaParallel = ''
            }
            $MyCmakeProcess = Start-Process -FilePath "${Env:ProgramFiles}\CMake\bin\$CmakeCli" -NoNewWindow -PassThru `
                    -ArgumentList "--build $MyTempBuildFolder --config $ProjectReleaseType $MyCmakeParaParallel"
            $MyCmakeProcessHandle = $MyCmakeProcess.Handle
            $MyCmakeProcess.WaitForExit()
            $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
            if ($MyCmakeProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Building project for arch $MyCmakePlatform ... Compiling project ... FAILED (ExitCode: $MyCmakeProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Error "[PowerShell] Building project for arch $MyCmakePlatform ... Compiling project ... FAILED (CMake is missing)"
            Exit 1
        } finally {
            if ($null -ne $MyCmakeProcessHandle) {
                $MyCmakeProcessHandle = $null
            }
            if ($null -ne $MyCmakeProcess) {
                $MyCmakeProcess.Dispose()
                $MyCmakeProcess = $null
            }
        }
        Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Compiling project ... DONE"

        ## Build project for arch $MyCmakePlatform - Install project
        $MyCmakeProcess = $null
        $MyCmakeProcessHandle = $null
        Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Installing project ..."
        try {
            $MyCmakeProcess = Start-Process -FilePath "${Env:ProgramFiles}\CMake\bin\$CmakeCli" -NoNewWindow -PassThru `
                    -ArgumentList "--install $MyTempBuildFolder --config $ProjectReleaseType"
            $MyCmakeProcessHandle = $MyCmakeProcess.Handle
            $MyCmakeProcess.WaitForExit()
            $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
            if ($MyCmakeProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Building project for arch $MyCmakePlatform ... Installing project ... FAILED (ExitCode: $MyCmakeProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Error "[PowerShell] Building project for arch $MyCmakePlatform ... Installing project ... FAILED (CMake is missing)"
            Exit 1
        } finally {
            if ($null -ne $MyCmakeProcessHandle) {
                $MyCmakeProcessHandle = $null
            }
            if ($null -ne $MyCmakeProcess) {
                $MyCmakeProcess.Dispose()
                $MyCmakeProcess = $null
            }
        }
        Write-Verbose "[PowerShell] Building project for arch $MyCmakePlatform ... Installing project ... DONE"

        Write-Information "[PowerShell] Building project for arch $MyCmakePlatform ... DONE"
    }
}
Write-Information "[PowerShell] Building project ... DONE"
