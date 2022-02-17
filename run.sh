#!/usr/bin/env bash
set -e

echo "${PWD}"

exit 0

if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo "Virtual env detected!!!! Error"
    exit 1
fi

export PATH="${HOME}/.local/share/node/bin/node:${HOME}/.local/bin:${PATH}"

echo "Updating Python packages"
$(readlink -f $(which python3)) -m pip install wheel setuptools pip virtualenv jedi --user --upgrade
echo "Pip Packages installed"

pre_pro=( curl wget unzip tar pip3 gpg2 gcc )
for prog in "${pre_pro[@]}"
do
if ! hash "${prog}" &>/dev/null ; then
	echo "${prog}" not Installed
    exit 1
fi
done

echo "Updating Python packages"
$(readlink -f $(which python3)) -m pip install wheel setuptools pip virtualenv jedi --user --upgrade
echo "Pip Packages installed"

mkdir -p "${__tmp_directory}"

if [[ ! -d  "${__tmp_directory}/ansible-playbook-usersetup"  ]]; then
    git clone --depth 1 --single-branch "${__git_setup_repo}" "${__tmp_directory}/ansible-playbook-usersetup"
    cd "${__tmp_directory}/ansible-playbook-usersetup"
    virtualenv venv
    pip install -r requirements.txt
else
    cd "${__tmp_directory}/ansible-playbook-usersetup"
    git pull
fi

source venv/bin/activate
ansible-playbook site.yml
