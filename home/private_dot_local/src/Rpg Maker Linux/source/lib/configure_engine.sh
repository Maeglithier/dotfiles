configure_engine() {
  _debug printf "configure_engine(): Entering...\\n"
  _debug printf "configure_engine(): \${@}:\\n%s\\n" "${@}"

  local _url="https://nwjs.io/versions"
  local _tmp_versions="/tmp/versions.json"
  local _current="${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs/version.txt"
  local _source_path="${1}"

  # Function to download, extract NWJS. Copy "Game.sh" to "target_dir"
  download() {
    _debug printf "configure_engine(): download(): Entering...\\n"
    _debug printf "configure_engine(): download(): \${@}:\\n%s\\n" "${@}"

    local _version=${1}
    local _url="https://dl.nwjs.io/${_version}/nwjs-sdk-${_version}-linux-x64.tar.gz"
    local _tmp_file="/tmp/nwjs-sdk-${_version}-linux-x64.tar.gz"
    local _extract_dir="/tmp/nwjs-sdk-${_version}-linux-x64"
    local _target_dir="${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs"

    _debug printf "configure_engine(): download(): \${_url}:\\n%s\\n" "${_url}"
    printf "Downloading nwjs %s...\\n" "${_version}"
    if ! curl -fSL -o "${_tmp_file}" "${_url}"; then
      _exit_1 printf "Error: Failed to download nwjs ${_version}\\n"
    fi

    printf "Extracting nwjs %s...\\n" "${_version}"
    if ! tar -xzf "${_tmp_file}" -C "/tmp"; then
      _exit_1 printf "Error: Failed to extract nwjs ${_version}\\n"
    fi

    printf "Installing nwjs %s...\\n" "${_version}"
    rm -rf "${_target_dir}"
    mkdir -p "${_target_dir}"

    _debug printf "configure_engine(): download(): Copy extacted to target dir...\\n"
    cp -R "${_extract_dir}"/* "${_target_dir}/"

    _debug printf "configure_engine(): download(): Copy Game.sh to target dir...\\n"
    cp "${_source_path}/storage/Game.sh" "${_target_dir}"
    mkdir -p "${_target_dir}/www"
    echo "${_version}" >"${_current}"

    _debug printf "configure_engine(): download(): Cleaning tmp files...\\n"
    rm -rf "${_tmp_file}"
    rm -rf "${_extract_dir}"

    printf "Installed nwjs %s\\n" "${_version}"
  }

  _debug printf "configure_engine(): Query \$_url for available versions\\n"
  printf "Querying available versions...\\n"
  if ! curl -fsSL -o "${_tmp_versions}" "${_url}"; then
    _exit_1 printf "Error: Failed to query available versions.\\n"
  fi

  local _latest
  _latest=$(jq -r '.latest' "${_tmp_versions}")
  local _versions
  _versions=$(jq -r '.versions[].version' "${_tmp_versions}" | head -20 | awk '{ORS = (NR%5 ? ", " : "\n")} {print}')

  printf "Listing 20 most recent versions:\\n%s\\n" "${_versions}"
  printf "Enter the version (including the v) you wish to download.\\nLeft blank and press Enter to download the latest version.\\n"

  read -r _input

  _debug printf "configure_engine(): Check if the user enter a valid version, if empty then download the latest version\\n"
  _debug printf "configure_engine(): cat \$_current:\\n%s\\n" "$(cat "${_current}")"
  _debug printf "configure_engine(): \$_latest:\\n%s\\n" "${_latest}"
  if [[ -n "${_input}" ]]; then
    _debug printf "configure_engine(): Check if \$_input is a valid \$_versions\\n"
    _debug printf "configure_engine(): \$_input:\\n%s\\n" "${_input}"
    _debug printf "configure_engine(): \$_versions:\\n%s\\n" "${_versions}"
    if [[ "${_versions}" == *"${_input}"* ]]; then
      download "${_input}"
    else
      _exit_1 printf "Error: \"%s\" is not a valid version.\\n" "${_input}"
    fi
  elif [[ ! -f "${_current}" ]] || [[ $(cat "${_current}") != "${_latest}" ]]; then
    _debug printf "configure_engine(): \$_current do not exist or is not equal \$_latest\\n"
    download "${_latest}"
  else
    printf "Already up to date.\\nCurrent version: %s\\n" "$(cat "${_current}")"
  fi
}
