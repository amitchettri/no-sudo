#!/usr/bin/env bash
set -e

if [[ $(id -u) -eq 0 ]]; then
    echo "Root user detected!!!! Error"
    exit 1
fi

__install_tags=()

read -n1 -r -p "Enter \"Y\" to track dotfiles from 'https://github.com/arpanrec/dotfiles' (Press any other key to Skip*) : " install_dotfiles
echo ""
read -n1 -r -p "Enter \"Y\" to install Bash-IT, oh-my-zsh and fzf (Press any other key to Skip*) : " install_termincal_themes
echo ""
read -n1 -r -p "Enter \"Y\" to install fonts (Press any other key to Skip*) : " install_fonts
echo ""
read -n1 -r -p "Enter \"Y\" to install Telegram (Press any other key to Skip*) : " install_telegram
echo ""
read -n1 -r -p "Enter \"Y\" to install Bitwarden (Press any other key to Skip*) : " install_bitwarden_app_image
echo ""
read -n1 -r -p "Enter \"Y\" to install Bitwarden Command-line Interface (Press any other key to Skip*) : " install_bitwarden_cli
echo ""
read -n1 -r -p "Enter \"Y\" to install Mattermost (Press any other key to Skip*) : " install_mattermost
echo ""
read -n1 -r -p "Enter \"Y\" to install Postman (Press any other key to Skip*) : " install_postman
echo ""
read -n1 -r -p "Enter \"Y\" to install neo vim (Press any other key to Skip*) : " install_neovim
echo ""

## Neovim requires nodejs
if [[ "$install_neovim" == "Y" || "$install_neovim" == "y" ]]; then
echo "Neovim COC requires nodejs"
install_node_js=y
else
read -n1 -r -p "Enter \"Y\" to install node js (Press any other key to Skip*) : " install_node_js
echo ""
fi

read -n1 -r -p "Enter \"Y\" to install Jq (Press any other key to Skip*) : " install_jq
echo ""
read -n1 -r -p "Enter \"Y\" to install go (Press any other key to Skip*) : " install_go
echo ""
read -n1 -r -p "Enter \"Y\" to install Oracle JDK17 (Press any other key to Skip*) : " install_jdk
echo ""
read -n1 -r -p "Enter \"Y\" to install Apache Maven3 (Press any other key to Skip*) : " install_maven
echo ""
read -n1 -r -p "Enter \"Y\" to install Visual Studio Code (Press any other key to Skip*) : " install_vscode
echo ""

echo ""
read -n1 -r -p "Enter \"Y\" to download themes (Press any other key to Skip*) : " download_themes
echo ""

echo ""
read -n1 -r -p "Enter \"Y\" to download icons (Press any other key to Skip*) : " download_icnos
echo ""

if [[ "${install_dotfiles}" == "Y" || "${install_dotfiles}" == "y" ]]; then
    __install_tags+=('dotfiles')
fi

if [[ "${install_termincal_themes}" == "Y" || "${install_termincal_themes}" == "y" ]]; then
    __install_tags+=('terminal_themes')
fi

if [[ "$install_telegram" == "Y" || "$install_telegram" == "y" ]]; then
    __install_tags+=('telegram')
fi

if [[ "$install_fonts" == "Y" || "$install_fonts" == "y" ]]; then
    __install_tags+=('fonts')
fi

if [[ "$install_vscode" == "Y" || "$install_vscode" == "y" ]]; then
    __install_tags+=('code')
fi

if [[ "$install_bitwarden_app_image" == "Y" || "$install_bitwarden_app_image" == "y" ]]; then
    __install_tags+=('bw')
fi

if [[ "$install_bitwarden_cli" == "Y" || "$install_bitwarden_cli" == "y" ]]; then
    __install_tags+=('bw_cli')
fi

if [[ "$install_mattermost" == "Y" || "$install_mattermost" == "y" ]]; then
    __install_tags+=('mattermost')
fi

if [[ "$install_postman" == "Y" || "$install_postman" == "y" ]]; then
    __install_tags+=('postman')
fi

if [[ "$install_neovim" == "Y" || "$install_neovim" == "y" ]]; then
    __install_tags+=('nvim')
fi

if [[ "$install_node_js" == "Y" || "$install_node_js" == "y" ]]; then
    __install_tags+=('nodejs')
fi

if [[ "$install_jq" == "Y" || "$install_jq" == "y" ]]; then
    __install_tags+=('jq')
fi

if [[ "$install_go" == "Y" || "$install_go" == "y" ]]; then
    __install_tags+=('go')
fi

if [[ "$install_jdk" == "Y" || "$install_jdk" == "y" ]]; then
    __install_tags+=('jdk')
fi

if [[ "$install_maven" == "Y" || "$install_maven" == "y" ]]; then
    __install_tags+=('mvn')
fi

if [[ "$download_themes" == "Y" || "$download_themes" == "y" ]]; then
    __install_tags+=('themes')
fi

if [[ "$download_icnos" == "Y" || "$download_icnos" == "y" ]]; then
    __install_tags+=('icons')
fi

__ansible_tags_tmp=$(printf ",%s" "${__install_tags[@]}")
__ansible_tags="--tags ${__ansible_tags_tmp:1}"

if [[ -z "${VIRTUAL_ENV}" ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
    echo "Updating Python packages"
    "$(readlink -f "$(which python3)")" -m pip install wheel setuptools pip virtualenv --user --upgrade
    echo "Pip Packages installed"
    if [[ ! -d  "${PWD}/venv"  ]]; then
        virtualenv venv
    fi
    source venv/bin/activate
fi

echo ""
echo ""
echo ""
echo "Virtual Env :: ${VIRTUAL_ENV}"
echo "Working dir :: ${PWD}"
echo ""
echo ""
echo ""

pip install -r requirements.txt --upgrade

ansible-playbook site.yml ${__ansible_tags} $@
