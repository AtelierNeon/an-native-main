# CMake Builder project for Git submodules

To make sure every Git submodule can be built pass by CMake.

> [!important]
> This project uses external Git submodules as project dependencies.
> You must clone this project with `--recursive` parameter to get full source tree.

## How to Build

All build script is under script directory. You can run build script in project root for these platform:

- Run `.\script\build-windows-clean.cmd` for Windows.
- Run `./script/build-linux-clean.bash` for Linux.
- Run `./script/build-darwin-clean.zsh` for macOS.

The build script will tell you what dependencies are missing when building. The known prerequisites are latest [CMake](https://cmake.org/) and the platform C/C++ compiler.
