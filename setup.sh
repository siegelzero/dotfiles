#!/bin/bash

HOME=${HOME}
PWD=`pwd`
VUNDLE=${HOME}"/.vim/bundle/Vundle.vim"
UNDO=${HOME}"/.vim/undo"
TPM=${HOME}"/.tmux/plugins/tpm"

function create_symlinks() {
    echo "Creating symlinks"
    ln -sf ".vimrc" "${HOME}/.vimrc"
    ln -sf ".bashrc" "${HOME}/.bashrc"
    ln -sf ".tmux.conf" "${HOME}/.tmux.conf"
}

function install_vundle() {
    if [ -d "${VUNDLE}" ]; then
        echo "${VUNDLE} already exists"
    else
        echo "${VUNDLE} does not exist. Cloning from github..."
        git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLE}
        vim +PluginInstall +qall
    fi
}

function setup_undo() {
    if [ -d "${UNDO}" ]; then
        echo "${UNDO} already exists"
    else
        echo "${UNDO} does not exist. Creating now."
        mkdir -p "${UNDO}"
    fi
}

function setup_tmux() {
    if [ -d "${TPM}" ]; then
        echo "${TPM} already exists"
    else
        git clone https://github.com/tmux-plugins/tpm ${TPM}
    fi
}

function main() {
    create_symlinks
    install_vundle
    setup_undo
    setup_tmux
}

main

echo "Setup Complete."
