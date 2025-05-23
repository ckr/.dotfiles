export DEFAULT_USER=ckr
#export EDITOR='vim'

#Add brew to the path
[ -f /opt/homebrew/bin/brew ] &&  eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"

#Add zplug to the path
export ZPLUG_HOME="$HOMEBREW_PREFIX/opt/zplug"
# Load zplug init
[ -d $ZPLUG_HOME ] && source $ZPLUG_HOME/init.zsh

#history
export HISTFILE=~/.zsh_history # Where it gets saved
# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
export SAVEHIST=10000
# Don't overwrite, append!
setopt append_history
# Write after each command
setopt INC_APPEND_HISTORY 
# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first
# use OS file locking
setopt hist_fcntl_lock
# Delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_all_dups
# better word splitting, but more CPU heavy
setopt hist_lex_words
# Remove superfluous blanks before recording entry.
setopt hist_reduce_blanks
# Don't write duplicate entries in the history file.
setopt hist_save_no_dups
# share history between multiple shells
setopt share_history
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE 

#zplug plugins and themes

zplug "mafredri/zsh-async", from:"github", use:"async.zsh"

# zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme, if:"[ \"$TERM_PROGRAM\" != \"Apple_Terminal\" ]"

zplug "zsh-users/zsh-autosuggestions", defer:2
if zplug check "zsh-users/zsh-autosuggestions"; then
	# Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down accept-line)
	# Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
fi

zplug "rupa/z", use:z.sh

zplug "zsh-users/zsh-syntax-highlighting"

zplug "zsh-users/zsh-completions", depth:2

zplug "zsh-users/zsh-history-substring-search"
# rebind keys to use zsh-history-substring-search
if zplug check "zsh-users/zsh-history-substring-search"; then
	zmodload zsh/terminfo
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
fi

zplug "djui/alias-tips"

# zplug "psprint/zsh-navigation-tools"
# if zplug check "psprint/zsh-navigation-tools"; then
# 	autoload znt-history-widget
# 	zle -N znt-history-widget
# 	bindkey "^R" znt-history-widget
# fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# load fonts
[ -d ~/.fonts ] && source ~/.fonts/*.sh

# Load the aliases file
[ -f ~/.aliases ] && source ~/.aliases

# Load the profile file
[ -f ~/.profile ] && source ~/.profile

# Load the private file
[ -f ~/.private ] && source ~/.private

# Load functions file
[ -f ~/.functions ] && source ~/.functions

# Load path export overwrites
[ -f ~/.path_exports ] && source ~/.path_exports

# Load other exports
[ -f ~/.other_exports ] && source ~/.other_exports

# Spaceship theme settings
[ -f ~/.spaceship.conf ] && source ~/.spaceship.conf

# Set up fzf key bindings and fuzzy completion
if type "fzf" > /dev/null; then
    eval "$(fzf --zsh)"
fi

# source plugins and add commands to the PATH
zplug load

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 1Password CLI Shell completion
if type "op" > /dev/null; then
  eval "$(op completion zsh)"; compdef _op op
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  if type "oh-my-posh" > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin_mocha.toml)"
  fi
fi

# atuin
if type "atuin" > /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)";
fi

# direnv
if type "direnv" > /dev/null; then
  eval "$(direnv hook zsh)"
fi
