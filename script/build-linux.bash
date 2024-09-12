#!/usr/bin/env bash

##
## Global config
##
CMAKE_CLI=cmake
DIRNAME_CLI=/usr/bin/dirname
PWD_CLI=/bin/pwd
UNAME_CLI=/bin/uname
declare -A GCC_ARCH_TO_ABI_MAP=(
        ["aarch64"]="gnu"
        ["arm"]="gnueabihf"
        ["x86_64"]="gnu"
)
SCRIPT_DIR=$(cd -- "$(${DIRNAME_CLI} "${BASH_SOURCE[0]:-${(%):-%x}}")" &> /dev/null && ${PWD_CLI})
SYSTEM_PLATFORM=$($UNAME_CLI)
PROJECT_DIR=$SCRIPT_DIR/..
SOURCE_DIR=$PROJECT_DIR
TEMP_ROOT_DIR=$PROJECT_DIR/build
TEMP_BUILD_DIR=$TEMP_ROOT_DIR/t
TEMP_INSTALL_DIR=$TEMP_ROOT_DIR/i

##
## Project config
##
####
#### Project level config
####
PROJECT_GCC_AR_NAME="${MY_PROJECT_GCC_AR_NAME:=ar}"
PROJECT_GCC_C_COMPILER_NAME="${MY_PROJECT_GCC_C_COMPILER_NAME:=gcc-11}"
PROJECT_GCC_CXX_COMPILER_NAME="${MY_PROJECT_GCC_CXX_COMPILER_NAME:=g++-11}"
PROJECT_GCC_LD_NAME="${MY_PROJECT_GCC_LD_NAME:=ld}"
PROJECT_GCC_OS_NAME="${MY_PROJECT_GCC_OS_NAME:=linux}"
PROJECT_RELEASE_TYPE="${MY_PROJECT_RELEASE_TYPE:=Debug}"
PROJECT_REVISION="${BUILD_NUMBER:=9999}"
PROJECT_SHOULD_DISABLE_CLEAN_BUILD="${MY_PROJECT_SHOULD_DISABLE_CLEAN_BUILD:=OFF}"
PROJECT_SHOULD_DISABLE_PARALLEL_BUILD="${MY_PROJECT_SHOULD_DISABLE_PARALLEL_BUILD:=OFF}"
PROJECT_SHOULD_DISABLE_32BIT_BUILD="${MY_PROJECT_SHOULD_DISABLE_32BIT_BUILD:=OFF}"
PROJECT_SHOULD_DISABLE_64BIT_BUILD="${MY_PROJECT_SHOULD_DISABLE_64BIT_BUILD:=OFF}"
PROJECT_SHOULD_DISABLE_ARM_BUILD="${MY_PROJECT_SHOULD_DISABLE_ARM_BUILD:=OFF}"
PROJECT_SHOULD_DISABLE_X86_BUILD="${MY_PROJECT_SHOULD_DISABLE_X86_BUILD:=OFF}"
####
#### Project component level config
####
PROJECT_BOOST_WITH_SHARED_LIBRARIES="${MY_PROJECT_BOOST_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_BOOST_WITHOUT_APPS="${MY_PROJECT_BOOST_WITHOUT_APPS:=OFF}"
PROJECT_BOOST_WITHOUT_INSTALL_ALL="${MY_PROJECT_BOOST_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_BOOST_WITHOUT_INSTALL_FILES="${MY_PROJECT_BOOST_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_BOOST_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_BOOST_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_CURL_WITH_OPENSSL="${MY_PROJECT_CURL_WITH_OPENSSL:=OFF}"
PROJECT_CURL_WITH_SHARED_LIBRARIES="${MY_PROJECT_CURL_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_CURL_WITH_SHARED_ZLIB="${MY_PROJECT_CURL_WITH_SHARED_ZLIB:=OFF}"
PROJECT_CURL_WITH_ZLIB="${MY_PROJECT_CURL_WITH_ZLIB:=OFF}"
PROJECT_CURL_WITHOUT_APPS="${MY_PROJECT_CURL_WITHOUT_APPS:=OFF}"
PROJECT_CURL_WITHOUT_INSTALL_ALL="${MY_PROJECT_CURL_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_CURL_WITHOUT_INSTALL_FILES="${MY_PROJECT_CURL_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_CURL_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_CURL_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_EXPAT_WITH_SHARED_LIBRARIES="${MY_PROJECT_EXPAT_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_EXPAT_WITHOUT_APPS="${MY_PROJECT_EXPAT_WITHOUT_APPS:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_ALL="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_FILES="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_EXPAT_WITHOUT_TEST_APPS="${MY_PROJECT_EXPAT_WITHOUT_TEST_APPS:=OFF}"
PROJECT_NETSNMP_WITH_IPV6="${MY_PROJECT_NETSNMP_WITH_IPV6:=OFF}"
PROJECT_NETSNMP_WITH_SHARED_LIBRARIES="${MY_PROJECT_NETSNMP_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_NETSNMP_WITH_SSL="${MY_PROJECT_NETSNMP_WITH_SSL:=OFF}"
PROJECT_NETSNMP_WITHOUT_APPS="${MY_PROJECT_NETSNMP_WITHOUT_APPS:=OFF}"
PROJECT_NETSNMP_WITHOUT_INSTALL_ALL="${MY_PROJECT_NETSNMP_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_NETSNMP_WITHOUT_INSTALL_FILES="${MY_PROJECT_NETSNMP_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_NETSNMP_WITHOUT_MIB_LOADING="${MY_PROJECT_NETSNMP_WITHOUT_MIB_LOADING:=OFF}"
PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS="${MY_PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS:=OFF}"
PROJECT_OPENSSL_WITH_SHARED_LIBRARIES="${MY_PROJECT_OPENSSL_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_OPENSSL_WITH_SHARED_ZLIB="${MY_PROJECT_OPENSSL_WITH_SHARED_ZLIB:=OFF}"
PROJECT_OPENSSL_WITH_ZLIB="${MY_PROJECT_OPENSSL_WITH_ZLIB:=OFF}"
PROJECT_OPENSSL_WITHOUT_APPS="${MY_PROJECT_OPENSSL_WITHOUT_APPS:=OFF}"
PROJECT_OPENSSL_WITHOUT_INSTALL_ALL="${MY_PROJECT_OPENSSL_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_OPENSSL_WITHOUT_INSTALL_FILES="${MY_PROJECT_OPENSSL_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_PAHO_WITH_OPENSSL="${MY_PROJECT_PAHO_WITH_OPENSSL:=OFF}"
PROJECT_PAHO_WITH_SHARED_LIBRARIES="${MY_PROJECT_PAHO_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_PAHO_WITHOUT_INSTALL_ALL="${MY_PROJECT_PAHO_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_PAHO_WITHOUT_INSTALL_FILES="${MY_PROJECT_PAHO_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_PAHO_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_PAHO_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_PAHO_WITHOUT_TEST_APPS="${MY_PROJECT_PAHO_WITHOUT_TEST_APPS:=OFF}"
PROJECT_PCRE_WITH_SHARED_LIBRARIES="${MY_PROJECT_PCRE_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_PCRE_WITHOUT_APPS="${MY_PROJECT_PCRE_WITHOUT_APPS:=OFF}"
PROJECT_PCRE_WITHOUT_INSTALL_ALL="${MY_PROJECT_PCRE_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_PCRE_WITHOUT_INSTALL_FILES="${MY_PROJECT_PCRE_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_PCRE_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_PCRE_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_PCRE_WITHOUT_TEST_APPS="${MY_PROJECT_PCRE_WITHOUT_TEST_APPS:=OFF}"
PROJECT_POCO_WITH_SHARED_LIBRARIES="${MY_PROJECT_POCO_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_POCO_WITH_SHARED_ZLIB="${MY_PROJECT_POCO_WITH_SHARED_ZLIB:=OFF}"
PROJECT_POCO_WITHOUT_APPS="${MY_PROJECT_POCO_WITHOUT_APPS:=OFF}"
PROJECT_POCO_WITHOUT_INSTALL_ALL="${MY_PROJECT_POCO_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_POCO_WITHOUT_INSTALL_FILES="${MY_PROJECT_POCO_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_POCO_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_POCO_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES="${MY_PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_PROTOBUF_WITH_SHARED_ZLIB="${MY_PROJECT_PROTOBUF_WITH_SHARED_ZLIB:=OFF}"
PROJECT_PROTOBUF_WITH_ZLIB="${MY_PROJECT_PROTOBUF_WITH_ZLIB:=OFF}"
PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL="${MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES="${MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_PROTOBUF_WITHOUT_TEST_APPS="${MY_PROJECT_PROTOBUF_WITHOUT_TEST_APPS:=OFF}"
PROJECT_SQLITE_WITH_SHARED_LIBRARIES="${MY_PROJECT_SQLITE_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_SQLITE_WITHOUT_APPS="${MY_PROJECT_SQLITE_WITHOUT_APPS:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_ALL="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_FILES="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_ZLIB_WITHOUT_INSTALL_ALL="${MY_PROJECT_ZLIB_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_ZLIB_WITHOUT_INSTALL_FILES="${MY_PROJECT_ZLIB_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_ZLIB_WITHOUT_TEST_APPS="${MY_PROJECT_ZLIB_WITHOUT_TEST_APPS:=OFF}"

##
## My variables
##
MY_CMAKE_COMMON_ARGUMENT_LIST=(
        "-S $SOURCE_DIR"
        "-DMY_REVISION=$PROJECT_REVISION"
        "-DCMAKE_BUILD_TYPE=$PROJECT_RELEASE_TYPE"
        "-DCMAKE_SYSTEM_NAME=$SYSTEM_PLATFORM"
        "-DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY"
        "-DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF"
)
if [ "ON" = "$PROJECT_BOOST_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DBOOST_WITH_SHARED_LIBRARIES=$PROJECT_BOOST_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_BOOST_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DBOOST_WITHOUT_APPS=$PROJECT_BOOST_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_BOOST_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DBOOST_WITHOUT_INSTALL_ALL=$PROJECT_BOOST_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_BOOST_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DBOOST_WITHOUT_INSTALL_FILES=$PROJECT_BOOST_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_BOOST_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DBOOST_WITHOUT_INSTALL_HEADERS=$PROJECT_BOOST_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DBOOST_WITHOUT_INSTALL_LIBRARIES=$PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_CURL_WITH_OPENSSL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITH_OPENSSL=$PROJECT_CURL_WITH_OPENSSL")
fi
if [ "ON" = "$PROJECT_CURL_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITH_SHARED_LIBRARIES=$PROJECT_CURL_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_CURL_WITH_SHARED_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITH_SHARED_ZLIB=$PROJECT_CURL_WITH_SHARED_ZLIB")
fi
if [ "ON" = "$PROJECT_CURL_WITH_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITH_ZLIB=$PROJECT_CURL_WITH_ZLIB")
fi
if [ "ON" = "$PROJECT_CURL_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITHOUT_APPS=$PROJECT_CURL_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_CURL_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITHOUT_INSTALL_ALL=$PROJECT_CURL_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_CURL_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITHOUT_INSTALL_FILES=$PROJECT_CURL_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_CURL_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITHOUT_INSTALL_HEADERS=$PROJECT_CURL_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DCURL_WITHOUT_INSTALL_LIBRARIES=$PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_EXPAT_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITH_SHARED_LIBRARIES=$PROJECT_EXPAT_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_EXPAT_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITHOUT_APPS=$PROJECT_EXPAT_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_EXPAT_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITHOUT_INSTALL_ALL=$PROJECT_EXPAT_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_EXPAT_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITHOUT_INSTALL_FILES=$PROJECT_EXPAT_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITHOUT_INSTALL_HEADERS=$PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITHOUT_INSTALL_LIBRARIES=$PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_EXPAT_WITHOUT_TEST_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DEXPAT_WITHOUT_TEST_APPS=$PROJECT_EXPAT_WITHOUT_TEST_APPS")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITH_IPV6" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITH_IPV6=$PROJECT_NETSNMP_WITH_IPV6")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITH_SHARED_LIBRARIES=$PROJECT_NETSNMP_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITH_SSL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITH_SSL=$PROJECT_NETSNMP_WITH_SSL")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITHOUT_APPS=$PROJECT_NETSNMP_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITHOUT_INSTALL_ALL=$PROJECT_NETSNMP_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITHOUT_INSTALL_FILES=$PROJECT_NETSNMP_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITHOUT_INSTALL_HEADERS=$PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITHOUT_INSTALL_LIBRARIES=$PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_NETSNMP_WITHOUT_MIB_LOADING" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DNETSNMP_WITHOUT_MIB_LOADING=$PROJECT_NETSNMP_WITHOUT_MIB_LOADING")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITH_DEPRECATED_CIPHERS=$PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITH_SHARED_LIBRARIES=$PROJECT_OPENSSL_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITH_SHARED_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITH_SHARED_ZLIB=$PROJECT_OPENSSL_WITH_SHARED_ZLIB")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITH_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITH_ZLIB=$PROJECT_OPENSSL_WITH_ZLIB")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITHOUT_APPS=$PROJECT_OPENSSL_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITHOUT_INSTALL_ALL=$PROJECT_OPENSSL_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITHOUT_INSTALL_FILES=$PROJECT_OPENSSL_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITHOUT_INSTALL_HEADERS=$PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DOPENSSL_WITHOUT_INSTALL_LIBRARIES=$PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PAHO_WITH_OPENSSL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITH_OPENSSL=$PROJECT_PAHO_WITH_OPENSSL")
fi
if [ "ON" = "$PROJECT_PAHO_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITH_SHARED_LIBRARIES=$PROJECT_PAHO_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PAHO_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITHOUT_INSTALL_ALL=$PROJECT_PAHO_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_PAHO_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITHOUT_INSTALL_FILES=$PROJECT_PAHO_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_PAHO_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITHOUT_INSTALL_HEADERS=$PROJECT_PAHO_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITHOUT_INSTALL_LIBRARIES=$PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PAHO_WITHOUT_TEST_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPAHO_WITHOUT_TEST_APPS=$PROJECT_PAHO_WITHOUT_TEST_APPS")
fi
if [ "ON" = "$PROJECT_PCRE_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITH_SHARED_LIBRARIES=$PROJECT_PCRE_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PCRE_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITHOUT_APPS=$PROJECT_PCRE_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_PCRE_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITHOUT_INSTALL_ALL=$PROJECT_PCRE_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_PCRE_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITHOUT_INSTALL_FILES=$PROJECT_PCRE_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_PCRE_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITHOUT_INSTALL_HEADERS=$PROJECT_PCRE_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITHOUT_INSTALL_LIBRARIES=$PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PCRE_WITHOUT_TEST_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPCRE_WITHOUT_TEST_APPS=$PROJECT_PCRE_WITHOUT_TEST_APPS")
fi
if [ "ON" = "$PROJECT_POCO_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITH_SHARED_LIBRARIES=$PROJECT_POCO_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_POCO_WITH_SHARED_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITH_SHARED_ZLIB=$PROJECT_POCO_WITH_SHARED_ZLIB")
fi
if [ "ON" = "$PROJECT_POCO_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITHOUT_APPS=$PROJECT_POCO_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_POCO_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITHOUT_INSTALL_ALL=$PROJECT_POCO_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_POCO_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITHOUT_INSTALL_FILES=$PROJECT_POCO_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_POCO_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITHOUT_INSTALL_HEADERS=$PROJECT_POCO_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPOCO_WITHOUT_INSTALL_LIBRARIES=$PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITH_SHARED_LIBRARIES=$PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITH_SHARED_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITH_SHARED_ZLIB=$PROJECT_PROTOBUF_WITH_SHARED_ZLIB")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITH_ZLIB" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITH_ZLIB=$PROJECT_PROTOBUF_WITH_ZLIB")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITHOUT_INSTALL_ALL=$PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITHOUT_INSTALL_FILES=$PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITHOUT_INSTALL_HEADERS=$PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITHOUT_INSTALL_LIBRARIES=$PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_PROTOBUF_WITHOUT_TEST_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DPROTOBUF_WITHOUT_TEST_APPS=$PROJECT_PROTOBUF_WITHOUT_TEST_APPS")
fi
if [ "ON" = "$PROJECT_SQLITE_WITH_SHARED_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DSQLITE_WITH_SHARED_LIBRARIES=$PROJECT_SQLITE_WITH_SHARED_LIBRARIES")
fi
if [ "ON" = "$PROJECT_SQLITE_WITHOUT_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DSQLITE_WITHOUT_APPS=$PROJECT_SQLITE_WITHOUT_APPS")
fi
if [ "ON" = "$PROJECT_SQLITE_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DSQLITE_WITHOUT_INSTALL_ALL=$PROJECT_SQLITE_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_SQLITE_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DSQLITE_WITHOUT_INSTALL_FILES=$PROJECT_SQLITE_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DSQLITE_WITHOUT_INSTALL_HEADERS=$PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DSQLITE_WITHOUT_INSTALL_LIBRARIES=$PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_ZLIB_WITHOUT_INSTALL_ALL" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DZLIB_WITHOUT_INSTALL_ALL=$PROJECT_ZLIB_WITHOUT_INSTALL_ALL")
fi
if [ "ON" = "$PROJECT_ZLIB_WITHOUT_INSTALL_FILES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DZLIB_WITHOUT_INSTALL_FILES=$PROJECT_ZLIB_WITHOUT_INSTALL_FILES")
fi
if [ "ON" = "$PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DZLIB_WITHOUT_INSTALL_HEADERS=$PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS")
fi
if [ "ON" = "$PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DZLIB_WITHOUT_INSTALL_LIBRARIES=$PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES")
fi
if [ "ON" = "$PROJECT_ZLIB_WITHOUT_TEST_APPS" ]; then
    MY_CMAKE_COMMON_ARGUMENT_LIST+=("-DZLIB_WITHOUT_TEST_APPS=$PROJECT_ZLIB_WITHOUT_TEST_APPS")
fi
MY_GCC_ARCH_LIST=(
        "aarch64"
        "arm"
        "x86_64"
)
declare -A MY_GCC_ARCH_BUILD_TOGGLE_MAP=(
        ["aarch64"]="ON"
        ["arm"]="ON"
        ["x86_64"]="ON"
)
if [ "ON" = "$PROJECT_SHOULD_DISABLE_32BIT_BUILD" ]; then
    MY_GCC_ARCH_BUILD_TOGGLE_MAP["arm"]="OFF"
fi
if [ "ON" = "$PROJECT_SHOULD_DISABLE_64BIT_BUILD" ]; then
    MY_GCC_ARCH_BUILD_TOGGLE_MAP["aarch64"]="OFF"
    MY_GCC_ARCH_BUILD_TOGGLE_MAP["x86_64"]="OFF"
fi
if [ "ON" = "$PROJECT_SHOULD_DISABLE_ARM_BUILD" ]; then
    MY_GCC_ARCH_BUILD_TOGGLE_MAP["aarch64"]="OFF"
    MY_GCC_ARCH_BUILD_TOGGLE_MAP["arm"]="OFF"
fi
if [ "ON" = "$PROJECT_SHOULD_DISABLE_X86_BUILD" ]; then
    MY_GCC_ARCH_BUILD_TOGGLE_MAP["x86_64"]="OFF"
fi



## Print build information
echo "[$SYSTEM_PLATFORM] Project information: version: $MY_PROJECT_VERSION"
echo "[$SYSTEM_PLATFORM] Project information: revision: $PROJECT_REVISION"
echo "[$SYSTEM_PLATFORM] Project information: release type: $PROJECT_RELEASE_TYPE"
echo "[$SYSTEM_PLATFORM] Project information: disable clean build: $PROJECT_SHOULD_DISABLE_CLEAN_BUILD"
echo "[$SYSTEM_PLATFORM] Project information: disable parallel build: $PROJECT_SHOULD_DISABLE_PARALLEL_BUILD"
echo "[$SYSTEM_PLATFORM] Component information: Boost with shared libraries: $PROJECT_BOOST_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Boost without apps: $PROJECT_BOOST_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: Boost without installing all artifacts: $PROJECT_BOOST_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: Boost without installing files: $PROJECT_BOOST_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: Boost without installing headers: $PROJECT_BOOST_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: Boost without installing libraries: $PROJECT_BOOST_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: CURL with OpenSSL: $PROJECT_CURL_WITH_OPENSSL"
echo "[$SYSTEM_PLATFORM] Component information: CURL with shared libraries: $PROJECT_CURL_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: CURL with shared Zlib: $PROJECT_CURL_WITH_SHARED_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: CURL with Zlib: $PROJECT_CURL_WITH_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: CURL without apps: $PROJECT_CURL_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: CURL without installing all artifacts: $PROJECT_CURL_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: CURL without installing files: $PROJECT_CURL_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: CURL without installing headers: $PROJECT_CURL_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: CURL without installing libraries: $PROJECT_CURL_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: expat with shared libraries: $PROJECT_EXPAT_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: expat without apps: $PROJECT_EXPAT_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing all artifacts: $PROJECT_EXPAT_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing files: $PROJECT_EXPAT_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing headers: $PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing libraries: $PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: expat without test apps: $PROJECT_EXPAT_WITHOUT_TEST_APPS"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP with IPv6: $PROJECT_NETSNMP_WITH_IPV6"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP with shared libraries: $PROJECT_NETSNMP_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP with SSL: $PROJECT_NETSNMP_WITH_SSL"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP without apps: $PROJECT_NETSNMP_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP without installing all artifacts: $PROJECT_NETSNMP_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP without installing files: $PROJECT_NETSNMP_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP without installing headers: $PROJECT_NETSNMP_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP without installing libraries: $PROJECT_NETSNMP_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Net-SNMP without MIB loading: $PROJECT_NETSNMP_WITHOUT_MIB_LOADING"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL with deprecated ciphers: $PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL with shared libraries: $PROJECT_OPENSSL_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL with shared Zlib: $PROJECT_OPENSSL_WITH_SHARED_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL with Zlib: $PROJECT_OPENSSL_WITH_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL without apps: $PROJECT_OPENSSL_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL without installing all artifacts: $PROJECT_OPENSSL_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL without installing files: $PROJECT_OPENSSL_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL without installing headers: $PROJECT_OPENSSL_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: OpenSSL without installing libraries: $PROJECT_OPENSSL_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho with OpenSSL: $PROJECT_PAHO_WITH_OPENSSL"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho with shared libraries: $PROJECT_PAHO_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho without installing all artifacts: $PROJECT_PAHO_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho without installing files: $PROJECT_PAHO_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho without installing headers: $PROJECT_PAHO_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho without installing libraries: $PROJECT_PAHO_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Eclipse Paho without test apps: $PROJECT_PAHO_WITHOUT_TEST_APPS"
echo "[$SYSTEM_PLATFORM] Component information: PCRE with shared libraries: $PROJECT_PCRE_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: PCRE without apps: $PROJECT_PCRE_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: PCRE without installing all artifacts: $PROJECT_PCRE_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: PCRE without installing files: $PROJECT_PCRE_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: PCRE without installing headers: $PROJECT_PCRE_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: PCRE without installing libraries: $PROJECT_PCRE_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: PCRE without test apps: $PROJECT_PCRE_WITHOUT_TEST_APPS"
echo "[$SYSTEM_PLATFORM] Component information: POCO with shared libraries: $PROJECT_POCO_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: POCO with shared Zlib: $PROJECT_POCO_WITH_SHARED_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: POCO without apps: $PROJECT_POCO_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: POCO without installing all artifacts: $PROJECT_POCO_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: POCO without installing files: $PROJECT_POCO_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: POCO without installing headers: $PROJECT_POCO_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: POCO without installing libraries: $PROJECT_POCO_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer with shared libraries: $PROJECT_PROTOBUF_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer with shared Zlib: $PROJECT_PROTOBUF_WITH_SHARED_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer with Zlib: $PROJECT_PROTOBUF_WITH_ZLIB"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer without installing all artifacts: $PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer without installing files: $PROJECT_PROTOBUF_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer without installing headers: $PROJECT_PROTOBUF_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer without installing libraries: $PROJECT_PROTOBUF_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Protocol Buffer without test apps: $PROJECT_PROTOBUF_WITHOUT_TEST_APPS"
echo "[$SYSTEM_PLATFORM] Component information: SQLite with shared libraries: $PROJECT_SQLITE_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without apps: $PROJECT_SQLITE_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing all artifacts: $PROJECT_SQLITE_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing files: $PROJECT_SQLITE_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing headers: $PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing libraries: $PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Zlib without installing all artifacts: $PROJECT_ZLIB_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: Zlib without installing files: $PROJECT_ZLIB_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: Zlib without installing headers: $PROJECT_ZLIB_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: Zlib without installing libraries: $PROJECT_ZLIB_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: Zlib without test apps: $PROJECT_ZLIB_WITHOUT_TEST_APPS"



## Detect source folder
echo "[$SYSTEM_PLATFORM] Detecting $SOURCE_DIR folder ..."
if [ ! -d $SOURCE_DIR ] ; then
    echo "[$SYSTEM_PLATFORM] Detecting $SOURCE_DIR folder ... NOT FOUND"
    exit 1
fi
echo "[$SYSTEM_PLATFORM] Detecting $SOURCE_DIR folder ... FOUND"



## Create or clean temp folder
if [ ! "ON" = "$PROJECT_SHOULD_DISABLE_CLEAN_BUILD" ]; then
    echo "[$SYSTEM_PLATFORM] Cleaning $TEMP_ROOT_DIR folder ..."
    if [ -d $TEMP_ROOT_DIR ] ; then
        echo "[$SYSTEM_PLATFORM] Removing $TEMP_ROOT_DIR folder ..."
        rm -rf $TEMP_ROOT_DIR 1>/dev/null 2>&1
        MY_CHECK_RESULT=$?
        if [ $MY_CHECK_RESULT -ne 0 ] ; then
            echo "[$SYSTEM_PLATFORM] Remove $TEMP_ROOT_DIR folder ... FAILED"
            exit 1
        fi
    fi
    echo "[$SYSTEM_PLATFORM] Cleaning $TEMP_ROOT_DIR folder ... DONE"
fi
if [ ! -d $TEMP_BUILD_DIR ] ; then
    echo "[$SYSTEM_PLATFORM] Creating $TEMP_BUILD_DIR folder ..."
    mkdir -p $TEMP_BUILD_DIR 1>/dev/null 2>&1
    MY_CHECK_RESULT=$?
    if [ $MY_CHECK_RESULT -ne 0 ] ; then
        echo "[$SYSTEM_PLATFORM] Creating $TEMP_BUILD_DIR folder ... FAILED"
        exit 1
    fi
    echo "[$SYSTEM_PLATFORM] Creating $TEMP_BUILD_DIR folder ... DONE"
fi
if [ ! -d $TEMP_INSTALL_DIR ] ; then
    echo "[$SYSTEM_PLATFORM] Creating $TEMP_INSTALL_DIR folder ..."
    mkdir -p $TEMP_INSTALL_DIR 1>/dev/null 2>&1
    MY_CHECK_RESULT=$?
    if [ $MY_CHECK_RESULT -ne 0 ] ; then
        echo "[$SYSTEM_PLATFORM] Creating $TEMP_INSTALL_DIR folder ... FAILED"
        exit 1
    fi
    echo "[$SYSTEM_PLATFORM] Creating $TEMP_INSTALL_DIR folder ... DONE"
fi



## Detect CMake
echo "[$SYSTEM_PLATFORM] Detecting CMake ..."
$CMAKE_CLI --help 1>/dev/null 2>&1
MY_CHECK_RESULT=$?
if [ $MY_CHECK_RESULT -ne 0 ] ; then
    echo "[$SYSTEM_PLATFORM] Detecting CMake ... NOT FOUND"
    exit 1
fi
echo "[$SYSTEM_PLATFORM] Detecting CMake ... FOUND"



for MY_GCC_ARCH in ${MY_GCC_ARCH_LIST[*]} ; do
    ## Build project for architecture $MY_GCC_ARCH / $MY_GCC_ABI
    echo "[$SYSTEM_PLATFORM] Detecting C Compiler for $MY_GCC_ARCH ..."
    MY_GCC_ABI="${GCC_ARCH_TO_ABI_MAP[$MY_GCC_ARCH]}"

    if [ "${MY_GCC_ARCH_BUILD_TOGGLE_MAP[$MY_GCC_ARCH]}" = "OFF" ] ; then
        echo "[$SYSTEM_PLATFORM] Detecting C Compiler for $MY_GCC_ARCH ... SKIPPED"
    else
        # Define GCC CLI path
        MY_GCC_LIB_BASE_PATH=/usr/lib/$MY_GCC_ARCH-$PROJECT_GCC_OS_NAME-$MY_GCC_ABI
        MY_GCC_AR_CLI=/usr/bin/$MY_GCC_ARCH-$PROJECT_GCC_OS_NAME-$MY_GCC_ABI-$PROJECT_GCC_AR_NAME
        MY_GCC_C_COMPILER_CLI=/usr/bin/$MY_GCC_ARCH-$PROJECT_GCC_OS_NAME-$MY_GCC_ABI-$PROJECT_GCC_C_COMPILER_NAME
        MY_GCC_CXX_COMPILER_CLI=/usr/bin/$MY_GCC_ARCH-$PROJECT_GCC_OS_NAME-$MY_GCC_ABI-$PROJECT_GCC_CXX_COMPILER_NAME
        MY_GCC_LD_CLI=/usr/bin/$MY_GCC_ARCH-$PROJECT_GCC_OS_NAME-$MY_GCC_ABI-$PROJECT_GCC_LD_NAME

        # Detect C Compiler
        $MY_GCC_C_COMPILER_CLI --help 1>/dev/null 2>&1
        MY_CHECK_RESULT=$?
        if [ $MY_CHECK_RESULT -ne 0 ] ; then
            echo "[$SYSTEM_PLATFORM] Detecting C Compiler for $MY_GCC_ARCH ... NOT FOUND"
            exit 1
        fi
        echo "[$SYSTEM_PLATFORM] Detecting C Compiler for $MY_GCC_ARCH ... FOUND"

        # Detect CXX Compiler
        echo "[$SYSTEM_PLATFORM] Detecting CXX Compiler for $MY_GCC_ARCH ..."
        $MY_GCC_CXX_COMPILER_CLI --help 1>/dev/null 2>&1
        MY_CHECK_RESULT=$?
        if [ $MY_CHECK_RESULT -ne 0 ] ; then
            echo "[$SYSTEM_PLATFORM] Detecting CXX Compiler for $MY_GCC_ARCH ... NOT FOUND"
            exit 1
        fi
        echo "[$SYSTEM_PLATFORM] Detecting CXX Compiler for $MY_GCC_ARCH ... FOUND"

        # Define build / install path
        MY_TEMP_BUILD_DIR=$TEMP_BUILD_DIR/$PROJECT_RELEASE_TYPE/$MY_GCC_ARCH
        mkdir -p $MY_TEMP_BUILD_DIR
        MY_TEMP_INSTALL_DIR=$TEMP_INSTALL_DIR/$PROJECT_RELEASE_TYPE/$MY_GCC_ARCH
        mkdir -p $MY_TEMP_INSTALL_DIR
        MY_TEMP_INSTALL_DIR_ABS=$(cd -- "$(${DIRNAME_CLI} "${MY_TEMP_INSTALL_DIR}/.dummy")" &> /dev/null && ${PWD_CLI})

        # Generate project
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ..."
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Generating project ..."
        MY_CMAKE_ARGUMENT_LIST=(
                "-B $MY_TEMP_BUILD_DIR"
                "--install-prefix $MY_TEMP_INSTALL_DIR_ABS"
                "-DCMAKE_AR=$MY_GCC_AR_CLI"
                "-DCMAKE_C_COMPILER=$MY_GCC_C_COMPILER_CLI"
                "-DCMAKE_CXX_COMPILER=$MY_GCC_CXX_COMPILER_CLI"
                "-DCMAKE_LINKER=$MY_GCC_LD_CLI"
                "-DCMAKE_SYSTEM_PROCESSOR=$MY_GCC_ARCH"
                "-DMY_LIB_BASE_PATH=$MY_GCC_LIB_BASE_PATH"
        )
        MY_CMAKE_ARGUMENT_LIST=(${MY_CMAKE_COMMON_ARGUMENT_LIST[@]} ${MY_CMAKE_ARGUMENT_LIST[@]})
        MY_CMAKE_ARGUMENT_LIST_STRING=$(IFS=' ' eval 'echo "${MY_CMAKE_ARGUMENT_LIST[*]}"')
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Generating project ... argument list:" $MY_CMAKE_ARGUMENT_LIST_STRING
        $CMAKE_CLI $MY_CMAKE_ARGUMENT_LIST_STRING
        MY_CHECK_RESULT=$?
        if [ $MY_CHECK_RESULT -ne 0 ] ; then
            echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Generating project ... FAILED (ExitCode: $MY_CHECK_RESULT)"
            exit 1
        fi
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Generating project ... DONE"

        # Compile project
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Compiling project ..."
        MY_CMAKE_PARA_PARALLEL="--parallel"
        if [ "ON" = "$PROJECT_SHOULD_DISABLE_PARALLEL_BUILD" ]; then
            MY_CMAKE_PARA_PARALLEL=""
        fi
        $CMAKE_CLI --build $MY_TEMP_BUILD_DIR --config $PROJECT_RELEASE_TYPE $MY_CMAKE_PARA_PARALLEL
        MY_CHECK_RESULT=$?
        if [ $MY_CHECK_RESULT -ne 0 ] ; then
            echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Compiling project ... FAILED (ExitCode: $MY_CHECK_RESULT)"
            exit 1
        fi
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Compiling project ... DONE"

        # Install project
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Installing project ..."
        $CMAKE_CLI --install $MY_TEMP_BUILD_DIR --config $PROJECT_RELEASE_TYPE
        MY_CHECK_RESULT=$?
        if [ $MY_CHECK_RESULT -ne 0 ] ; then
            echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Installing project ... FAILED (ExitCode: $MY_CHECK_RESULT)"
            exit 1
        fi
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... Installing project ... DONE"
        echo "[$SYSTEM_PLATFORM] Building project for platform $MY_GCC_ARCH ... DONE"
    fi
done
