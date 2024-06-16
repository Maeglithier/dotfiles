_USE_DEBUG=${args[--debug]:-0}
_debug printf "configure(): Entering...\\n"
_debug printf "configure(): \$(inspect_args):\\n%s\\n" "$(inspect_args)"

_debug printf "configure(): Verifying depencendies...\\n"
_deps "jq" "install it by running: sudo apt install jq\\n"
_deps "curl" "install it by running: sudo apt install curl\\n"

local _source_path="${RPGMAKER_SOURCE_PATH}"

configure_engine "${_source_path}"

printf "Finished!\\n"
