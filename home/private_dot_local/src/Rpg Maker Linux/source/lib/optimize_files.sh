optimize_files() {
  _debug printf "optimize_files(): Entering...\\n"
  _debug printf "optimize_files(): \${@}:\\n%s\\n" "${@}"

  local _gamePath="${1}"
  local _source_path="${2}"
  local _optimizeVideo="${3}"

  _debug printf "optimize_files(): Check if input path is a RPG Maker MV/MZ game\\n"
  if [[ ! -d "${_gamePath}/www" ]]; then
    _exit_1 printf "Error: Input path is not a RPG Maker MV/MZ game\\n"
  fi

  _debug printf "optimize_files(): Check if files are encrypted\\n"
  local _hasEncryptedImages
  local _hasEncryptedAudio
  _hasEncryptedImages=$(jq -r '.hasEncryptedImages' "${_gamePath}/www/data/System.json")
  _hasEncryptedAudio=$(jq -r '.hasEncryptedAudio' "${_gamePath}/www/data/System.json")
  if [[ "${_hasEncryptedImages}" == "true" ]] || [[ "${_hasEncryptedAudio}" == "true" ]]; then
    _warn printf "Warning: Files are encrypted. Running decrypt command now.\\n"
    decrypt "${_gamePath}" "${_source_path}"
    _debug printf "optimize_files(): Return to optimize\\n"
    printf "Files are decrypted. Resuming optimization...\\n"
  fi

  _debug printf "optimize_files(): Check if backup exist\\n"
  if [ ! -d "${_gamePath}/www_backup" ]; then
    _debug printf "optimize_files(): Creating a backup\\n"
    cp -R "${_gamePath}/www" "${_gamePath}/www_backup"
  else
    printf "Backup already exists. Skipping backup.\\n"
  fi

  _debug printf "optimize_files(): Check if icon exist\\n"
  if [ -f "${_gamePath}/www/icon/icon.png" ]; then
    _debug printf "optimize_files(): Optimize icon\\n"
    oxipng --opt max --strip all "${_gamePath}/www/icon/icon.png"
  else
    echo >&2 "Icon doesn't exist. Ignoring."
  fi

  optimize_image() {
    local file="$1"
    ## Check if a file is an APNG file
    if pngcheck -v "$file" | grep -q -E "acTL"; then
      oxipng --opt max --strip safe "$file" || echo >&2 "oxipng failed on $file. Continuing"
    else
      cwebp -lossless "$file" -o "$file" || echo >&2 "cwebp failed on $file. Continuing."
    fi
  }

  optimize_audio() {
    local file="$1"
    local output="${file%.ogg}.opus"
    ffmpeg -i "$file" -c:a libopus "${output}"
    mv "${output}" "$file"
  }

  optimize_video() {
    local file="$1"
    local output="${file%.webm}.optimized.webm"
    ffmpeg -i "$file" -c:v libvpx-vp9 -c:a libopus -crf 40 -b:v 2000kB -deadline realtime "${output}"
    mv "${output}" "$file"
  }

  export -f optimize_image
  export -f optimize_audio
  export -f optimize_video

  _debug printf "optimize_files(): Finding .png files and optimizing...\\n"
  printf "Optmizing image files...\\n"
  find "${_gamePath}/www" -type f -name "*.png" ! -name "icon.png" | parallel optimize_image

  _debug printf "optimize_files(): Fiding .ogg files and optimizing...\\n"
  printf "Optmizing audio files...\\n"
  find "${_gamePath}/www" -type f -name "*.ogg" | parallel optimize_audio

  if [[ ${_optimizeVideo} -eq 1 ]]; then
    _debug printf "optimize_files(): Fiding .webm files and optimizing\\n"
    printf "Optmizing video files (May take a while)...\\n"
    mapfile -t _videoFiles < <(find "${_gamePath}/www" -type f -name "*.webm")
    for file in "${_videoFiles[@]}"; do
      optimize_video "${file}"
    done
  fi

  printf "Disabling AudioStreaming plugin...\\n"
  sed -i 's/\("name"\s*:\s*"AudioStreaming"\s*,"status"\s*:\s*\)true/\1false/' "${_gamePath}/www/js/plugins.js"
}
