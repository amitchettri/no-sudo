#!/usr/bin/env bash
set -e

pre_pro=( wget unzip tar pip3 gpg2 gcc )
for prog in "${pre_pro[@]}"
do
if ! hash "${prog}" &>/dev/null ; then
	echo "${prog}" not Installed
    exit 1
fi
done

TEMP_DOWNLOAD_PATH="$HOME/.tmp/userapps"
SOURCE_PACKAGE_PATH="$HOME/.local/src"
PATH_TO_LOCAL_PREFX="$HOME/.local"

mkdir -p "$TEMP_DOWNLOAD_PATH" "$SOURCE_PACKAGE_PATH" "$PATH_TO_LOCAL_PREFX/share/applications"

TELEGRAM_VERSION=3.5.2
BITWARDEN_CLI_VERSION=1.21.1
BITWARDEN_VERSION=1.31.3
MATTERMOST_VERSION=5.0.4
NEOVIM_VERSION=0.6.1
JQ_VERSION=1.6
GO_VERSION=1.17.6
JDK_VERSION=17
MAVEN_VERSION=3.8.4
NODE_JS_VERSION=16.13.2
NCURSES_VERSION=6.3
ZSH_VERSION=5.8
VSCODE_VERSION=1.64.2

unset TELEGRAM_DOWNLOAD_URL
unset BITWARDEN_CLI_DOWNLOAD_URL
unset BITWARDEN_DOWNLOAD_URL
unset MATTERMOST_DOWNLOAD_URL
unset POSTMAN_DOWNLOAD_URL
unset NEOVIM_DOWNLOAD_URL
unset JQ_DOWNLOAD_URL
unset GO_DOWNLOAD_URL
unset JDK_DOWNLOAD_URL
unset MAVEN_DOWNLOAD_URL
unset NODE_JS_DOWNLOAD_URL
unset NCURSES_DOWNLOAD_URL
unset ZSH_DOWNLOAD_URL
unset VSCODE_DOWNLOAD_URL

if [[  "$(uname -m)" == 'x86_64'  ]]; then

BITWARDEN_CLI_DOWNLOAD_URL="https://github.com/bitwarden/cli/releases/download/v${BITWARDEN_CLI_VERSION}/bw-linux-${BITWARDEN_CLI_VERSION}.zip"
BITWARDEN_DOWNLOAD_URL="https://github.com/bitwarden/desktop/releases/download/v${BITWARDEN_VERSION}/Bitwarden-${BITWARDEN_VERSION}-x86_64.AppImage"
MATTERMOST_DOWNLOAD_URL="https://releases.mattermost.com/desktop/${MATTERMOST_VERSION}/mattermost-desktop-${MATTERMOST_VERSION}-linux-x64.tar.gz?src=dl"
POSTMAN_DOWNLOAD_URL="https://dl.pstmn.io/download/latest/linux64"
NEOVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim-linux64.tar.gz"
JQ_DOWNLOAD_URL="https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64"
GO_DOWNLOAD_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
JDK_DOWNLOAD_URL="https://download.oracle.com/java/${JDK_VERSION}/latest/jdk-${JDK_VERSION}_linux-x64_bin.tar.gz"
MAVEN_DOWNLOAD_URL="https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz"
NODE_JS_DOWNLOAD_URL="https://nodejs.org/dist/v$NODE_JS_VERSION/node-v$NODE_JS_VERSION-linux-x64.tar.xz"
NCURSES_DOWNLOAD_URL="https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz"
ZSH_DOWNLOAD_URL="https://onboardcloud.dl.sourceforge.net/project/zsh/zsh/$ZSH_VERSION/zsh-$ZSH_VERSION.tar.xz"
VSCODE_DOWNLOAD_URL="https://update.code.visualstudio.com/$VSCODE_VERSION/linux-x64/stable"
TELEGRAM_DOWNLOAD_URL="https://updates.tdesktop.com/tlinux/tsetup.${TELEGRAM_VERSION}.tar.xz"
fi

read -n1 -p "Enter \"Y\" to install pip wheel setuptools (Press any other key to Skip*) : " install_pip
echo ""
read -n1 -p "Enter \"Y\" to Re-download Telegram $TELEGRAM_VERSION (Press any other key to Skip*) : " redownload_telegram
echo ""
read -n1 -p "Enter \"Y\" to install Bitwarden $BITWARDEN_VERSION (Press any other key to Skip*) : " install_bitwarden_app_image
echo ""
read -n1 -p "Enter \"Y\" to install Bitwarden Command-line Interface $BITWARDEN_CLI_VERSION (Press any other key to Skip*) : " install_bitwarden_cli
echo ""
read -n1 -p "Enter \"Y\" to install Mattermost $MATTERMOST_VERSION (Press any other key to Skip*) : " install_mattermost
echo ""
read -n1 -p "Enter \"Y\" to install postman (Press any other key to Skip*) : " install_postman
echo ""
read -n1 -p "Enter \"Y\" to install neo vim $NEOVIM_VERSION (Press any other key to Skip*) : " install_neovim
echo ""

## Neovim requires nodejs
if [[ "$install_neovim" == "Y" || "$install_neovim" == "y" ]]; then
echo "Neovim COC requires nodejs"
install_node_js=y
else
read -n1 -p "Enter \"Y\" to install node js $NODE_JS_VERSION (Press any other key to Skip*) : " install_node_js
echo ""
fi

read -n1 -p "Enter \"Y\" to install Jq $JQ_VERSION (Press any other key to Skip*) : " install_jq
echo ""
read -n1 -p "Enter \"Y\" to install go $GO_VERSION (Press any other key to Skip*) : " install_go
echo ""
read -n1 -p "Enter \"Y\" to install JDK $JDK_VERSION (Press any other key to Skip*) : " install_jdk
echo ""
read -n1 -p "Enter \"Y\" to install maven $MAVEN_VERSION (Press any other key to Skip*) : " install_maven
echo ""
read -n1 -p "Enter \"Y\" to install vscode $VSCODE_VERSION (Press any other key to Skip*) : " install_vscode
echo ""
read -n1 -p "Enter \"YES\" to install ncurses $NCURSES_VERSION (Press any other key to Skip*) : " install_ncurses
echo ""
read -n1 -p "Enter \"YES\" to install zsh $ZSH_VERSION (Press any other key to Skip*) : " install_zsh
echo ""

if [[ "$install_pip" == "Y" || "$install_pip" == "y" ]]; then
echo "Updating Python packages"
$(readlink -f $(which python3)) -m pip install wheel setuptools pip virtualenv jedi --user --upgrade
echo "Pip Packages installed"
fi

if [[ "$install_bitwarden_app_image" == "Y" || "$install_bitwarden_app_image" == "y" ]]; then
echo "# Bitwarden Desktop Application Start"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop"

if [ ! -f "$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-${BITWARDEN_VERSION}.AppImage" ]; then
    wget --no-check-certificate "$BITWARDEN_DOWNLOAD_URL" -O "$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-${BITWARDEN_VERSION}.AppImage"
fi

if [ ! -f "$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-Icon-${BITWARDEN_VERSION}.png" ]; then
    wget --no-check-certificate "https://raw.githubusercontent.com/bitwarden/brand/master/icons/square-48x48.png" -O "$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-Icon-${BITWARDEN_VERSION}.png"
fi

chmod +x "$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-${BITWARDEN_VERSION}.AppImage"

cat <<EOT > "$PATH_TO_LOCAL_PREFX/share/applications/bitwarden-desktop-userapps.desktop"
[Desktop Entry]
Name=Bitwarden - Userapps
Exec=$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-${BITWARDEN_VERSION}.AppImage
Icon=$PATH_TO_LOCAL_PREFX/share/bitwarden-desktop/Bitwarden-Icon-${BITWARDEN_VERSION}.png
Version=$BITWARDEN_VERSION
Terminal=false
Type=Application
StartupWMClass=Bitwarden
GenericName=Password Manager
Comment=A secure and free password manager for all of your devices.
MimeType=x-scheme-handler/bitwarden;
Categories=Utility;
EOT
echo "# Bitwarden Desktop Application End"
fi

if [[ "$install_bitwarden_cli" == "Y" || "$install_bitwarden_cli" == "y" ]]; then
echo "# Bitwarden CLI Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/bin/bw"

if [ ! -f "$TEMP_DOWNLOAD_PATH/bw-linux-$BITWARDEN_CLI_VERSION.zip" ]; then
    wget --no-check-certificate "$BITWARDEN_CLI_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/bw-linux-$BITWARDEN_CLI_VERSION.zip"
fi

unzip -o "$TEMP_DOWNLOAD_PATH/bw-linux-$BITWARDEN_CLI_VERSION.zip" -d "$PATH_TO_LOCAL_PREFX/bin/"
chmod +x "$PATH_TO_LOCAL_PREFX/bin/bw"
echo "# Bitwarden CLI Install END"
fi

if [[ "$install_mattermost" == "Y" || "$install_mattermost" == "y" ]]; then
echo "# Mattermost Desktop Application Start"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/mattermost-desktop"

if [ ! -f "$TEMP_DOWNLOAD_PATH/mattermost-desktop-$MATTERMOST_VERSION.tar.gz" ]; then
    wget --no-check-certificate "$MATTERMOST_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/mattermost-desktop-$MATTERMOST_VERSION.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/mattermost-desktop-$MATTERMOST_VERSION.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/mattermost-desktop" --strip-components 1

cat <<EOT > "$PATH_TO_LOCAL_PREFX/share/applications/mattermost-desktop-userapps.desktop"
[Desktop Entry]
Type=Application
Version=$MATTERMOST_VERSION
Name=Mattermost - Userapps
Comment=Mattermost is a secure, open source platform for communication, collaboration, and workflow orchestration across tools and teams.
Path=$PATH_TO_LOCAL_PREFX/share/mattermost-desktop
Exec=$PATH_TO_LOCAL_PREFX/share/mattermost-desktop/mattermost-desktop
Icon=$PATH_TO_LOCAL_PREFX/share/mattermost-desktop/app_icon.png
Terminal=false
Categories=Office;Network;WebBrowser;
EOT
echo "# Mattermost Desktop Application End"
fi

if [[ "$redownload_telegram" == "Y" || "$redownload_telegram" == "y" ]]; then
echo "# Telegram Desktop Application Start"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp" "$PATH_TO_LOCAL_PREFX/share/TelegramDesktop/"

if [ ! -f "$TEMP_DOWNLOAD_PATH/telegram-desktop-$TELEGRAM_VERSION.tar.xz" ]; then
    wget --no-check-certificate "$TELEGRAM_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/telegram-desktop-$TELEGRAM_VERSION.tar.xz"
fi

tar -xf "$TEMP_DOWNLOAD_PATH/telegram-desktop-$TELEGRAM_VERSION.tar.xz" -C "$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp" --strip-components 1

if [ ! -f "$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp/Telegram-Icon-${TELEGRAM_VERSION}.png" ]; then
    wget --no-check-certificate "https://avatars.githubusercontent.com/u/6113871?s=200&v=4" -O "$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp/Telegram-Icon-${TELEGRAM_VERSION}.png"
fi

cat <<EOT > "$PATH_TO_LOCAL_PREFX/share/applications/telegram-desktop-userapps.desktop"
[Desktop Entry]
Version=$TELEGRAM_VERSION
Name=Telegram Desktop - Userapps
Comment=Official desktop version of Telegram messaging app
TryExec=$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp/Telegram
Exec=$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp/Telegram -workdir $PATH_TO_LOCAL_PREFX/share/TelegramDesktop/ -- %u
Icon=$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp/Telegram-Icon-${TELEGRAM_VERSION}.png
Terminal=false
StartupWMClass=TelegramDesktop
Type=Application
Categories=Chat;Network;InstantMessaging;Qt;
MimeType=x-scheme-handler/tg;
Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
Actions=Quit;
SingleMainWindow=true
X-GNOME-UsesNotifications=true
X-GNOME-SingleWindow=true

[Desktop Action Quit]
Exec=$PATH_TO_LOCAL_PREFX/share/telegram-desktop-userapp/Telegram -workdir $PATH_TO_LOCAL_PREFX/share/TelegramDesktop/ -quit
Name=Quit Telegram - Userapps
Icon=application-exit
EOT
echo "# Telegram Desktop Application End"
fi

if [[ "$install_postman" == "Y" || "$install_postman" == "y" ]]; then
echo "# Postman Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/share/Postman"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/Postman"

if [ ! -f "$TEMP_DOWNLOAD_PATH/postman.tar.gz" ]; then
    wget --no-check-certificate "$POSTMAN_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/postman.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/postman.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/Postman" --strip-components 1

cat <<EOT > "$PATH_TO_LOCAL_PREFX/share/applications/postman-userapps.desktop"
[Desktop Entry]
Encoding=UTF-8
Name=Postman - Userapps
Exec=$PATH_TO_LOCAL_PREFX/share/Postman/app/Postman %U
Icon=$PATH_TO_LOCAL_PREFX/share/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOT

echo "# Postman Install END"
fi

if [[ "$install_node_js" == "Y" || "$install_node_js" == "y" ]]; then
echo "# Node JS Install Start"

mkdir -p "$PATH_TO_LOCAL_PREFX/share/node"

if [ ! -f "$TEMP_DOWNLOAD_PATH/nodejs-${NODE_JS_VERSION}.linux.tar.xz" ]; then
    wget --no-check-certificate "${NODE_JS_DOWNLOAD_URL}" -O "$TEMP_DOWNLOAD_PATH/nodejs-${NODE_JS_VERSION}.linux.tar.xz"
fi

tar -xf "$TEMP_DOWNLOAD_PATH/nodejs-${NODE_JS_VERSION}.linux.tar.xz" -C "$PATH_TO_LOCAL_PREFX/share/node" --strip-components 1

echo "# Node JS Install End"
fi

if [[ "$install_neovim" == "Y" || "$install_neovim" == "y" ]]; then
echo "# Install neovim Start"

source "$HOME/.bashrc"

rm -rf "$PATH_TO_LOCAL_PREFX/bin/nvim"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/nvim/"

if [ ! -f "$TEMP_DOWNLOAD_PATH/nvim-$NEOVIM_VERSION.tar.gz" ]; then
    wget --no-check-certificate "$NEOVIM_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/nvim-$NEOVIM_VERSION.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/nvim-$NEOVIM_VERSION.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/nvim/" --strip-components 1
ln -s "$PATH_TO_LOCAL_PREFX/share/nvim/bin/nvim" "$PATH_TO_LOCAL_PREFX/bin/nvim"

echo "Installing vim plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

"$PATH_TO_LOCAL_PREFX/bin/nvim" --headless +PlugInstall +qa

npm install -g yarn

yarn --cwd "$PATH_TO_LOCAL_PREFX/share/nvim/plugged/coc.nvim" install

yarn --cwd "$PATH_TO_LOCAL_PREFX/share/nvim/plugged/coc.nvim" build

python3 -m pip install --user --upgrade jedi

"$PATH_TO_LOCAL_PREFX/bin/nvim" --headless +"CocInstall coc-python" +qa

echo "# Install neovim END"
fi

if [[ "$install_jq" == "Y" || "$install_jq" == "y" ]]; then
echo "# JQ Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/bin/jq"

if [ ! -f "$TEMP_DOWNLOAD_PATH/jq-$JQ_VERSION" ]; then
    wget --no-check-certificate "$JQ_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/jq-$JQ_VERSION"
fi
cp "$TEMP_DOWNLOAD_PATH/jq-$JQ_VERSION" "$PATH_TO_LOCAL_PREFX/bin/jq"
chmod +x "$PATH_TO_LOCAL_PREFX/bin/jq"
echo "# JQ Install end"
fi

if [[ "$install_go" == "Y" || "$install_go" == "y" ]]; then
echo "# GO Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/share/go"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/go"

if [ ! -f "$TEMP_DOWNLOAD_PATH/go-$GO_VERSION.linux.tar.gz" ]; then
    wget --no-check-certificate "$GO_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/go-$GO_VERSION.linux.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/go-$GO_VERSION.linux.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/go" --strip-components 1

echo "# GO Install End"
fi


if [[ "$install_jdk" == "Y" || "$install_jdk" == "y" ]]; then
echo "# JDK Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/share/java"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/java"

if [ ! -f "$TEMP_DOWNLOAD_PATH/jdk-${JDK_VERSION}.linux.tar.gz" ]; then
    wget --no-check-certificate "${JDK_DOWNLOAD_URL}" -O "$TEMP_DOWNLOAD_PATH/jdk-${JDK_VERSION}.linux.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/jdk-${JDK_VERSION}.linux.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/java" --strip-components 1

echo "# JDK Install End"
fi

if [[ "$install_maven" == "Y" || "$install_maven" == "y" ]]; then
echo "# Maven Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/share/maven"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/maven"

if [ ! -f "$TEMP_DOWNLOAD_PATH/mvn-${MAVEN_VERSION}.linux.tar.gz" ]; then
    wget --no-check-certificate "${MAVEN_DOWNLOAD_URL}" -O "$TEMP_DOWNLOAD_PATH/mvn-${MAVEN_VERSION}.linux.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/mvn-${MAVEN_VERSION}.linux.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/maven" --strip-components 1

echo "# Maven Install End"
fi

if [[ "$install_vscode" == "Y" || "$install_vscode" == "y" ]]; then
echo "# VSCODE Install Start"

rm -rf "$PATH_TO_LOCAL_PREFX/share/vscode" "$PATH_TO_LOCAL_PREFX/bin/code"
mkdir -p "$PATH_TO_LOCAL_PREFX/share/vscode"

if [ ! -f "$TEMP_DOWNLOAD_PATH/vscode-$VSCODE_VERSION.linux.tar.gz" ]; then
    wget --no-check-certificate "$VSCODE_DOWNLOAD_URL" -O "$TEMP_DOWNLOAD_PATH/vscode-$VSCODE_VERSION.linux.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/vscode-$VSCODE_VERSION.linux.tar.gz" -C "$PATH_TO_LOCAL_PREFX/share/vscode" --strip-components 1

cat <<EOT > "$PATH_TO_LOCAL_PREFX/share/applications/code-userapps.desktop"
[Desktop Entry]
Name=Visual Studio Code - Userapps
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$PATH_TO_LOCAL_PREFX/share/vscode/code --no-sandbox --unity-launch %F
Icon=com.visualstudio.code
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;application/x-code-workspace;
Actions=new-empty-window;
Keywords=vscode;

[Desktop Action new-empty-window]
Name=New Empty Window - Userapps
Exec=$PATH_TO_LOCAL_PREFX/share/vscode/code --no-sandbox --new-window %F
Icon=com.visualstudio.codevisualstudio.code
EOT

cat <<EOT > "$PATH_TO_LOCAL_PREFX/share/applications/code-url-handler-userapps.desktop"
[Desktop Entry]
Name=Visual Studio Code - URL Handler - Userapps
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$PATH_TO_LOCAL_PREFX/share/vscode/code --no-sandbox --open-url %U
Icon=com.visualstudio.code
Type=Application
NoDisplay=true
StartupNotify=true
Categories=Utility;TextEditor;Development;IDE;
MimeType=x-scheme-handler/vscode;
Keywords=vscode;
EOT

ln -s "$PATH_TO_LOCAL_PREFX/share/vscode/bin/code" "$PATH_TO_LOCAL_PREFX/bin/code"
chmod +x "$PATH_TO_LOCAL_PREFX/bin/code"

echo "# VSCODE Install End"
fi

if [[ "$install_ncurses" == "YES" ]]; then
echo "# Ncurses Install Start"

rm -rf "$SOURCE_PACKAGE_PATH/ncurses"
mkdir -p "$SOURCE_PACKAGE_PATH/ncurses"

export CXXFLAGS=' -fPIC'
export CFLAGS=' -fPIC'

if [ ! -f "$TEMP_DOWNLOAD_PATH/ncurses-${NCURSES_VERSION}.linux.tar.gz" ]; then
    wget --no-check-certificate "${NCURSES_DOWNLOAD_URL}" -O "$TEMP_DOWNLOAD_PATH/ncurses-${NCURSES_VERSION}.linux.tar.gz"
fi

tar -zxf "$TEMP_DOWNLOAD_PATH/ncurses-${NCURSES_VERSION}.linux.tar.gz" -C "$SOURCE_PACKAGE_PATH/ncurses" --strip-components 1

cd "$SOURCE_PACKAGE_PATH/ncurses"
"./configure" --prefix="$PATH_TO_LOCAL_PREFX" --enable-shared --with-shared --without-debug --enable-widec
cd progs
./capconvert
cd ..
make
make install
unset CXXFLAGS
unset CFLAGS
source "$HOME/.bashrc"
echo "# Ncurses Install end"
fi

if [[ "$install_zsh" == "YES" ]]; then
echo "# ZSH Install Start"

rm -rf "$SOURCE_PACKAGE_PATH/zsh"
mkdir -p "$SOURCE_PACKAGE_PATH/zsh"

if [ ! -f "$TEMP_DOWNLOAD_PATH/zsh-${ZSH_VERSION}.linux.tar.xz" ]; then
    wget --no-check-certificate "${ZSH_DOWNLOAD_URL}" -O "$TEMP_DOWNLOAD_PATH/zsh-${ZSH_VERSION}.linux.tar.xz"
fi

tar -xf "$TEMP_DOWNLOAD_PATH/zsh-${ZSH_VERSION}.linux.tar.xz" -C "$SOURCE_PACKAGE_PATH/zsh" --strip-components 1

cd "$SOURCE_PACKAGE_PATH/zsh"

export CFLAGS=-I$HOME/.local/include
export CPPFLAGS="-I$HOME/.local/include" LDFLAGS="-L$HOME/.local/lib"

"./configure" --prefix="$PATH_TO_LOCAL_PREFX"
make
make install

unset CFLAGS
unset CPPFLAGS

echo "# ZSH Install end"
fi
