#!/bin/bash
set -e

__tmp_dir=${HOME}/.tmp/fonts

echo "Installing nerd hack font"

__nerd_fonts_release=$(curl -s -H \
    "Accept: application/vnd.github.v3+json" https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | jq .tag_name -r)

if [[  ! -f "${__tmp_dir}/nerd-fonts-Hack-${__nerd_fonts_release}.zip" ]]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/${__nerd_fonts_release}/Hack.zip \
     -O ${__tmp_dir}/nerd-fonts-Hack-${__nerd_fonts_release}.zip
fi

mkdir -p ${__tmp_dir}/nerd-fonts-Hack-${__nerd_fonts_release}
unzip -o ${__tmp_dir}/nerd-fonts-Hack-${__nerd_fonts_release}.zip -d ${__tmp_dir}/nerd-fonts-Hack-${__nerd_fonts_release}

mkdir -p ${HOME}/.local/share/fonts/
cp -r ${__tmp_dir}/nerd-fonts-Hack-${__nerd_fonts_release}/*.ttf ${HOME}/.local/share/fonts/

fc-cache -v ${HOME}/.local/share/fonts/

echo "Nerd hack font install done"
