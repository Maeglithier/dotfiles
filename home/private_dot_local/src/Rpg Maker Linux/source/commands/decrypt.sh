_USE_DEBUG=${args[--debug]:-0}
_debug printf "setup(): Entering...\\n"
_debug printf "setup(): \$(inspect_args):\\n%s\\n" "$(inspect_args)"

_debug printf "setup(): Verifying depencendies...\\n"
_deps "jq" "install it by running: sudo apt install jq\\n"
_deps "java" "install it by running: sudo apt install default-jre\\n"

local _source_path="${RPGMAKER_SOURCE_PATH}"
local _gamePath="${args[game_path]:-$PWD}"
_gamePath=$(realpath "${_gamePath}")
_debug printf "setup(): \${_gamePath}:\\n%s\\n" "${_gamePath}"

decrypt_files "${_gamePath}" "${_source_path}"

printf "Finished!\\n"
