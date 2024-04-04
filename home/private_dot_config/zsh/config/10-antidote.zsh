if [ ! -d "$XDG_SOURCE_HOME/antidote" ]; then
  echo "Instalando antidote..."
  git clone https://github.com/mattmc3/antidote.git $XDG_SOURCE_HOME/antidote > /dev/null 2>&1
fi

zstyle ':antidote:bundle' use-friendly-names 'yes'

[[ -f $ANTIDOTE_PLUGINS_FILE ]] || touch $ANTIDOTE_PLUGINS_FILE

fpath=($XDG_SOURCE_HOME/antidote $fpath)
autoload -Uz antidote

if [[ ! $ANTIDOTE_PLUGINS_BUNDLE -nt $ANTIDOTE_PLUGINS_FILE ]]; then
  antidote bundle <$ANTIDOTE_PLUGINS_FILE >|$ANTIDOTE_PLUGINS_BUNDLE
fi

source $ANTIDOTE_PLUGINS_BUNDLE