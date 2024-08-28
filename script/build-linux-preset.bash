#!/usr/bin/env bash

##
## Global config
##
DIRNAME_CLI=/usr/bin/dirname
PWD_CLI=/bin/pwd
UNAME_CLI=/bin/uname
SYSTEM_PLATFORM=$($UNAME_CLI)

echo "[$SYSTEM_PLATFORM] Applying preset options ..."
MY_PROJECT_EXPAT_WITHOUT_APPS=ON
MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL=ON
MY_PROJECT_EXPAT_WITHOUT_TEST_APPS=ON
echo "[$SYSTEM_PLATFORM] Applying default options ... DONE"

SCRIPT_DIR=$(cd -- "$(${DIRNAME_CLI} "${BASH_SOURCE[0]:-${(%):-%x}}")" &> /dev/null && ${PWD_CLI})
source $SCRIPT_DIR/build-linux.bash
