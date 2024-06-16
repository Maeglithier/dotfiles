_USE_DEBUG=${args[--debug]:-0}
_debug printf "update(): Entering...\\n"
_debug printf "update(): \$(inspect_args):\\n%s\\n" "$(inspect_args)"

_debug printf "update(): Verifying depencendies...\\n"
_deps "jq" "install it by running: sudo apt install jq\\n"

local _source_path="${RPGMAKER_SOURCE_PATH}"
local _gamePath="${args[game_path]:-$PWD}"
_gamePath=$(realpath "${_gamePath}")
_debug printf "update(): \${_gamePath}:\\n%s\\n" "${_gamePath}"

update_js "${_gamePath}" "${_source_path}"

printf "Finished!\\n"
