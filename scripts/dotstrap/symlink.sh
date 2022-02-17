#!/usr/bin/env bash
set -e

echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "          Create Symbolic links"
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""

echo ""
echo "This will remove the existing file, make sure to backup using ${HOME}/.setup/dotstrap/backup.sh"
echo ""


#####################################
echo ""
echo "Enter your choice to create the gitconfig symlink [If present, ${HOME}/.gitconfig will be deleted] : "
echo "Press a for arpanrec git config"
echo "Press d for dummy git config"
echo "Press any other key to Skip"
read -n1 __symlink_gitconfig
echo ""

case ${__symlink_gitconfig} in

  a | A)
    rm -rf "${HOME}/.gitconfig"
    ln -s "${HOME}/.symbolic/arpanrec.gitconfig" "${HOME}/.gitconfig"
    ;;

  d | D)
    rm -rf "${HOME}/.gitconfig"
    ln -s "${HOME}/.symbolic/dummy.gitconfig" "${HOME}/.gitconfig"
    ;;

  *)
    echo -n "unknown"
    ;;
esac
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "          Symbolic links created"
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
