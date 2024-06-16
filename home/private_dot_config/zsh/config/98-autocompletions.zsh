# Este arquivo deve ser carregado após fazer o source de scripts
# Por isto ele é um dos ultimos a ser carregado

# Carrega os locais de auto completar para o fpath
fpath=(${ZDOTDIR}/completions ${fpath})
fpath=(${ASDF_DIR}/completions ${fpath})

# Compatibilidade com auto completar do bash
autoload -Uz bashcompinit
bashcompinit -d ${XDG_CACHE_HOME}/zsh/bashcompdump -u

# Carrega as funções de auto completar
autoload -Uz compinit
compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump -u