#!/bin/bash

if [ "${SHELL}" != "/bin/zsh" ]; then
  sudo chsh -s "$(which zsh)" "$(whoami)"
fi

if ! grep -qF "export ZDOTDIR=\$HOME/.config/zsh" /etc/zsh/zshenv; then
  echo "export ZDOTDIR=\$HOME/.config/zsh" | sudo tee /etc/zsh/zshenv >/dev/null
fi
