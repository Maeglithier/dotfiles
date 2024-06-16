# Descompactar um arquivo
# Uso: dcomp arquivo.tar
function dcomp() {
  # Verifica se não há argumentos
  if [[ "${#}" -eq 0 ]]; then
    echo "Não recebi nenhum argumento. Esperando exatamente um argumento."

  # Verifica se há 2 ou mais argumentos
  elif [[ "${#}" -gt 1 ]]; then
    echo "Recebi mais de um argumento. Esperando exatamente um argumento."
  
  # Verifica se é um diretório
  elif [[ -d "${1}" ]]; then
    echo "Recebi uma pasta como argumento. Esperando um arquivo como argumento."

  # Verifica é um arquivo válido e se é suportado
  elif [[ -f ${1} ]]; then
    case ${1} in
      *.Z)        uncompress "${1}"                                        ;;
      *.tar.bz2)  tar jxvf "${1}"                                          ;;
      *.tar.gz)   tar zxvf "${1}"                                          ;;
      *.tbz2)     tar jxvf "${1}"                                          ;;
      *.tgz)      tar zxvf "${1}"                                          ;;
      *.tar)      tar xvf "${1}"                                           ;;
      *.bz2)      bunzip2 "${1}"                                           ;;
      *.rar)      unrar x "${1}"                                           ;;
      *.gz)       gunzip "${1}"                                            ;;
      *.zip)      unzip "${1}"                                             ;;
      *.xz)       unxz "${1}"                                              ;;
      *.7z)       7z x "${1}"                                              ;;
      *)          echo "A compressão do arquivo \"${1}\" não é suportada." ;;
    esac

  # O arquivo não é suportado
  else
    echo "O arquivo \"${1}\" não existe"
  fi
}