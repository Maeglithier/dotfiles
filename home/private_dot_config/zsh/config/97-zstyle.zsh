zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' prompt 'Did you mean?'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

######

# Estilo das categorias
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
zstyle ':completion:*:*:*:*:descriptions' format '-- %d --'
zstyle ':completion:*:*:*:*:corrections' format '!- %d (errors: %e) -!'
zstyle ':completion:*:messages' format '-- %d --'
zstyle ':completion:*:warnings' format '-- sem correspondências --'

#zstyle ':completion:*' file-list all
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Habilita o cache do auto completar
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME}/zsh/zcompcache