#!/usr/bin/env bash
set -e

__tmp_directory="${HOME}/.tmp"
__git_setup_repo='https://github.com/arpanrec/no-sudo.git'

if [[ $(id -u) -eq 0 ]]; then
    echo "Root user detected!!!! Error"
    exit 1
fi

if ! hash git &>/dev/null ; then
	echo "git not Installed"
    exit 1
fi

mkdir -p "${__tmp_directory}"

if [[ ! -d  "${__tmp_directory}/ansible-playbook-usersetup"  ]]; then
    git clone --depth 1 --single-branch "${__git_setup_repo}" "${__tmp_directory}/ansible-playbook-usersetup"
    cd "${__tmp_directory}/ansible-playbook-usersetup"
else
    cd "${__tmp_directory}/ansible-playbook-usersetup"
    git pull
fi

./run.sh
