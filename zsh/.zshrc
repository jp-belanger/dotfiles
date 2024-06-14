# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no
zstyle ':z4h:' prompt-at-bottom 'no'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)
path=(~/.cargo/bin $path)

# Export environment variables.
export GPG_TTY=$TTY
export EDITOR="vi"
export VISUAL="nvim"

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

zstyle ':z4h:fzf-dir-history' fzf-bindings tab:repeat
zstyle ':z4h:fzf-complete' fzf-bindings tab:repeat
zstyle ':z4h:cd-down' fzf-bindings tab:repeat

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# python environment
[[ -f "$HOME/.rye/env" ]] && . "$HOME/.rye/env"
function ve() {
  if [[ -v VIRTUAL_ENV ]]; then
    deactivate
  elif [[ -d ".venv" ]]; then
        . ".venv/bin/activate"
  fi
}

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
# dev
alias e="${(z)VISUAL:-${(z)EDITOR}}"
alias tree='tree -a -I .git'
alias grep="grep --color=auto"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias du="du -h"
# ls output
[[ "$OSTYPE" == "linux"* ]] && {
  alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"
}
alias l="${aliases[ls]:-ls} -1A"  # one column, hidden files.
alias ll="${aliases[ls]:-ls} -lh" # human readable sizes.
alias lr="${aliases[ll]:-ll} -R"  # human readable sizes, recursively.
alias la="${aliases[ll]:-ll} -A"  # human readable sizes, hidden files.
alias lar="${aliases[la]:-la} -R" # human readable sizes, recursively.
# git
alias gs="git status --short"
alias gS="git status"
alias ga="git add"
alias gcm="git commit --message"
alias gpu="git push -u"
alias gfo="git fetch origin"
alias gM="git merge --ff-only"
alias gd="git diff --no-ext-diff"
alias gD="git diff --no-ext-diff --word-diff"
alias gco="git checkout"
alias gsw="git switch"
alias gl="git log"
alias gbr="git branch"
alias gw="git worktree"
# tmux
alias ktm="tmux kill-server"
alias ltm="tmux list-sessions"
alias stm="tmux switch-client -t"
alias tmd="tmux detach-client"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots             # no special treatment for file names with a leading dot
unsetopt case_glob           # Use Case-Insensitve Globbing.
setopt extendedglob          # Use Extended Globbing.
setopt auto_param_slash      # If Completed Parameter Is A Directory, Add A Trailing Slash.

zstyle ':completion:*' complete true
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' group-name '' # Required for completion to be in good groups (named after the tags)
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' keep-prefix true
