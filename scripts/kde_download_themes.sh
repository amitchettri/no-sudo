#!/bin/bash
set -e

__kde_tmp_dir=${HOME}/.tmp/kde

mkdir -p ${__kde_tmp_dir}

echo "Download nordic themes"
if [[ ! -f "${__kde_tmp_dir}/Nordic.zip" ]]; then
    wget https://github.com/EliverLara/Nordic/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/Nordic.zip
fi
mkdir -p ${HOME}/.local/share/themes/Nordic
unzip -o ${__kde_tmp_dir}/Nordic.zip -d ${__kde_tmp_dir}
cp -r ${__kde_tmp_dir}/Nordic-master/. ${HOME}/.local/share/themes/Nordic
echo "Copy resources"
mkdir -p ${HOME}/.local/share/aurorae/themes/Nordic
cp -r ${HOME}/.local/share/themes/Nordic/kde/aurorae/Nordic/. ${HOME}/.local/share/aurorae/themes/Nordic
mkdir -p ${HOME}/.local/share/color-schemes
cp -r ${HOME}/.local/share/themes/Nordic/kde/colorschemes/. ${HOME}/.local/share/color-schemes
mkdir -p ${HOME}/.local/share/plasma/look-and-feel
cp -r ${HOME}/.local/share/themes/Nordic/kde/plasma/look-and-feel/. ${HOME}/.local/share/plasma/look-and-feel
mkdir -p ${HOME}/.config/Kvantum
cp -r ${HOME}/.local/share/themes/Nordic/kde/kvantum/. ${HOME}/.config/Kvantum
mkdir -p ${HOME}/.local/share/konsole/
cp -r ${HOME}/.local/share/themes/Nordic/kde/konsole/. ${HOME}/.local/share/konsole/
mkdir -p ${HOME}/.local/share/icons/Nordic-cursors/
cp -r ${HOME}/.local/share/themes/Nordic/kde/cursors/Nordic-cursors/. ${HOME}/.local/share/icons/Nordic-cursors/

echo "Download Nordic KDE"
if [[ ! -f "${__kde_tmp_dir}/Nordic-kde.zip" ]]; then
    wget https://github.com/EliverLara/Nordic-kde/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/Nordic-kde.zip
fi
mkdir -p ${HOME}/.local/share/plasma/desktoptheme/Nordic
unzip -o ${__kde_tmp_dir}/Nordic-kde.zip -d ${__kde_tmp_dir}
cp -r ${__kde_tmp_dir}/Nordic-kde-master/. ${HOME}/.local/share/plasma/desktoptheme/Nordic

echo "Download and install Tela icon"
if [[ ! -f "${__kde_tmp_dir}/Tela-icon-theme.zip" ]]; then
    wget https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/Tela-icon-theme.zip
fi
unzip -o ${__kde_tmp_dir}/Tela-icon-theme.zip -d ${__kde_tmp_dir}
echo "install tela"
${__kde_tmp_dir}/Tela-icon-theme-master/install.sh -a

echo "Candy Icon"
if [[ ! -f "${__kde_tmp_dir}/candy-icons.zip" ]]; then
    wget https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/candy-icons.zip
fi
unzip -o ${__kde_tmp_dir}/candy-icons.zip -d ${__kde_tmp_dir}
mkdir -p ${HOME}/.local/share/icons/candy-icons/
cp -r ${__kde_tmp_dir}/candy-icons-master/. ${HOME}/.local/share/icons/candy-icons/

echo "Layan-kde"
if [[ ! -f "${__kde_tmp_dir}/Layan-kde.zip" ]]; then
    wget https://github.com/vinceliuice/Layan-kde/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/Layan-kde.zip
fi
unzip -o ${__kde_tmp_dir}/Layan-kde.zip -d ${__kde_tmp_dir}
cd ${__kde_tmp_dir}/Layan-kde-master
./install.sh

echo "Layan-cursors"
if [[ ! -f "${__kde_tmp_dir}/Layan-cursors.zip" ]]; then
    wget https://github.com/vinceliuice/Layan-cursors/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/Layan-cursors.zip
fi
unzip -o ${__kde_tmp_dir}/Layan-cursors.zip -d ${__kde_tmp_dir}
cd ${__kde_tmp_dir}/Layan-cursors-master
./install.sh

echo "Layan-gtk-theme"
if [[ ! -f "${__kde_tmp_dir}/Layan-gtk-theme.zip" ]]; then
    wget https://github.com/vinceliuice/Layan-gtk-theme/archive/refs/heads/master.zip -O ${__kde_tmp_dir}/Layan-gtk-theme.zip
fi
unzip -o ${__kde_tmp_dir}/Layan-gtk-theme.zip -d ${__kde_tmp_dir}
cd ${__kde_tmp_dir}/Layan-gtk-theme-master
./install.sh

echo "Download Sweet mars"
if [[ ! -f "${__kde_tmp_dir}/Sweet-mars.zip" ]]; then
    wget https://github.com/EliverLara/Sweet/archive/refs/heads/mars.zip -O ${__kde_tmp_dir}/Sweet-mars.zip
fi
unzip -o ${__kde_tmp_dir}/Sweet-mars.zip -d ${__kde_tmp_dir}
mkdir -p ${HOME}/.local/share/themes/Sweet
cp -r ${__kde_tmp_dir}/Sweet-mars/. ${HOME}/.local/share/themes/Sweet-mars
echo "Copy resources"
mkdir -p ${HOME}/.local/share/aurorae/themes/
cp -r ${HOME}/.local/share/themes/Sweet-mars/kde/aurorae/. ${HOME}/.local/share/aurorae/themes/
mkdir -p ${HOME}/.local/share/color-schemes
cp -r ${HOME}/.local/share/themes/Sweet-mars/kde/colorschemes/. ${HOME}/.local/share/color-schemes
mkdir -p ${HOME}/.local/share/plasma/
cp -r ${HOME}/.local/share/themes/Sweet-mars/kde/plasma/. ${HOME}/.local/share/plasma/
mkdir -p ${HOME}/.config/Kvantum
cp -r ${HOME}/.local/share/themes/Sweet-mars/kde/kvantum/. ${HOME}/.config/Kvantum
mkdir -p ${HOME}/.local/share/konsole/
cp -r ${HOME}/.local/share/themes/Sweet-mars/kde/konsole/. ${HOME}/.local/share/konsole/

gtk-update-icon-cache
gtk4-update-icon-cache

echo "Done"
