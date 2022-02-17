#!/usr/bin/env bash
set -e

${HOME}/.setup/dotstrap/backup.sh

echo ""
read -n1 -p "Enter \"Y\" to Checkout new config files (Press any other key to Skip*) : " __checkout_new_files
echo ""

if [[ "${__checkout_new_files}" == "Y" || "${__checkout_new_files}" == "y" ]]; then

    unset __checkout_new_files

    echo ""
    read -n1 -p "Are you sure this will discard existing files (Press any other key to Skip*) : " __checkout_new_files
    echo ""
    if [[ "${__checkout_new_files}" == "Y" || "${__checkout_new_files}" == "y" ]]; then

        git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}" reset --hard HEAD
        ${HOME}/.setup/dotstrap/symlink.sh
    fi
fi
