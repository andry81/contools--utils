@echo off

setlocal

call "%%~dp0__init__\__init__.bat" || exit /b

set "LOG_FILE_NAME=%~n0.log"

set "LOG_FILE_PATH=%TEST_DATA_OUT_DIR%/%LOG_FILE_NAME%"

type nul > "%LOG_FILE_PATH%"

"%CALLF_EXE_PATH%" /reopen-stdin "%TEST_CALLF_REF_INPUT_FILE_0%" /tee-stdout "%LOG_FILE_PATH%" /tee-stderr-dup 1 "" "cmd.exe /k"

pause
