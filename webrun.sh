#!/usr/bin/env bash
set -e

__clone_directory="${HOME}/.tmp/no-sudo"
__git_setup_repo='https://github.com/arpanrec/no-sudo.git'

if [[ $(id -u) -eq 0 ]]; then
    echo "Root user detected!!!! Error"
    exit 1
fi

if ! hash git &>/dev/null ; then
	echo "git not Installed"
    exit 1
fi

mkdir -p $(dirname "${__clone_directory}")

if [[ ! -d "${__clone_directory}"  ]]; then
    git clone --depth 1 --single-branch "${__git_setup_repo}" "${__clone_directory}"
    cd "${__clone_directory}"
else
    cd "${__clone_directory}"
    git pull
fi

./run.sh $@
