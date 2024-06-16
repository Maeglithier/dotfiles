# Carrega o prompt instantaneo. Deve ser carregado o quanto antes.
# Qualquer input no console deve ocorrer antes deste arquivo.
# Qualquer input no console será considerado como erro depois carregado.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi