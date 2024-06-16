## _exit_1()
##
## Usage:
##   _exit_1 <command>
##
## Description:
##   Exit with status 1 after executing the specified command with output
##   redirected to standard error. The command is expected to print a message
##   and should typically be either `echo`, `printf`, or `cat`.
_exit_1() {
  {
    printf "%s " "$(tput setaf 1)!$(tput sgr0)"
    "${@}"
  } 1>&2
  exit 1
}

## _return_1()
##
## Usage:
##   _return_1 <command>
##
## Description:
##   Return with status 1 after executing the specified with output redirected
##   to standard error. The command is expected to print a message and should
##   typically be either `echo`, `printf`, or `cat`.
_return_1() {
  {
    printf "%s " "$(tput setaf 1)!$(tput sgr0)"
    "${@}"
  } 1>&2
  return 1
}

## _warn()
##
## Usage:
##   _warn <command>
##
## Description:
##   Print the specified command with output redirected to standard error.
##   The command is expected to print a message and should typically be either
##   `echo`, `printf`, or `cat`.
_warn() {
  {
    printf "%s " "$(tput setaf 1)!$(tput sgr0)"
    "${@}"
  } 1>&2
}
