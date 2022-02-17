#!/bin/bash
set -e

if [ "unlocked" != $(bw status --raw | jq .status -r) ]; then
    echo "bitwarden cli is not unlocked"
    exit 0
fi

#############################################################################################################################
#############################################################################################################################

echo ""
echo "Downloading openssh key from bit warden"
echo ""
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
rm -rf /home/arpan/.ssh/arpan_id_rsa
__openssh_key_bw_item=$(bw get item "OpenSSH Key" --raw)

bw get attachment arpan_id_rsa --itemid  "$(echo "$__openssh_key_bw_item" | jq .id -r)" --raw > "$HOME/.ssh/arpan_id_rsa"

chmod 400 "$HOME/.ssh/arpan_id_rsa"
echo ""
file "$HOME/.ssh/arpan_id_rsa"
echo ""
echo ""
echo "Open SSH Key Written in $HOME/.ssh/arpan_id_rsa"
echo ""

#############################################################################################################################
#############################################################################################################################

echo ""
echo "Downloading gpg key for code signing"
echo ""

mkdir -p "$HOME/.gnupg" && chmod 700 "$HOME/.gnupg"

__git_gpg_key=$(git config --get user.signingkey)

echo ""
echo "GPG Key id attached in gitconfig $__git_gpg_key"
echo ""

__bw_git_gpg_item=$(bw get item "$__git_gpg_key")

bw get attachment "private.asc" --itemid  "$(echo "$__bw_git_gpg_item" | jq .id -r)" --raw | \
    gpg --allow-secret-key-import --import --batch --passphrase "$(echo "$__bw_git_gpg_item" | jq .login.password -r)"

echo ""
echo "Listing private keys"
echo ""
gpg -K
echo ""

#############################################################################################################################
#############################################################################################################################
