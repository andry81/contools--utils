* README_EN.txt
* 2025.02.03
* contools--utils--tests

1. DESCRIPTION
2. USAGE
2.1. manual
2.1.1. manual/contools/callf
3. KNOWN ISSUES
3.1. manual/contools/callf

-------------------------------------------------------------------------------
1. DESCRIPTION
-------------------------------------------------------------------------------
Set of tests for contools utilities.

-------------------------------------------------------------------------------
2. USAGE
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
2.1. manual
-------------------------------------------------------------------------------

Manual tests must be run only by hand. Currently for some reason can not be
automated.

-------------------------------------------------------------------------------
2.1.1. manual/contools/callf
-------------------------------------------------------------------------------

You must run each test at least twice:

1. From GUI application like the `Total Commander`.

   NOTE:
      The parent process must not be a console application, so the Far does
      not fit here.

2. From console application like the `cmd.exe` (`cmd.exe /k`).

CAUTION:
  This is a mandatory because several tests tries reattach to an ancestor
  process console window and may produce different results if run from GUI or
  console application!

NOTE:
  You must run each test several times (3-5 times).
  The `cmd.exe` may reorder (Windows 7) or randomize (Windows 8+) standard
  handles addresses layout after each run of an executable.

  For example (Windows 7):

  Run #1: stdin=0x03, stdout=0x0b, stderr=0x0f
  Run #2: stdin=0x03, stdout=0x0f, stderr=0x13
  Run #3: stdin=0x03, stdout=0x13, stderr=0x0b
  Run #4: stdin=0x03, stdout=0x0b, stderr=0x0f
  Run #5: stdin=0x03, stdout=0x0f, stderr=0x13
  etc

NOTE:
  You must run each test from both the User and the Administrator privileges
  process. To do that you can run `Total Commander` or `cmd.exe` as
  Administrator.

NOTE:
  Tests with elevatation must be run both with allowed and not allowed
  by the user dialog elevation. In a not allowed case there must be a readable
  error about elevation error (in case if console window is visible and not
  closed).

All these affect test results. All runs must produce the same results.

-------------------------------------------------------------------------------
3. KNOWN ISSUES
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
3.1. manual/contools/callf
-------------------------------------------------------------------------------

Several tests still fails under specific conditions:

* `03-test--01-elevate--04-new_console_for_all--01-pause_on_exit_if_error.bat`
  `70-test--01-gui_to_gui--02-elevate--03-new_console--01-pause_on_exit.bat`

  Windows 7:
    If deny elevation does print error as unicode in ansi code page.

* `50-test--01-elevate--02-user_input.bat`

  Windows 7:
    Time to time fails to print correctly from opened `cmd.exe` console under
    not elevated environment.

* `70-test--01-gui_to_gui--02-elevate--01-new_console_if_elevated--01-pause_on_exit.bat`

  Windows 7:
    Child `cmd.exe` must exit without any key press, but callfg process
    must print `Press any key to continue . . . ` and exit on a key press.
    If not, then the end callfg process must be terminated manually.
