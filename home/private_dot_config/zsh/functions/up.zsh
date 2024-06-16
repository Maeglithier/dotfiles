# Voltar uma quantidade X de diretórios
# Uso: up 3
function up(){
  # Verifica se não há argumentos
  if [[ "${#}" -eq 0 ]]; then
    cd ..

  # Verifica se há 2 ou mais argumentos
  elif [[ "${#}" -gt 1 ]]; then
    echo "Recebi mais de um argumento. Esperando exatamente um argumento."

  # Verifica se o argumento não é um numero válido
  elif ! [[ ${1} =~ '^[0-9]+$' ]]; then
    echo "\"${1}\" não é um argumento válido. Esperando um número."

  # Recebeu apenas um argumento e é um número válido
  else
    local d=""
    local c=${1}
    for ((i=1 ; i <= c ; i++))
      do
        d=${d}/..
      done
    d=$(echo $d | sed 's/^\///')
    cd $d
  fi
}