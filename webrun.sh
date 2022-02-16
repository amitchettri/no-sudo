#!/usr/bin/env bash
set -e

__tmp_directory="${HOME}/.tmp"
__git_setup_repo='https://github.com/arpanrec/ansible-playbook-usersetup.git'

if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo "Virtual env detected!!!! Error"
    exit 1
fi

if [[ $(id -u) -eq 0 ]]; then
    echo "Root user detected!!!! Error"
    exit 1
fi

pre_pro=( curl wget unzip tar pip3 gpg2 gcc )
for prog in "${pre_pro[@]}"
do
if ! hash "${prog}" &>/dev/null ; then
	echo "${prog}" not Installed
    exit 1
fi
done

export PATH="${HOME}/.local/bin:${PATH}"

echo "Updating Python packages"
$(readlink -f $(which python3)) -m pip install wheel setuptools pip virtualenv jedi --user --upgrade
echo "Pip Packages installed"

mkdir -p "${__tmp_directory}"

if [[ ! -d  "${__tmp_directory}/ansible-playbook-usersetup"  ]]; then
    git clone --depth 1 --single-branch "${__git_setup_repo}" "${__tmp_directory}/ansible-playbook-usersetup"
    cd "${__tmp_directory}/ansible-playbook-usersetup"
    virtualenv venv
fi

cd "${__tmp_directory}/ansible-playbook-usersetup"
source venv/bin/activate
pip install -r requirements.txt

ansible-playbook site.yml
