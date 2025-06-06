* README_EN.txt
* 2025.05.30
* contools--utils

1. DESCRIPTION
2. LICENSE
3. REPOSITORIES
4. CATALOG CONTENT DESCRIPTION
5. PREREQUISITES
6. DEPENDENCIES
7. EXTERNALS
8. FEATURES
8.1. callf
8.2. clearcache
9. KNOWN ISSUES

9.1. With `cmd.exe`
9.1.1. The `cmd.exe /c 1.bat` always returns 0 exit code even if `1.bat` script
       is not.
9.1.2. Interactive input autocompletion disable.
9.1.3. The `set /p DUMMY=` cmd.exe command ignores the input after the `callf`
       call (Windows XP/7).
9.1.4. The `type con | callf "" "cmd.exe /k"` command makes `cmd.exe` left
       behind waiting the last input while the neighbor `callf.exe` process is
       already exited.
9.1.5. The `start "" /WAIT /B cmd.exe /k` does not wait a child process.
9.1.6. The `callf "" "cmd.exe /c callf \"\" \"cmd.exe /k\""` command losing
       arrows key interactive input (command history traverse).

9.2. With `callf.exe`/`callfg.exe`
9.2.1. Console output in particular case prints as untranslated (line feed and
       return characters become printable)
9.2.2. The `callf /pipe-inout-child "" "cmd.exe /k"` command is blocked on
       input while a child process is terminated externally.
9.2.3. The `callf /tee-stdin 0.log /pipe-child-stdout-to-stdout "" "cmd.exe /k"`
       command is blocked on input while a child process is terminated
       externally.

9.3. With `callf.exe`/`callfg.exe` under VirtualBox
9.3.1. The `callf /elevate ...` shows system dialog
       `The specified path does not exist.`.
9.3.2. The `callf.exe` execuable can not be removed if has been run at least
       once as `callf /elevate ...`.

9.4. With `bash.exe`
9.4.1. The GNU Bash shell executable throws an error:
       `select_stuff::wait: WaitForMultipleObjects failed, Win32 error 6`.

10. AUTHOR

-------------------------------------------------------------------------------
1. DESCRIPTION
-------------------------------------------------------------------------------
Contools project support utilities.

-------------------------------------------------------------------------------
2. LICENSE
-------------------------------------------------------------------------------
The MIT license (see included text file "license.txt" or
https://en.wikipedia.org/wiki/MIT_License)

-------------------------------------------------------------------------------
3. REPOSITORIES
-------------------------------------------------------------------------------
Primary:
  * https://github.com/andry81/contools--utils/branches
    https://github.com/andry81/contools--utils.git
First mirror:
  * https://sf.net/p/contools/contools--utils/ci/master/tree
    https://git.code.sf.net/p/contools/contools--utils
Second mirror:
  * https://gitlab.com/andry81/contools-utils/-/branches
    https://gitlab.com/andry81/contools-utils.git

-------------------------------------------------------------------------------
4. CATALOG CONTENT DESCRIPTION
-------------------------------------------------------------------------------

<root>
 |
 +- /`.log`
 |    #
 |    # Log files directory, where does store all log files from all scripts
 |    # including all nested projects.
 |
 +- /`_externals`
 |    #
 |    # Immediate external repositories catalog.
 |
 +- /`_config`
 |  | #
 |  | # Directory with input configuration files.
 |  |
 |  +- `config.system.vars.in`
 |      #
 |      # Template file with system set of environment variables
 |      # designed to be stored in a version control system.
 |
 +- /`bin`
 |    #
 |    # Project binaries.
 |
 +- /`proj`
 |    #
 |    # Project files to build contools utilities.
 |
 +- /`_out`
 |    #
 |    # Output directory for all files.
 |
 +- /`src`
      #
      # Source files.

-------------------------------------------------------------------------------
5. PREREQUISITES
-------------------------------------------------------------------------------

Currently used these set of OS platforms, compilers, interpreters, modules,
IDE's, applications and patches to run with or from:

1. OS platforms:

* Windows XP x86 SP3/x64 SP2
* Windows 7+
* Linux Mint 18.3 x64 (`.sh` only)

2. C++11 compilers:

* (primary) Microsoft Visual C++ 2019
* (secondary) GCC 5.4+

3. Interpreters:

* cmake 3.15.1 (3.14+):
  https://cmake.org/download/
  - to run cmake scripts and modules
  - 3.14+ does allow use generator expressions at install phase:
    https://cmake.org/cmake/help/v3.14/policy/CMP0087.html

  Noticeable cmake changes from the version 3.14:

  https://cmake.org/cmake/help/v3.14/release/3.14.html#deprecated-and-removed-features

  * The FindQt module is no longer used by the find_package() command as a find
    module. This allows the Qt Project upstream to optionally provide its own
    QtConfig.cmake package configuration file and have applications use it via
    find_package(Qt) rather than find_package(Qt CONFIG). See policy CMP0084.

  * Support for running CMake on Windows XP and Windows Vista has been dropped.
    The precompiled Windows binaries provided on cmake.org now require
    Windows 7 or higher.

  https://cmake.org/cmake/help/v3.14/release/3.14.html#id13

  * The install(CODE) and install(SCRIPT) commands learned to support generator
    expressions. See policy CMP0087
    (https://cmake.org/cmake/help/v3.14/policy/CMP0087.html):

    In CMake 3.13 and earlier, install(CODE) and install(SCRIPT) did not
    evaluate generator expressions. CMake 3.14 and later will evaluate
    generator expressions for install(CODE) and install(SCRIPT).

4. IDE's.

* Microsoft Visual Studio 2019

5. Patches:

  Target repository with a 3dparty component sources must already contain all
  patches and description with it.

To build GUI utilities is required the wxWidgets library at least of version
3.1.3.

CAUTION:
  You have to build wxwidgets before build GUI utilities.

-------------------------------------------------------------------------------
6. DEPENDENCIES
-------------------------------------------------------------------------------
Any project which is dependent on this project have has to contain the
`README_EN.deps.txt` description file for the common dependencies in the
Windows and in the Linux like platforms.

-------------------------------------------------------------------------------
7. EXTERNALS
-------------------------------------------------------------------------------
See details in `README_EN.txt` in `externals` project:

https://github.com/andry81/externals

-------------------------------------------------------------------------------
8. FEATURES
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
8.1. callf
-------------------------------------------------------------------------------
Create process or Shell execute in style of c-function printf.

Use `callf /?` to print more examples or see the same in the
`src/callf/help.tpl` file.

NOTE:
  Here is described examples not included in the executable help output.

* Command line variadic variables substitution in style of c-function printf
  with the python placeholders.

  Examples:
  >
  callf.exe "" "cmd.exe /c echo;\"{0} {1}\"" "1 2" "3 4"

* Environment variables expansion.

  Examples:
  >
  callf.exe "" "\"${COMSPEC}\" /c echo;\"{0} {1}\"" "1 2" "3 4"

* Execute with elevation.

  ** Use new console.

     Examples:
     >
     callf.exe /shell-exec runas /no-sys-dialog-ui "${COMSPEC}" "/c echo;\"{0} {1}\" & pause" "1 2" "3 4"
     >
     callf.exe /elevate "" "\"${COMSPEC}\" /c echo;\"{0} {1}\" & pause" "1 2" "3 4"
     >
     callfg.exe /elevate /create-console "" "\"${COMSPEC}\" /c echo;\"{0} {1}\" & pause" "1 2" "3 4"

  ** Use existing console.

     Examples:
     >
     callf.exe /shell-exec runas /no-sys-dialog-ui /no-window "callf.exe" "/attach-parent-console \"\" \"\\\"${COMSPEC}\\\" /c \\\"echo;\\\"{0} {1}\\\"\\\"\" \"1 2\" \"3 4\""
     >
     callf.exe /elevate{ /no-window }{ /attach-parent-console } "" "\"${COMSPEC}\" /c echo;\"{0} {1}\"" "1 2" "3 4"
     >
     start "" /WAIT callfg.exe /elevate /attach-parent-console "" "\"${COMSPEC}\" /c echo;\"{0} {1}\"" "1 2" "3 4"

* Backslash escaping.

  Examples:
  >
  callf.exe /e2 "${COMSPEC}" "/c echo;\"{0}\"" "Hello\tWorld!\a"

* Text replacing.

  Examples:
  >
  callf /r2 "{LR}" "\n" "" "printf /e \"Hello{0}World!{0}\"" "{LR}"
  >
  callf /ra "{LR}" "\n" "" "printf /e \"Hello{LR}World!{0}\"" "{LR}"

* Set environment variable.

  Examples:
  >
  callf /v "TEST" "123" "" "cmd.exe /c echo;TEST=${TEST}"
  >
  callf /v "TEST" "123" "" "cmd.exe /c echo;TEST=%TEST%"

* File print.

  Examples:
  >
  callf /reopen-stdin 0.in .

* Wow64 redirection control

  Examples:
  >
  callf /enable-wow64-fs-redir "" "${SystemRoot}\system32\cmd.exe /c set PROCESSOR_ARCHITE"

  ```cmd
  PROCESSOR_ARCHITECTURE=x86
  PROCESSOR_ARCHITEW6432=AMD64
  ```

  >
  callf /disable-wow64-fs-redir "" "${SystemRoot}\system32\cmd.exe /c set PROCESSOR_ARCHITE"

  ```cmd
  PROCESSOR_ARCHITECTURE=AMD64
  ```

* Process input redirection.

  Examples:
  >
  callf.exe /reopen-stdin 0.in "" "cmd.exe /k"
  >
  callf.exe /reopen-stdin 0.in "" "cmd.exe /q /k @echo off"

* Output duplication into a file.

  Examples:
  >
  callf.exe /reopen-stdin 0.in /tee-stdout out.log /tee-stderr-dup 1 "" "cmd.exe /k"

* Simple escaping in recursion (escaping for the `cmd.exe` is different).

  Examples:
  >
  callf.exe "" "\"${COMSPEC}\" /c echo;{0}" "%TIME%"
  >
  callf.exe "" "callf.exe \"\" \"\\\"$\{COMSPEC}\\\" /c echo;{0}\" \"%TIME%\""
  >
  callf.exe "" "callf.exe \"\" \"callf.exe \\\"\\\" \\\"\\\\\\\"$\\{COMSPEC}\\\\\\\" /c echo;{0}\\\" \\\"%TIME%\\\"\""

* Connects a named pipe from stdout to a child process stdin with the same
  privileges.

  Examples:
  >
  callf.exe /reopen-stdin 0.in /reopen-stdout-as-server-pipe test123_{pid} /pipe-stdin-to-stdout "" "callf.exe /reopen-stdin-as-client-pipe test123_{ppid} ."
  >
  callf.exe /reopen-stdin 0.in /reopen-stdout-as-server-pipe test123_{pid} /pipe-stdin-to-stdout "" "callf.exe /reopen-stdin-as-client-pipe test123_{ppid} \"\" \"cmd.exe /k\""

* Connects a named pipe from stdout to a child process stdin with the
  Administrator privileges.

  Examples:
  >
  callf.exe /reopen-stdin 0.in /reopen-stdout-as-server-pipe test123_{pid} /pipe-stdin-to-stdout /shell-exec runas /no-sys-dialog-ui /no-window "callf.exe" "/attach-parent-console /reopen-stdin-as-client-pipe test123_{ppid} ."
  >
  callf.exe /reopen-stdin 0.in /reopen-stdout-as-server-pipe test123_{pid} /pipe-stdin-to-stdout /shell-exec runas /no-sys-dialog-ui /no-window "callf.exe" "/attach-parent-console /reopen-stdin-as-client-pipe test123_{ppid} \"\" \"cmd.exe /k\""

* In case of elevation is executed, connects a named pipe to stdin and from
  stdout of a child process with the Administrator privileges isolation,
  otherwise fallbacks to a generic piping.

  Examples:
  >
  callf /promote-parent{ /reopen-stdin 0.in } /elevate{ /no-window /create-outbound-server-pipe-from-stdin test0_{pid} /create-inbound-server-pipe-to-stdout test1_{pid} }{ /attach-parent-console /reopen-stdin-as-client-pipe test0_{ppid} /reopen-stdout-as-client-pipe test1_{ppid} } .
  >
  callf /promote-parent{ /reopen-stdin 0.in } /elevate{ /no-window /create-outbound-server-pipe-from-stdin test0_{pid} /create-inbound-server-pipe-to-stdout test1_{pid} }{ /attach-parent-console /reopen-stdin-as-client-pipe test0_{ppid} /reopen-stdout-as-client-pipe test1_{ppid} } "" "cmd.exe /k"

* Loads ancestor `callf` process environment variables block to reset all
  variables in between of 2 closest `callf` processes in process inheritence
  chain.

  Examples:
  >
  callf /v XXX 111 "" "callf /load-parent-proc-init-env-vars /v YYY 222 \"\" \"cmd.exe /c set\""
  >
  callf /v XXX 111 "" "callf /load-parent-proc-init-env-vars /v YYY 222 \"\" \"callf /load-parent-proc-init-env-vars /v ZZZ 333 \\\"\\\" \\\"cmd.exe /c set\\\"\""

* Skip pause on detached console.

  Examples:
  >
  start "" /B /WAIT callfg /pause-on-exit /skip-pause-on-detached-console "" "cmd.exe /k"

-------------------------------------------------------------------------------
8.2. clearcache
-------------------------------------------------------------------------------

Clears a drive or volume cache including the swap file mapping.
Must be run under the Administrator permissions to take effect.

To test:

1. Open Windows Explorer properties dialog for a big sized folder. Observe the
   fast size calculation.
2. Clear the cache of the driver where the folder is located.
3. Reopen Windows Explorer properties dialog for the same folder. Observe the
   folder size calculation slowdown.

-------------------------------------------------------------------------------
9. KNOWN ISSUES
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
9.1. With `cmd.exe`
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
9.1.1. The `cmd.exe /c 1.bat` always returns 0 exit code even if `1.bat` script
       is not.
-------------------------------------------------------------------------------

`1.bat`:

```bat
@echo off

setlocal

call :TEST || exit /b
exit /b 0

:TEST
exit /b 123
```

To fix #1:

  >
  cmd.exe /c call 1.bat

CAUTION:
  The `call` operator will expand environment variables twice:

  >
  callf /v B x /v A %B% /ret-child-exit "" "cmd.exe /c call echo %A%"

  Prints `x` instead of `%B%`.

To fix #2:

  >
  callf /ret-child-exit "" "cmd.exe /c 1.bat & call exit /b %%ERRORLEVEL%%"

  Or

  >
  callf /ret-child-exit "" "cmd.exe /c \"1.bat ^& call exit /b %%ERRORLEVEL%%\""

  NOTE:
    Second workaround requires to correctly escape control characters:
    & | ^ etc

  Or

  Use "errlvl.bat" from `contools` scripts:

  >
  callf /ret-child-exit "" "cmd.exe /c 1.bat & \"%%CONTOOLS_ROOT%%/Scripts/Tools/std/errlvl.bat\""

  and you can use a different environment variables expansion:

  >
  callf /ret-child-exit "" "cmd.exe /c 1.bat & \"${CONTOOLS_ROOT}/Scripts/Tools/std/errlvl.bat\""

-------------------------------------------------------------------------------
9.1.2. Interactive input autocompletion disable.
-------------------------------------------------------------------------------

If at least stdin or stdout (but not stderr) is redirected, then the
interactive input in the child `cmd.exe` process does disable autocompletion
feature.

Examples:

>
callf /tee-stdin 0.log /pipe-stdin-to-child-stdin "" "cmd.exe /k"

>
callf /tee-stdout 1.log /pipe-child-stdout-to-stdout "" "cmd.exe /k"

The issue is attached to the stdin/stdout handle type inside the `cmd.exe`
process.

If the stdin or stdout handle has not a character device type
(ex: GetFileType(GetStdHandle(STD_INPUT_HANDLE)) != FILE_TYPE_CHAR), then the
autocompletion feature is turned off and all characters including a tab
character processes as is. Otherwise the tab button press triggers the
autocompletion feature.

A standard handle changes its type from the `FILE_TYPE_CHAR`, for example, if
a process standard handle is redirected.

The fix can be made portably between different Windows versions, for example,
through the code injection into a child process and interception of the
`ReadConsole`/`WriteConsole` calls.

-------------------------------------------------------------------------------
9.1.3. The `set /p DUMMY=` cmd.exe command ignores the input after the `callf`
       call (Windows XP/7).
-------------------------------------------------------------------------------

NOTE:
  To reproduce the console terminal window must be reopened.

Reproduction example:

```
@echo off

setlocal

if %IMPL_MODE%0 NEQ 0 goto IMPL

rem bugged:
call <nul >nul & call <nul >nul

rem workarounded:
rem ( call >nul & call >nul ) <nul

callf.exe ^
  /promote-parent{ /pause-on-exit } ^
  /elevate{ /no-window /create-inbound-server-pipe-to-stdout test_stdout_{pid} /create-inbound-server-pipe-to-stderr test_stderr_{pid} ^
  }{ /attach-parent-console /reopen-stdout-as-client-pipe test_stdout_{ppid} /reopen-stderr-as-client-pipe test_stderr_{ppid} } ^
  /v IMPL_MODE 1 "" "cmd.exe /c @%0 %*"
exit /b

:IMPL
rem all input can be ignored here
set /P X=AAA
set /P X=BBB
set /P X=CCC
set /P X=DDD
```

To fix that use the `workarounded` call example line.

-------------------------------------------------------------------------------
9.1.4. The `type con | callf "" "cmd.exe /k"` command makes `cmd.exe` left
       behind waiting the last input while the neighbor `callf.exe` process is
       already exited.
-------------------------------------------------------------------------------

To reproduce do execute the command and terminate the last `cmd.exe` child
process.
The neighbor `cmd.exe` process to already exited `callf.exe` process will not
exit until the line return character would be entered.

-------------------------------------------------------------------------------
9.1.5. The `start "" /WAIT /B cmd.exe /k` does not wait a child process.
-------------------------------------------------------------------------------

The command does not wait the `cmd.exe` child process.

To reproduce:

  >
  set A=111
  set A=222
  echo %A%
  111
  echo %A%
  222

To fix:

  >
  start "" /B /WAIT cmd.exe /k

-------------------------------------------------------------------------------
9.1.6. The `callf "" "cmd.exe /c callf \"\" \"cmd.exe /k\""` command losing
       arrows key interactive input (command history traverse).
-------------------------------------------------------------------------------

NOTE:
  Has been workarounded in the version 1.21.1.58.

The command loses arrow keys interactive input and can not traverse command
line input history.

To fix:

  >
  callf /detach-inherited-console-on-wait "" "cmd.exe /c callf \"\" \"cmd.exe /k\""

NOTE:
  In some cases above fix does not work because of a race condition inside
  the `cmd.exe` inner parent console window search logic.

  You can use wait timeout to increase the chances:

  >
  callf /detach-inherited-console-on-wait /wait-child-first-time-timeout 300 "" "cmd.exe /c callf \"\" \"cmd.exe /k\""

-------------------------------------------------------------------------------
9.2. With `callf.exe`/`callfg.exe`
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
9.2.1. Console output in particular case prints as untranslated (line feed and
       return characters become printable)
-------------------------------------------------------------------------------

This issue is related to reattachment of a parent console.

Can be fixed only through the parent process injection being used for console
window attachment and directly call `GetStdHandle` functions to read standard
handle addresses layout to update the standard handles (call `StdStdHandle`) in
the process, where console is attached.

-------------------------------------------------------------------------------
9.2.2. The `callf /pipe-inout-child "" "cmd.exe /k"` command is blocked on
       input while a child process is terminated externally.
-------------------------------------------------------------------------------

NOTE:
  Has been workarounded in the version 1.20.0.54.

To reproduce do execute the command and terminate the `cmd.exe` child process.
The parent process will not exit until the line return character would be
entered.

-------------------------------------------------------------------------------
9.2.3. The `callf /tee-stdin 0.log /pipe-child-stdout-to-stdout "" "cmd.exe /k"`
       command is blocked on input while a child process is terminated
       externally.
-------------------------------------------------------------------------------

To reproduce do execute the command and terminate the `cmd.exe` child process.
The parent process will not exit until the line return character would be
entered.

-------------------------------------------------------------------------------
9.3. With `callf.exe`/`callfg.exe` under VirtualBox
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
9.3.1. The `callf /elevate ...` shows system dialog
       `The specified path does not exist.`.
-------------------------------------------------------------------------------

The ShellExecute API can not run an executable from the VirtualBox Shared
Folder because it is not a fixed volume but a Network Drive.

-------------------------------------------------------------------------------
9.3.2. The `callf.exe` execuable can not be removed if has been run at least
       once as `callf /elevate ...`.
-------------------------------------------------------------------------------

The system does protection on executable been run at least once as elevated
from removement by not elevated processes. We have to attempt to remove and if
didn't then, postpone the rest upon reboot.

NOTE:
  To postpone the removement you still must access the registry keys under an
  elevated user.

-------------------------------------------------------------------------------
9.4. With `bash.exe`
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
9.4.1. The GNU Bash shell executable throws an error:
       `select_stuff::wait: WaitForMultipleObjects failed, Win32 error 6`.
-------------------------------------------------------------------------------

If try to run the Bash shell executable, then it may throw an error after a
console window reallocation in the `callf` utility.

To workaround that you can use `callfg` utility instead with the
`/create-console` flag. This will avoid a need to reallocate a console window,
for example, in the elevated child process in case if elevation is required
(`/attach-parent-console` flag).

-------------------------------------------------------------------------------
10. AUTHOR
-------------------------------------------------------------------------------
Andrey Dibrov (andry at inbox dot ru)
