#!/bin/bash

XDG_SOURCE_HOME=${HOME}/.local/src
BIN=${HOME}/.local/bin

if [[ -f "${XDG_SOURCE_HOME}/lazygit/lazygit" ]]; then
    ln -sf "${XDG_SOURCE_HOME}/lazygit/lazygit" "${BIN}/lazygit"
fi

if [[ -f "${XDG_SOURCE_HOME}/nvim/bin/nvim" ]]; then
    ln -sf "${XDG_SOURCE_HOME}/nvim/bin/nvim" "${BIN}/nvim"
fi
