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

# add directories to path
export PATH="$HOME/bin:$HOME/bin/internal-scripts:$PATH"
export PATH="$HOME/bin:$HOME/bin/internal-scripts/wcl-markers/:$PATH"

PROMPT='%F{cyan}%B%n@%m%b %F{blue}%~ %(?.%F{green}.%F{red})%#%f '

#Autorun
fastfetch

#Aliases
alias ll='ls -lah'
alias input-stop="input-remapper-control --command stop --device 'Logitech PRO X 2'"
alias input-load="input-remapper-control --command start --device 'Logitech PRO X 2' --preset 'wow ctrl m5'"
alias rcon-lidl="rcon -a 192.168.0.9:25575 -p rconpasslol"
alias cbf="clipboard-file.sh"

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


# Created by `pipx` on 2025-07-12 18:29:54
export PATH="$PATH:/home/zwoooz/.local/bin"

export VISUAL=nvim
export EDITOR=nvim
export SYSTEMD_EDITOR=nvim

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/zwoooz/.dart-cli-completion/zsh-config.zsh ]] && . /home/zwoooz/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

