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
PROJECT_EXPAT_WITH_SHARED_LIBRARIES="${MY_PROJECT_EXPAT_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_EXPAT_WITHOUT_APPS="${MY_PROJECT_EXPAT_WITHOUT_APPS:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_ALL="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_FILES="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES:=OFF}"
PROJECT_EXPAT_WITHOUT_TEST_APPS="${MY_PROJECT_EXPAT_WITHOUT_TEST_APPS:=OFF}"
PROJECT_SQLITE_WITH_SHARED_LIBRARIES="${MY_PROJECT_SQLITE_WITH_SHARED_LIBRARIES:=OFF}"
PROJECT_SQLITE_WITHOUT_APPS="${MY_PROJECT_SQLITE_WITHOUT_APPS:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_ALL="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_ALL:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_FILES="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_FILES:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS:=OFF}"
PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES="${MY_PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES:=OFF}"

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
echo "[$SYSTEM_PLATFORM] Project information: Disable clean build: $PROJECT_SHOULD_DISABLE_CLEAN_BUILD"
echo "[$SYSTEM_PLATFORM] Project information: Disable parallel build: $PROJECT_SHOULD_DISABLE_PARALLEL_BUILD"
echo "[$SYSTEM_PLATFORM] Component information: expat with shared libraries: $PROJECT_EXPAT_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: expat without apps: $PROJECT_EXPAT_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing all artifacts: $PROJECT_EXPAT_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing files: $PROJECT_EXPAT_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing headers: $PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: expat without installing libraries: $PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: expat without test apps: $PROJECT_EXPAT_WITHOUT_TEST_APPS"
echo "[$SYSTEM_PLATFORM] Component information: SQLite with shared libraries: $PROJECT_SQLITE_WITH_SHARED_LIBRARIES"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without apps: $PROJECT_SQLITE_WITHOUT_APPS"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing all artifacts: $PROJECT_SQLITE_WITHOUT_INSTALL_ALL"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing files: $PROJECT_SQLITE_WITHOUT_INSTALL_FILES"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing headers: $PROJECT_SQLITE_WITHOUT_INSTALL_HEADERS"
echo "[$SYSTEM_PLATFORM] Component information: SQLite without installing libraries: $PROJECT_SQLITE_WITHOUT_INSTALL_LIBRARIES"



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
