# Check global config files: ls -l /etc/zshenv /etc/zprofile /etc/zshrc /etc/zlogin
# Check sources: zsh -lxic exit 2>&1 | grep 'source'
# Check PATH: zsh -lxic exit 2>&1 | grep 'PATH'
#
# NOTE: Paths are injected by MacOS through `launchctl` too
# * launchctl getenv PATH
# * launchctl unsetenv PATH
#  * Seems to get reset tho
# * cat /private/var/db/com.apple.xpc.launchd/config/user.plist
# * sudo launchctl config user path /usr/bin:/bin:/usr/sbin:/sbin
#  * Might have to restart machine after this
#
# To profile, uncomment the following line AND the last line
# time zsh -cli exit
# zmodload zsh/zprof

### OPTIONS ###

# zsh ignore duplicate history entries (when pressing up arrow)
setopt histignoredups

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Lazily load completions and cache them
# If it breaks, run `compinit` manually
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C
 
### Aliases ###

# alias lss="ls -lahG"
alias l="eza"
alias ls="eza"
alias lss="eza -la --icons --git"
alias lst="eza -laT -L 3"
alias ll="eza -la --icons --git"
alias nv="nvim"
alias nvf='nvim $(fzf)'
alias nvconf="cd ~/.config/nvim && nvim . && cd -"
alias tmuxconf="cd ~/.config/tmux && nvim tmux.conf && cd -"
alias zshconf="nvim ~/.zshrc && source ~/.zshrc"
alias vimconf="vim ~/.vimrc"
alias nvss="vim ~/.config/starship.toml"
alias gst="git status"

alias mkdir="mkdir -pv"
alias mv="mv -i"
alias cp="cp -i"

alias ..="cd .."
alias ...="cd ../.."

alias dif="nv -d"

### Languages ###

# for Go
# https://stackoverflow.com/questions/60406755/cannot-do-any-go-command-anymore
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# Homebrew
# `brew --prefix golang` -> `/opt/homebrew/opt/go/`
export GOROOT="/opt/homebrew/opt/go/libexec"
# Manual install
# export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/.cargo/bin

# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"

if [[ -z "$TMUX" && -z "$VSCODE_GIT_IPC_HANDLE" && -z "$VSCODE_PID" ]]; then
  if command -v tmux &>/dev/null; then
    tmux attach-session -t default 2>/dev/null || tmux new-session -s default
  fi
fi

eval "$(starship init zsh)"

# Add binaries in ~/.local/bin/ to the path
. "$HOME/.local/bin/env"

### Plugins ###

# Load plugins last

# source ~/Git/DOTFILES_private/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/Git/DOTFILES_private/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/Git/DOTFILES_private/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#808080"

# To profile, uncomment the following line AND the first line
# zprof
