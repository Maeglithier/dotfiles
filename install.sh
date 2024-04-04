#!/bin/sh

set -e # -e: sair quanto ocorrer um erro

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "Para instalar o chezmoi, você precisa ter o curl ou o wget instalado." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# forma do POSIX de conseguir o diretório do script: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: troca o processo atual pelo chezmoi init
exec "$chezmoi" init --apply "--source=$script_dir"