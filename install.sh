#!/bin/bash

set -e # -e: sair quanto ocorrer um erro

if [ ! "$(command -v chezmoi)" ]; then
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply maeglithier
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init --apply maeglithier
  else
    echo "Para instalar o chezmoi, você precisa ter o curl ou o wget instalado." >&2
    exit 1
  fi
else
  chezmoi init --apply maeglithier
fi