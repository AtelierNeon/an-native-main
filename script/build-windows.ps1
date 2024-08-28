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
$ProjectWithSharedVcrt = if ($Env:MY_PROJECT_WITH_SHARED_VCRT) {$Env:MY_PROJECT_WITH_SHARED_VCRT} else {'OFF'}
$ProjectWithStaticVcrt = if ($Env:MY_PROJECT_WITH_STATIC_VCRT) {$Env:MY_PROJECT_WITH_STATIC_VCRT} else {'ON'}
$ProjectWithWorkaroundArm64rt = if ($Env:MY_PROJECT_WITH_WORKAROUND_ARM64RT) {$Env:MY_PROJECT_WITH_WORKAROUND_ARM64RT} else {'OFF'}
$ProjectWithWorkaroundOptGy = if ($Env:MY_PROJECT_WITH_WORKAROUND_OPT_GY) {$Env:MY_PROJECT_WITH_WORKAROUND_OPT_GY} else {'OFF'}
$ProjectWithWorkaroundSpectre = if ($Env:MY_PROJECT_WITH_WORKAROUND_SPECTRE) {$Env:MY_PROJECT_WITH_WORKAROUND_SPECTRE} else {'OFF'}
####
#### Project component level config
####
$ProjectExpatWithSharedLibraries = if ($Env:MY_PROJECT_EXPAT_WITH_SHARED_LIBRARIES) {$Env:MY_PROJECT_EXPAT_WITH_SHARED_LIBRARIES} else {'OFF'}
$ProjectExpatWithoutApps = if ($Env:MY_PROJECT_EXPAT_WITHOUT_APPS) {$Env:MY_PROJECT_EXPAT_WITHOUT_APPS} else {'OFF'}
$ProjectExpatWithoutInstallAll = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_ALL} else {'OFF'}
$ProjectExpatWithoutInstallFiles = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_FILES) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_FILES} else {'OFF'}
$ProjectExpatWithoutInstallHeaders = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_HEADERS} else {'OFF'}
$ProjectExpatWithoutInstallLibraries = if ($Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES) {$Env:MY_PROJECT_EXPAT_WITHOUT_INSTALL_LIBRARIES} else {'OFF'}
$ProjectExpatWithoutTestApps = if ($Env:MY_PROJECT_EXPAT_WITHOUT_TEST_APPS) {$Env:MY_PROJECT_EXPAT_WITHOUT_TEST_APPS} else {'OFF'}

##
## My variables
##
$MyCmakeCommonArgumentList = @(
        "-S $SourceFolder",
        "-T $ProjectToolset",
        "-DMY_REVISION=$ProjectRevision"
)
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



## Print build information
Write-Information "[PowerShell] Project information: version: `"$MyProjectVersion`""
Write-Information "[PowerShell] Project information: revision: `"$ProjectRevision`""
Write-Information "[PowerShell] Project information: release type: `"$ProjectReleaseType`""
Write-Information "[PowerShell] Project information: Disable clean build: $ProjectShouldDisableCleanBuild"
Write-Information "[PowerShell] Project information: Disable parallel build: $ProjectShouldDisableParallelBuild"
Write-Information "[PowerShell] Project information: CMake generator: `"$MyCmakeGenerator`""
Write-Information "[PowerShell] Project information: CMake toolset: `"$ProjectToolset`""
Write-Information "[PowerShell] Project information: CMake platform to build: $MyCmakePlatformToBuildListString"
Write-Information "[PowerShell] Component information: expat with shared libraries: $ProjectExpatWithSharedLibraries"
Write-Information "[PowerShell] Component information: expat without apps: $ProjectExpatWithoutApps"
Write-Information "[PowerShell] Component information: expat without installing all artifacts: $ProjectExpatWithoutInstallAll"
Write-Information "[PowerShell] Component information: expat without installing files: $ProjectExpatWithoutInstallFiles"
Write-Information "[PowerShell] Component information: expat without installing headers: $ProjectExpatWithoutInstallHeaders"
Write-Information "[PowerShell] Component information: expat without installing libraries: $ProjectExpatWithoutInstallLibraries"
Write-Information "[PowerShell] Component information: expat without test apps: $ProjectExpatWithoutTestApps"



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



## Build project
Write-Information "[PowerShell] Building project ..."
foreach ($MyCmakePlatform in $MyCmakePlatformList) {
    ## Build project for platform $MyCmakePlatform
    Write-Information "[PowerShell] Building project for platform $MyCmakePlatform ..."
    if (-not ('ON'.Equals($MyCmakePlatformToBuildToggleMap[$MyCmakePlatform]))) {
        Write-Information "[PowerShell] Building project for platform $MyCmakePlatform ... SKIPPED"
    } else {
        $MyTempBuildFolder = Join-Path -Path $TempBuildFolder -ChildPath $ProjectReleaseType
        $MyTempBuildFolder = Join-Path -Path $MyTempBuildFolder -ChildPath $MyCmakePlatform
        $MyTempInstallFolderAbs = Resolve-Path $TempInstallFolder
        $MyTempInstallFolderAbs = Join-Path -Path $MyTempInstallFolderAbs -ChildPath $ProjectReleaseType
        $MyTempInstallFolderAbs = Join-Path -Path $MyTempInstallFolderAbs -ChildPath $MyCmakePlatform

        ## Build project for platform $MyCmakePlatform - Generate project
        $MyCmakeProcess = $null
        $MyCmakeProcessHandle = $null
        Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Generating project ..."
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
            Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Generating project ... argument list: $MyCmakeArgumentListString"
            $MyCmakeProcess = Start-Process -FilePath "$CmakeCli" -NoNewWindow -PassThru `
                    -ArgumentList $MyCmakeArgumentListString
            $MyCmakeProcessHandle = $MyCmakeProcess.Handle
            $MyCmakeProcess.WaitForExit()
            $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
            if ($MyCmakeProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Building project for platform $MyCmakePlatform ... Generating project ... FAILED (ExitCode: $MyCmakeProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Error "[PowerShell] Building project for platform $MyCmakePlatform ... Generating project ... FAILED (CMake is missing)"
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
        Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Generating project ... DONE"

        ## Build project for platform $MyCmakePlatform - Compile project
        $MyCmakeProcess = $null
        $MyCmakeProcessHandle = $null
        Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Compiling project ..."
        try {
            $MyCmakeParaParallel = '--parallel'
            if ('ON'.Equals($ProjectShouldDisableParallelBuild)) {
                $MyCmakeParaParallel = ''
            }
            $MyCmakeProcess = Start-Process -FilePath "${Env:ProgramFiles}\CMake\bin\$CmakeCli" -NoNewWindow -PassThru `
                    -ArgumentList "--build $MyTempBuildFolder --config $ProjectReleaseType $MyCmakeParaParallel"
            $MyCmakeProcessHandle = $MyCmakeProcess.Handle
            $MyCmakeProcess.WaitForExit()
            $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
            if ($MyCmakeProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Building project for platform $MyCmakePlatform ... Compiling project ... FAILED (ExitCode: $MyCmakeProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Error "[PowerShell] Building project for platform $MyCmakePlatform ... Compiling project ... FAILED (CMake is missing)"
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
        Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Compiling project ... DONE"

        ## Build project for platform $MyCmakePlatform - Install project
        $MyCmakeProcess = $null
        $MyCmakeProcessHandle = $null
        Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Installing project ..."
        try {
            $MyCmakeProcess = Start-Process -FilePath "${Env:ProgramFiles}\CMake\bin\$CmakeCli" -NoNewWindow -PassThru `
                    -ArgumentList "--install $MyTempBuildFolder --config $ProjectReleaseType"
            $MyCmakeProcessHandle = $MyCmakeProcess.Handle
            $MyCmakeProcess.WaitForExit()
            $MyCmakeProcessExitCode = $MyCmakeProcess.ExitCode
            if ($MyCmakeProcessExitCode -ne 0) {
                Write-Error "[PowerShell] Building project for platform $MyCmakePlatform ... Installing project ... FAILED (ExitCode: $MyCmakeProcessExitCode)"
                Exit 1
            }
        } catch {
            Write-Error "[PowerShell] Building project for platform $MyCmakePlatform ... Installing project ... FAILED (CMake is missing)"
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
        Write-Verbose "[PowerShell] Building project for platform $MyCmakePlatform ... Installing project ... DONE"

        Write-Information "[PowerShell] Building project for platform $MyCmakePlatform ... DONE"
    }
}
Write-Information "[PowerShell] Building project ... DONE"
