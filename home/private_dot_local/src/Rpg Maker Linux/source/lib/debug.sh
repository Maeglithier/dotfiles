## _debug()
##
## Usage:
##   _debug <command> <options>...
##
## Description:
##   A simple function for executing a specified command if the `$_USE_DEBUG`
##   variable has been set. The command is expected to print a message and
##   should typically be either `echo`, `printf`, or `cat`.
##
## Example:
##   _debug printf "Debug info. Variable: %s\\n" "$0"
##
__DEBUG_COUNTER=0
_debug() {
  if ((${_USE_DEBUG:-0})); then
    __DEBUG_COUNTER=$((__DEBUG_COUNTER + 1))
    {
      printf "🐛  %s " "${__DEBUG_COUNTER}"
      "${@}"
      printf "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――\\n"
    } 1>&2
  fi
}
