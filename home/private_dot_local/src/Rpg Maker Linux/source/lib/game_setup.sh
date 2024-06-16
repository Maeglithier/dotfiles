game_setup() {
  _debug printf "game_setup(): Entering...\\n"
  _debug printf "game_setup(): \${@}:\\n%s\\n" "${@}"
  local _gamePath="${1}"

  # See: https://github.com/Revival8697/RPG-Maker-MV-MZ-Linux-Guide/blob/main/game-setup.sh

  _debug printf "game_setup(): Check if the directory is a RPG Maker MV/MZ game\\n"
  if [[ ! -f "${_gamePath}/package.json" ]]; then
    _exit_1 printf "Error: Input path is not a RPG Maker MV/MZ game.\\n"
  fi

  _debug printf "game_setup(): Check if the game is MV or MZ\\n"
  if [[ -d "${_gamePath}/www" ]]; then
    echo "Detected: RPG Maker MV game."

    _debug printf "game_setup(): Delete everything except \"www\" and \"package.json\"\\n"
    find "${_gamePath}" -mindepth 1 -maxdepth 1 ! -name "www" ! -name "package.json" -exec rm -rf {} \;
  else
    echo "Detected: RPG Maker MZ game."
    echo "Repackaging..."

    mkdir "${_gamePath}/www"

    _debug printf "game_setup(): Folders and files that will not be copied to the \"www\" folder\\n"
    local _excludedItems=("www" "captures" "locales" "swiftshader" "credits.html" "d3dcompiler_47.dll" "ffmpeg.dll" "Game.exe" "icudtl.dat" "libEGL.dll" "libGLESv2.dll" "node.dll" "notification_helper.exe" "nw_100_percent.pak" "nw_200_percent.pak" "nw_elf.dll" "nw.dll" "resources.pak" "v8_context_snapshot.bin")
    _debug printf "game_setup(): \${_excludedItems}:\\n%s\\n" "$(echo "${_excludedItems[@]}")"

    is_excluded() {
      local item="${1}"
      for excluded in "${_excludedItems[@]}"; do
        if [[ "${excluded}" == "${item}" ]]; then
          return 0
        fi
      done
      return 1
    }

    _debug printf "game_setup(): Copy folder and files not in _excludedItems\\n"
    for item in "${_gamePath}"/*; do
      local _baseItem
      _baseItem=$(basename "${item}")
      if ! is_excluded "${_baseItem}"; then
        _debug printf "game_setup(): cp -r \$item:\\n%s\\n" "$item"
        cp -r "${item}" "${_gamePath}/www"
      fi
    done

    _debug printf "game_setup(): Delete everything except \"www\"\\n"
    find "${_gamePath}" -mindepth 1 -maxdepth 1 ! -name "www" -exec rm -rf {} \;

    _debug printf "game_setup(): Copy and edit MZ \"package.json\"\\n"
    if [ -e "${_gamePath}/www/package.json" ]; then
      cp "${_gamePath}/www/package.json" "${_gamePath}/package.json"
      jq '.main = "www/index.html" | .window.icon = "www/icon/icon.png"' "${_gamePath}/package.json" >"${_gamePath}/package.json.temp"
      mv "${_gamePath}/package.json.temp" "${_gamePath}/package.json"
    else
      _exit_1 printf "Error: package.json does not exist in the 'www' directory.\\n"
    fi
  fi

  _debug printf "game_setup(): Fill the \"name\" parameter with the game folder name\\n"
  local _name
  _name=$(basename "${_gamePath}")
  _debug printf "game_setup(): \$_name:\\n%s\\n" "$_name"
  jq --arg name "${_name}" '.name = $name' "${_gamePath}/package.json" >"${_gamePath}/package.json.temp"
  mv "${_gamePath}/package.json.temp" "${_gamePath}/package.json"

  _debug printf "game_setup(): Create the game launcher\\n"
  ln -sf "${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs/Game.sh" "${_gamePath}/Game.sh"
}
