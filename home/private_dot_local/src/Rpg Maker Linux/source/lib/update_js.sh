update_js() {
  _debug printf "update_js(): Entering...\\n"
  _debug printf "update_js(): \${@}:\\n%s\\n" "${@}"

  local _gamePath="${1}"
  local _source_path="${2}"

  _debug printf "update_js(): Check if input path is a RPG Maker MV/MZ game\\n"
  if [[ ! -f "${_gamePath}/www/js/libs/pixi.js" ]]; then
    _exit_1 printf "Error: Input path is not a RPG Maker MV/MZ game\\n"
  else
    local _pixi="${_gamePath}/www/js/libs/pixi.js"
  fi

  copy_files() {
    _debug printf "update_js(): copy_files(): Entering...\\n"
    _debug printf "update_js(): copy_files(): \${@}:\\n%s\\n" "${@}"

    local _variant=${1}

    printf "Updating the RPG Maker %s pixi.js\\n" "${_variant}"
    if [[ ! -d "${_gamePath}/www/js/libs_backup" ]]; then
      _debug printf "update_js(): copy_files(): Backup original files\\n"
      cp -r "${_gamePath}/www/js" "${_gamePath}/www/js_backup"
    fi
    cp -r "${_source_path}/storage/${_variant}"/* "${_gamePath}/www/js"
  }

  _debug printf "update_js(): Check if the game is MV or MZ\\n"
  if grep -q "pixi.js - v4." "${_pixi}"; then
    copy_files "MV"
  elif grep -q "pixi.js - v5." "${_pixi}"; then
    copy_files "MZ"
  else
    _exit_1 printf "Error: Can't detect pixi.js version."
  fi
}
