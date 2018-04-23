# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=~/.bash_eternal_history

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#export PYTHONPATH=$PYTHONPATH:/home/kbrown/code/
export PATH=$PATH:/home/kbrown/sage/
export PATH=$PATH:/home/kbrown/magma
export PATH=$PATH:/home/kbrown/maple/bin/
export PATH=$PATH:/home/kbrown/gurobi600/linux64/bin/

export GRB_LICENSE_FILE='/home/kbrown/gurobi600/gurobi.lic'

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