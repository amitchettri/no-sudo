#!/usr/bin/env bash
set -e

if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo "Virtual env detected!!!! Error"
    exit 1
fi

export PATH="${HOME}/.local/bin:${PATH}"

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

if [[ ! -d  "${PWD}/venv"  ]]; then
    virtualenv venv
    source venv/bin/activate
    pip install -r requirements.txt --upgrade
else
    source venv/bin/activate
    pip install -r requirements.txt --upgrade
fi

ansible-playbook site.yml
