@echo off

setlocal

call "%%~dp0__init__\__init__.bat" || exit /b

"%CALLF_EXE_PATH%" /shell-exec runas /no-sys-dialog-ui "${COMSPEC}" "/k"

pause
