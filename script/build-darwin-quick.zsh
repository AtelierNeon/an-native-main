#!/usr/bin/env zsh

##
## Global config
##
DIRNAME_CLI=/usr/bin/dirname
PWD_CLI=/bin/pwd
UNAME_CLI=/usr/bin/uname
SYSTEM_PLATFORM=$($UNAME_CLI)

echo "[$SYSTEM_PLATFORM] Running quick (re)build ..."
MY_PROJECT_SHOULD_DISABLE_CLEAN_BUILD=ON
MY_PROJECT_WITH_COMPILER_CACHE=ON

SCRIPT_DIR=$(cd -- "$(${DIRNAME_CLI} "${BASH_SOURCE[0]:-${(%):-%x}}")" &> /dev/null && ${PWD_CLI})
source $SCRIPT_DIR/build-darwin-preset.zsh
