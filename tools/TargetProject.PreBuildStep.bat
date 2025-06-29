@echo off

setlocal

call "%%~dp0__init__\__init__.bat" || exit /b

set "PROJECT_NAME=%~1"
set "SOURCES_DIR=%~2"
set "UNICODE_ENABLED=%~3"

if not defined UNICODE_ENABLED set UNICODE_ENABLED=0

set "AUTOGEN_BARE_FLAGS="

if not defined AUTOGEN_DEFINITIONS goto AUTOGEN_DEFINITIONS_END

set AUTOGEN_DEF_INDEX=1

:AUTOGEN_DEFINITIONS_LOOP
set "AUTOGEN_DEF_VALUE="
for /F "tokens=%AUTOGEN_DEF_INDEX% delims=;"eol^= %%i in ("%AUTOGEN_DEFINITIONS%") do set "AUTOGEN_DEF_VALUE=%%i"

if not defined AUTOGEN_DEF_VALUE goto AUTOGEN_DEFINITIONS_END

set AUTOGEN_BARE_FLAGS=%AUTOGEN_BARE_FLAGS% -D %AUTOGEN_DEF_VALUE%
set /A AUTOGEN_DEF_INDEX+=1

goto AUTOGEN_DEFINITIONS_LOOP

:AUTOGEN_DEFINITIONS_END

if not defined APP_MODULE_NAME set "APP_MODULE_NAME=%PROJECT_NAME%"

call "%%CONTOOLS_BUILD_TOOLS_ROOT%%/mkdir_if_notexist.bat" "%%SOURCES_DIR%%\gen" >nul || exit /b 255

pushd "%SOURCES_DIR%\gen" && (
  if exist "%SOURCES_DIR%\help.def" (
    call "%%CONTOOLS_BUILD_TOOLS_ROOT%%/call.bat" "%%CONTOOLS_UTILS_AUTOGEN_ROOT%%\bin\autogen.exe"%%AUTOGEN_BARE_FLAGS%% -L "%%SOURCES_DIR%%" "%%SOURCES_DIR:\=/%%/help.def" || exit /b 255
  )
  call "%%CONTOOLS_BUILD_TOOLS_ROOT%%/call.bat" "%%CONTOOLS_UTILS_AUTOGEN_ROOT%%\bin\autogen.exe"%%AUTOGEN_BARE_FLAGS%% -L "%%SOURCES_DIR%%" "%%SOURCES_DIR:\=/%%/version.def" || exit /b 255
  popd
) || exit /b 255

set "THLIBAUTOCFG_BARE_FLAGS= -txt2c"
if %UNICODE_ENABLED% NEQ 0 set THLIBAUTOCFG_BARE_FLAGS=%THLIBAUTOCFG_BARE_FLAGS% -u

if exist "%SOURCES_DIR%\gen\help.txt" (
  call "%%CONTOOLS_BUILD_TOOLS_ROOT%%/mkdir_if_notexist.bat" "%%SOURCES_DIR%%\gen\help" >nul || exit /b 255
  pushd "%SOURCES_DIR%\gen" && (
    call "%%CONTOOLS_BUILD_TOOLS_ROOT%%/call.bat" "%%CONTOOLS_UTILS_BIN_ROOT%%/contools/thlibautocfg.exe"%%THLIBAUTOCFG_BARE_FLAGS%% -h "help/{N}.hpp" -m "INCLUDE_HELP_INL_EPILOG({N})\n#include """help/{N}.hpp"""\nINCLUDE_HELP_INL_PROLOG({N})" "%%SOURCES_DIR%%\gen\help.txt" "%%SOURCES_DIR%%\gen\help_inl.hpp" || exit /b 255
    popd
  ) || exit /b 255
)

exit /b 0
