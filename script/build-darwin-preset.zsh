#!/usr/bin/env zsh

##
## Global config
##
DIRNAME_CLI=/usr/bin/dirname
PWD_CLI=/bin/pwd
UNAME_CLI=/usr/bin/uname
SYSTEM_PLATFORM=$($UNAME_CLI)

echo "[$SYSTEM_PLATFORM] Applying preset options ..."
MY_PROJECT_BOOST_WITHOUT_APPS=ON
MY_PROJECT_BOOST_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_CARES_WITHOUT_APPS=ON
MY_PROJECT_CARES_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_CARES_WITHOUT_TEST_APPS=ON
MY_PROJECT_CJSON_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_CJSON_WITHOUT_TEST_APPS=ON
MY_PROJECT_CURL_WITH_OPENSSL=ON
MY_PROJECT_CURL_WITH_ZLIB=ON
MY_PROJECT_CURL_WITHOUT_APPS=ON
MY_PROJECT_CURL_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_EXPAT_WITHOUT_APPS=ON
MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_EXPAT_WITHOUT_TEST_APPS=ON
MY_PROJECT_NETSNMP_WITH_IPV6=ON
MY_PROJECT_NETSNMP_WITH_SSL=ON
MY_PROJECT_NETSNMP_WITHOUT_APPS=ON
MY_PROJECT_NETSNMP_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_NETSNMP_WITHOUT_MIB_LOADING=ON
MY_PROJECT_OPENSSL_WITH_DEPRECATED_CIPHERS=OFF
MY_PROJECT_OPENSSL_WITH_SHARED_LIBRARIES=OFF
MY_PROJECT_OPENSSL_WITH_ZLIB=ON
MY_PROJECT_OPENSSL_WITHOUT_APPS=ON
MY_PROJECT_OPENSSL_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_PAHO_WITH_OPENSSL=ON
MY_PROJECT_PAHO_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_PAHO_WITHOUT_TEST_APPS=ON
MY_PROJECT_PCRE_WITHOUT_APPS=ON
MY_PROJECT_PCRE_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_PCRE_WITHOUT_TEST_APPS=ON
MY_PROJECT_POCO_WITHOUT_APPS=ON
MY_PROJECT_POCO_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_PROTOBUF_WITH_ZLIB=ON
MY_PROJECT_PROTOBUF_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_PROTOBUF_WITHOUT_TEST_APPS=ON
MY_PROJECT_SQLITE_WITHOUT_APPS=ON
MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_ZLIB_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_ZLIB_WITHOUT_TEST_APPS=ON
echo "[$SYSTEM_PLATFORM] Applying default options ... DONE"

SCRIPT_DIR=$(cd -- "$(${DIRNAME_CLI} "${BASH_SOURCE[0]:-${(%):-%x}}")" &> /dev/null && ${PWD_CLI})
source $SCRIPT_DIR/build-darwin.zsh
