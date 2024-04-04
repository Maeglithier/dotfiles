# Este arquivo deve ser carregado após fazer o source de scripts

# Carrega os locais de auto comppletar ao fpath
fpath=(${ZDOTDIR}/completions $fpath)
fpath=(${ASDF_DIR}/completions $fpath)

# Compatibilidade com auto compeltar do bash
autoload -Uz bashcompinit
bashcompinit -d $XDG_CACHE_HOME/zsh/bashcompdump -u

# Carrega as funções de auto completar
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump -u

# Habilita o cache do auto completar
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache