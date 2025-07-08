# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zwoooz/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export PATH="$HOME/bin:$PATH"

PROMPT='%F{cyan}%B%n@%m%b %F{blue}%~ %(?.%F{green}.%F{red})%#%f '

#Autorun
fastfetch

#Aliases
alias todo=c3

#IDK
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  xrdb -merge ~/.Xresources
  (cat ~/.cache/wal/sequences &)
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#Plugins
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
 source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
 source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

