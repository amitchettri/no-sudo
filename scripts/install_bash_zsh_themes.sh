#!/usr/bin/env bash
set -e

echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "         Install/Reinstall bash_it, oh-my-zsh, powerlevel10k and fzf"
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""

echo ""
echo "If themes exists then the previous installation will be deleted"
echo "Following paths will be deleted >>"
echo "${HOME}/.bash_it"
echo "${HOME}/.oh-my-zsh"
echo "${HOME}/.fzf"
read -n1 -r -p "Enter \"Y\" to Start (Press any other key to Skip*) : " __reinstall_bash_zsh_themes
echo ""

if [ "${__reinstall_bash_zsh_themes}" != "Y" ] && [ "${__reinstall_bash_zsh_themes}" != "y" ]; then
    echo ""
    echo "Installation skipped"
    exit 0
fi

rm -rf "${HOME}/.bash_it" "${HOME}/.oh-my-zsh" "${HOME}/.fzf"

git clone --depth=1 https://github.com/Bash-it/bash-it "${HOME}/.bash_it"

git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh"

git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

git clone --depth=1 https://github.com/zsh-users/zsh-completions \
    "${ZSH_CUSTOM:-${ZSH:-${HOME}/.oh-my-zsh}/custom}/plugins/zsh-completions"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"

git clone --depth=1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"

"${HOME}/.fzf/install" --all

"${HOME}/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/install" -f

echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "         Finish installing bash_it, oh-my-zsh, powerlevel10k and fzf"
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
