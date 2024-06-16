# Compactar um arquivo ou diretório
# Uso: comp arquivo.txt
function comp() {
  # Verifica se não há argumentos
  if [[ "${#}" -eq 0 ]]; then
    echo "Não recebi nenhum argumento. Esperando exatamente um argumento."

  # Verifica se há 2 ou mais argumentos
  elif [[ "${#}" -gt 1 ]]; then
    echo "Recebi mais de um argumento. Esperando exatamente um argumento."

  # Verifica se o arquivo ou pasta existe
  elif [[ -f "${1}" ||  -d "${1}" ]]; then
    tar zcvf "${1}_$(date '+%Y-%m-%d').tar.gz" "${1}";

  # O arquivo ou pasta não existe
  else
    echo "O arquivo ou pasta \"${1}\" não existe."
  fi
}