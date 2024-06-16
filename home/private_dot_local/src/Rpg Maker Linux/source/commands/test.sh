local _source_path="${RPGMAKER_SOURCE_PATH}"
local _gamePath="${args[game_path]:-$PWD}"
_gamePath=$(realpath "${_gamePath}")

## Put any test here

_warn printf "We don't have any test!\\n"
