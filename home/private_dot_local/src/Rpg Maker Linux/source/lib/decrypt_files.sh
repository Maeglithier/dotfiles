decrypt_files() {
  _debug printf "decrypt_files(): Entering...\\n"
  _debug printf "decrypt_files(): \${@}:\\n%s\\n" "${@}"

  local _gamePath="${1}"
  local _source_path="${2}"

  _debug printf "decrypt_files(): Check if input path is a RPG Maker MV/MZ game\\n"
  if [[ ! -d "${_gamePath}/www" ]]; then
    _exit_1 printf "Error: Input path is not a RPG Maker MV/MZ game\\n"
  fi

  _debug printf "decrypt_files(): Searching for a custom encryption plugin\\n"
  local _plugins
  local _defaultEncryption=0
  _plugins=$(cat "${_gamePath}/www/js/plugins.js")

  if echo "${_plugins}" | grep -q -E "Art_Decrypterator3000"; then
    _defaultEncryption=1
    ## Decryption script for this plugin goes here, if any
    ## If there is another dependency, then use the _deps to inform it
    ## _deps "jq" "install it by running: sudo apt install jq\\n"
    _exit_1 printf "Error: This game use Encrypterator 3000\\nUnless there is an available decryptor, this game cannot be decrypted with this scritp\\n"
  fi

  if echo "${_plugins}" | grep -q -E "POR_AssetDecoder"; then
    _defaultEncryption=1

    _deps "node" "install it by running: sudo apt install nodejs\\n"

    _debug printf "decrypt_files(): Using POE_decrypt tool to try decrypt files\\n"
    printf "Decrypting game files (POE Encryption)...\\n"

    _debug printf "decrypt_files(): Copy the plugin script and export the decodeFile function\\n"
    cp "${_gamePath}/www/js/plugins/POR_AssetDecoder.js" "${_source_path}/storage/POR_AssetDecoder.js"
    printf "\\nmodule.exports = decodeFile;\\n" >>"${_source_path}/storage/POR_AssetDecoder.js"

    _debug printf "decrypt_files(): Using node to decrypt the default .ext + \"o\" pattern\\n"
    node "${_source_path}/storage/POE_decrypt.js" "$_gamePath"

    printf "Disabling POR_AssetDecoder plugin...\\n"
    sed -i 's/\("name"\s*:\s*"POR_AssetDecoder"\s*,"status"\s*:\s*\)true/\1false/' "${_gamePath}/www/js/plugins.js"

    local _extensions=(".oggo" ".m4ao" ".pngo" ".webmo" ".mp4o")
  fi

  if [[ ${_defaultEncryption} -eq 0 ]]; then
    _debug printf "decrypt_files(): Using default decryption tool\\n"
    printf "Decrypting game files...\\n"
    if ! java -jar "${_source_path}/storage/RPG Maker MV Decrypter.jar" decrypt "${_gamePath}" "${_gamePath}"; then
      _exit_1 "Error: Failed to decrypt.\\n"
    fi

    _debug printf "decrypt_files(): Cleaning...\\n"
    rm -r "./output" "./updateCache.pref"

    local _extensions=(".rpgmvo" ".rpgmvm" ".rpgmvp" ".ogg_" ".m4a_" ".png_")
  fi

  _debug printf "decrypt_files(): \${_extensions}:\\n%s\\n" "$(echo "${_extensions[@]}")"

  _debug printf "decrypt_files(): Deleting encrypted files\\n"
  for ext in "${_extensions[@]}"; do
    _debug printf "decrypt_files(): Delete \${ext}:\\n%s\\n" "${ext}"
    find "${_gamePath}" -type f -name "*${ext}" -delete
  done

  _debug printf "decrypt_files(): Edit package.json to load decrypted files\\n"
  jq '.hasEncryptedAudio = false | .hasEncryptedImages = false' "${_gamePath}/www/data/System.json" >"${_gamePath}/www/data/System.json.tmp"
  mv "${_gamePath}/www/data/System.json.tmp" "${_gamePath}/www/data/System.json"
}
