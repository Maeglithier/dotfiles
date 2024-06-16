_USE_DEBUG=${args[--debug]:-0}
_debug printf "setup(): Entering...\\n"
_debug printf "setup(): \$(inspect_args):\\n%s\\n" "$(inspect_args)"

_debug printf "setup(): Verifying depencendies...\\n"
local _optimizeVideo=${args[--video]:-0}
_deps "jq" "install it by running: sudo apt install jq\\n"
_deps "pngcheck" "install it by running: sudo apt install pngcheck\\n"
_deps "oxipng" "install from https://github.com/shssoichiro/oxipng/releases/latest\\n"
_deps "cwebp" "install it by running: sudo apt install webp\\n"
_deps "ffmpeg" "install it by running: sudo apt install ffmpeg\\n"
_deps "parallel" "install it by running: sudo apt install parallel\\n"

local _source_path="${RPGMAKER_SOURCE_PATH}"
local _gamePath="${args[game_path]:-$PWD}"
_gamePath=$(realpath "${_gamePath}")
_debug printf "setup(): \${_gamePath}:\\n%s\\n" "${_gamePath}"

optimize_files "${_gamePath}" "${_source_path}" "${_optimizeVideo}"

printf "Finished!\\n"
