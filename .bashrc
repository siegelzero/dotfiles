# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# avoid duplicates
export HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=~/.bash_eternal_history

# allow tests run via invoke to use pseudoterminal for debugging
export INVOKE_RUN_PTY=1

# After each command, append to the history file and reread it
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Append to history after each command.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

PS1='\[\033[0;32m\]╔═[\[\033[0m\033[0;36m\]\u\[\033[0;32m\]@\[\033[0m\033[0;36m\]\h\[\033[0;32m\]]═[\[\033[0m\033[0;36m\]\w\[\033[0;32m\]]\n\[\033[0;32m\]╚═══[\[\033[0m\033[0;36m\]\$\[\033[0;32m\]]>\[\033[0m\] '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias u='cd ..'
alias uu='cd ../..'
alias wv='wavpack -hhmx3 *.wav && wvunpack -v *.wv && wvgain -a *.wv'
#alias djvubind='/home/kbrown/bin/djvubind/bin/djvubind'
alias eim='emacs -nw'
alias vim='nvim'

alias lynder="~/git/lynder/lynder.py"

#function decompress_flac() {
#    for FILE in *.flac
#    do
#        flac -d "$FILE" &
#    done;
#}

#function compress_wav_to_wv() {
#    for FILE in *.wav
#    do
#        wavpack -hhmx3 "$FILE" &
#    done;
#}

#function process_wv() {
#    wvunpack -v *.wv && wvgain -a *.wv;
#}

#function wv() {
#    decompress_flac && compress_wav_to_wv && process_wv;
#}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias pack='ag --python -B4 -C4'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function venv() {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "(venv:$venv) "
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

function dkillall() {
    docker rm -f $(docker ps -a -q)
}
