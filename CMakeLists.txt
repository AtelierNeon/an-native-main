cmake_minimum_required (VERSION 3.1...3.15.0)

## Special CMake policies
if (POLICY CMP0091 AND NOT CMAKE_VERSION VERSION_LESS 3.15)
    cmake_policy (SET CMP0091 NEW)
endif ()

## Dummy basic information for main project
project (main)

message (STATUS "Main project revision: ${MY_REVISION}")
message (STATUS "Main project build type: ${CMAKE_BUILD_TYPE}")

## Project options
option (BUILD_WITH_COMPILER_CACHE "Build project with compiler cache." OFF)
option (BUILD_WITH_COMPILER_PRECHECK "Build project with compiler precheck." OFF)
option (BUILD_WITH_SHARED_VCRT "Build project with shared vc runtime library." OFF)
option (BUILD_WITH_STATIC_VCRT "Build project without shared vc runtime library." OFF)
option (BUILD_WITH_WORKAROUND_ARM64RT "Build project with workaround arm64rt.lib library" OFF)
option (BUILD_WITH_WORKAROUND_OPT_GY "Build project with workaround /Gy compiler option" OFF)
option (BUILD_WITH_WORKAROUND_SOFTINTRIN "Build project with workaround softintrin.lib library" OFF)
option (BUILD_WITH_WORKAROUND_SPECTRE "Build project with workaround spectre mitigation library" OFF)

## Append custom CMake module path
list (APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/source/cmake-modules/")

## Import custom CMake modules
if (BUILD_WITH_COMPILER_CACHE)
    include (UseMyCompilerCache)
endif ()
if (WIN32)
    include (MSVC-MyRuntimeConfig)
endif ()

## Process sub-components
# External dependencies: none
add_subdirectory (source/boost)
add_subdirectory (source/c-ares)
add_subdirectory (source/cjson)
add_subdirectory (source/expat)
add_subdirectory (source/nghttp2)
if (WIN32)
    add_subdirectory (source/pthreads4w)
endif ()
add_subdirectory (source/sqlite)
add_subdirectory (source/zlib)
# External dependencies: zlib
add_subdirectory (source/openssl)
add_subdirectory (source/pcre)
add_subdirectory (source/protobuf/cmake)
# External dependencies: openssl
add_subdirectory (source/libwebsockets)
add_subdirectory (source/paho-mqtt-c)
# External dependencies: openssl, zlib
add_subdirectory (source/libssh2)
# External dependencies: libssh2, openssl
add_subdirectory (source/net-snmp)
# External dependencies: c-ares, libssh2, nghttp2, openssl, zlib
add_subdirectory (source/curl)
# External dependencies: openssl, pcre, sqlite, zlib
add_subdirectory (source/poco)
