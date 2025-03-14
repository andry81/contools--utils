[+ AutoGen5 template txt=%s.txt +]
printf.exe, version [+ AppMajorVer +].[+ AppMinorVer +].[+ AppRevision +], build [+ AppBuildNum +].
  Print in style of c-function printf, replacing specific backslashed
  character pairs in string arguments with characters.

Usage: printf.exe [/?] [<Flags>] [//] <FormatString> [<Arg1> [<Arg2> ... [<ArgN>]]]
  Description:
    /?:
    This help.

    //:
    Character sequence to stop parse <Flags> command line parameters.

    Flags:
      /chcp <codepage>
        Console output code page.

      /no-print-gen-error-string
        Don't print generic error string.

      /no-expand-env
        Don't expand `${...}` environment variables.

        Can not be used together with the `/allow-expand-unexisted-env` flag.
        Has effect on `{*}` and `{@}` variable values.

      /no-subst-vars
        Don't substitute all `{...}` variables (command line arguments).
        Additionally disables `\{` escape sequence expansion.

        Can not be used together with `/no-subst-pos-vars`,
        `/allow-subst-empty-args` flags.

      /no-subst-pos-vars
        Don't substitute positional `{...}` variables (command line arguments).

        Has no effect on `{*}` and `{@}` variables (not positional).
        Does not disable `\{` escape sequence expansion.
        Can not be used together with `/no-subst-vars`,
        `/allow-subst-empty-args` flags.

      /no-subst-empty-tail-vars
        Don't substitute empty `{*}` and `{@}` variables.

        Can be used together with `/allow-subst-empty-args` flag.

      /allow-expand-unexisted-env
        Allow expansion of unexisted `${...}` environment variables in
        all command line arguments.

        Can not be used together with the `/no-expand-env` flag.
        Has effect on `{*}` and `{@}` variable values.

      /allow-subst-empty-args
        Allow substitution of empty `{...}` variables in all command line
        arguments.

        Can not be used together with the `/no-subst-vars` flag.
        Has effect on `{*}` and `{@}` variable values, but not on the
        variable placeholders, because they always substitutes.

      /eval-backslash-esc or /e
        Evaluate escape characters:
          \a = \x07 = alert (bell)
          \b = \x08 = backspace
          \t = \x09 = horizontal tab
          \n = \x0A = newline or line feed
          \v = \x0B = vertical tab
          \f = \00C = form feed
          \r = \x0D = carriage return
          \e = \x1B = escape (non-standard GCC extension)

          \" = quotation mark
          \' = apostrophe
          \? = question mark
          \\ = backslash

          \N or \NN or \NNN or .. or \NNNNNNNNNN - octal number
          \xN or \xNN or \xNNN or .. or \xNNNNNNNN - hexidecimal number

      /eval-dbl-backslash-esc or /e\\
        Evaluate double backslash escape characters:
          \\ = backslash

    <FormatString>, <ArgN> placeholders:
      ${<VarName>} - <VarName> environment variable value.
      {0}    - first argument value.
      {N}    - N'th argument value.
      {@}    - tail arguments as raw string.
      {*}    - first and tail arguments as raw string.
      {0hs}  - first arguments hexidecimal string (00-FF per character).
      {Nhs}  - N'th arguments hexidecimal string (00-FF per character).
      \{     - '{' character escape.

      The `{*}` and `{@}` variables always substitutes even if value is empty,
      except if `/no-subst-empty-tail-vars` flag is defined.

  Return codes:
   -255 - unspecified error
   -128 - help output
   -2   - invalid format
   -1   - invalid parameters
    0   - succeded

  Examples:
    1. printf.exe /e "Hello world!\n"
    2. printf.exe "{0}={1}" "My profit" "10%"
    3. printf.exe "{@} = {0}" "2" 1 + 1
    4. printf.exe "{*}" 1 + 1 = 2
    5. printf.exe "{*}" $\{TEMP} = `${TEMP}`
