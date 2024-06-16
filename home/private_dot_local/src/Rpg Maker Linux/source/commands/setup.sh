_USE_DEBUG=${args[--debug]:-0}
_debug printf "setup(): Entering...\\n"
_debug printf "setup(): \$(inspect_args):\\n%s\\n" "$(inspect_args)"

_debug printf "setup(): Verifying depencendies...\\n"
local _update=${args[--update]:-0}
local _decrypt=${args[--decrypt]:-0}
local _optimize=${args[--optimize]:-0}
local _optimizeVideo=${args[--video]:-0}
_deps "jq" "install it by running: sudo apt install jq\\n"
if [[ ${_decrypt} -eq 1 ]]; then
  _deps "java" "install it by running: sudo apt install default-jre\\n"
fi
if [[ ${_optimize} -eq 1 ]]; then
  _deps "pngcheck" "install it by running: sudo apt install pngcheck\\n"
  _deps "oxipng" "install from https://github.com/shssoichiro/oxipng/releases/latest\\n"
  _deps "cwebp" "install it by running: sudo apt install webp\\n"
  _deps "ffmpeg" "install it by running: sudo apt install ffmpeg\\n"
  _deps "parallel" "install it by running: sudo apt install parallel\\n"
fi
if [[ ${_optimizeVideo} -eq 1 ]]; then
  if [[ ! ${_optimize} -eq 1 ]]; then
    _exit_1 printf "The --video flag need to be used with the --optimize flag.\\n"
  fi
fi

local _source_path="${RPGMAKER_SOURCE_PATH}"
local _gamePath="${args[game_path]:-$PWD}"
_gamePath=$(realpath "${_gamePath}")
_debug printf "setup(): \${_gamePath}:\\n%s\\n" "${_gamePath}"

game_setup "${_gamePath}"

if [[ ${_update} -eq 1 ]]; then
  update_js "${_gamePath}" "${_source_path}"
fi

if [[ ${_decrypt} -eq 1 ]]; then
  decrypt_files "${_gamePath}" "${_source_path}"
fi

if [[ ${_optimize} -eq 1 ]]; then
  optimize_files "${_gamePath}" "${_source_path}" "${_optimizeVideo}"
fi

_debug printf "setup(): Check if user has set up the Game Engine\\n"
if [ ! -f "${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs/Game.sh" ]; then
  _warn printf "Warning: Game Engine not found. Running configure command now.\\n"
  configure_engine "${_source_path}"
fi

printf "Finished!\\n"
