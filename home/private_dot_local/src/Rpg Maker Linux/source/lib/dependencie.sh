## _deps()
##
## Usage:
##   _deps <dependencie> <error message>
##
## Description:
##   Verify if the dependencie is installed. And if not;
##   Print the specified command with output redirected to standard error.
##   The command is expected to print a message and should typically be either
##   `echo`, `printf`, or `cat`.
_deps() {
  if ! command -v "${1}" >/dev/null 2>&1; then
    {
      _warn printf "Error: Dependencie \"%s\" not found\\n" "${1}"
      _exit_1 printf "${2}\\n"
    } 1>&2
  fi
}
