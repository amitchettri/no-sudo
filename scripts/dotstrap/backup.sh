#!/usr/bin/env bash
set -e

__backup_directory="${HOME}/.backup/dotfiles-$(date +%s)"

echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "          Backup existing dotfiles which are tracking in dotfiles"
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""

echo ""
echo "Backup directory ${__backup_directory}"
echo ""
read -n1 -p "Enter \"Y\" to backup existing files before applying (Press any other key to Skip*) : " __backup_existing_files
echo ""

if [[ "${__backup_existing_files}" == "Y" || "${__backup_existing_files}" == "y" ]]; then

  mkdir -p "${__backup_directory}"

  # __files_to_backup=( $(git --git-dir="${HOME}/.dotbare" --work-tree=${HOME} ls-files) )

  __files_to_backup=(
      ".bash_it/themes/makemyarch/makemyarch.theme.bash"
      ".config/Code/User/keybindings.json"
      ".config/Code/User/settings.json"
      ".config/konsave/profiles/nordic"
      ".config/nvim/init.vim"
      ".config/systemd/user/google-drive.service"
      ".config/systemd/user/google-photos.service"
      ".config/systemd/user/onedrive.service"
      ".config/systemd/user/work-drive.service"
      ".config/terminator/config"
      ".config/konsolerc"
      ".gnupg/gpg-agent.conf"
      ".gnupg/sshcontrol"
      ".local/share/konsole/arpanrec.keytab"
      ".local/share/konsole/arpanrec.profile"
      ".local/share/konsole/BlackOnLightYellow.colorscheme"
      ".local/share/konsole/GreenOnBlack.colorscheme"
      ".local/share/konsole/Nordic.colorscheme"
      ".local/share/konsole/Solarized.colorscheme"
      ".setup"
      ".ssh/config"
      ".symbolic/gitconfig"
      ".gitconfig"
      ".aliasrc"
      ".bash_profile"
      ".bashrc"
      ".exporterrc"
      ".p10k.zsh"
      ".zshrc"
  )

  for file_to_backup in ${__files_to_backup[@]}; do
    echo "Backup ${HOME}/${file_to_backup}"
    if [[ -f "${HOME}/${file_to_backup}" || -d "${HOME}/${file_to_backup}" ]]; then
      echo "Backing up to ${__backup_directory}/${file_to_backup}"
      mkdir -p "$(dirname "${__backup_directory}/${file_to_backup}")"
      cp -r ${HOME}/${file_to_backup} ${__backup_directory}/${file_to_backup}
    else
      echo "File not found"
    fi
  done

fi

echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "          Completed backup existing dotfiles which are tracking in dotfiles"
echo ""
echo "-----------------------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo ""
