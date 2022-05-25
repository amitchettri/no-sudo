# No Sudo

Setup workspace for development

Path Reference

```yaml
pv_ua_user_home_dir: "${HOME}"
pv_ua_user_config_dir: "{{  pv_ua_user_home_dir  }}/.config"
pv_ua_user_local_dir: "{{  pv_ua_user_home_dir  }}/.local"
pv_ua_user_bin_dir: "{{  pv_ua_user_local_dir  }}/bin"
pv_ua_user_share_dir: "{{  pv_ua_user_local_dir  }}/share"
pv_ua_user_tmp_dir: "{{  pv_ua_user_home_dir  }}/.tmp"
```

Run the playbook

```bash
bash <(curl https://raw.githubusercontent.com/arpanrec/no-sudo/main/webrun.sh)
```

For custom/silent install tags, extra-vars are optional

```bash
bash <(curl https://raw.githubusercontent.com/arpanrec/no-sudo/main/webrun.sh) \
--tags ideaiu,code \
--extra-vars='pv_jb_idea_version=2021.3.2 pv_ua_code_version=1.64.2'
```

<details>
<summary>Track Dotfiles With GIT</summary>

## Track Dotfiles With GIT

---

Tag: `dotfiles`

Track your dotfiles from [GitHub](https://github.com/arpanrec/dotfiles). You can track these files with below command. (Follow the git commands for reference)

```shell
config pull # To pull the changes
config add <filepath> # Track new files/Changes
config commit -m"New Config added/Changed" # Track new files
config push # Push to remote
```

Variables:

- `pv_ua_dotfiles_git_remote`
  - Description: Git remote
  - Default: [arpanrec/dotfiles](https://github.com/arpanrec/dotfiles)
- `pv_ua_dotfiles_bare_relative_dir`
  - Description: Git bare directory in `{{ pv_ua_user_home_dir }}`
  - Default: `.dotfiles`

</details>

<details>
<summary>Bitwarden Desktop [Disabled by default]</summary>

## Bitwarden Desktop

---

Tag: `bitwarden_desktop`

Variables:

- `pv_ua_bitwarden_desktop_version`

  - Description: Version of [Bitwarden Desktop](https://bitwarden.com/download/) from [GitHub](https://github.com/bitwarden/desktop/releases).
  - Default: Dynamically find the [latest tag_name](https://api.github.com/repos/bitwarden/desktop/releases/latest), like `v1.31.3`.

- `pv_ua_bitwarden_desktop_install_path`

  - Description: Install Path.
  - Default: `{{ pv_ua_user_share_dir }}/bitwarden-desktop`

- `pv_ua_bitwarden_desktop_icon_path`
  - Description: Icon Path.
  - Default: `{{ pv_ua_user_share_dir }}/applications/bitwarden-desktop-userapps.desktop`

</details>

<details>
<summary>Jetbrains IntelliJ IDEA</summary>

## Jetbrains IntelliJ IDEA

---

Tags:

- Ultimate Edition: `ideaiu`  
  _Not User Input_ `pv_jb_idea_ideaiu_or_ideaic` = `ideaiu`

- Community Edition: `ideaic`  
  _Not User Input_ `pv_jb_idea_ideaiu_or_ideaic` = `ideaic`

Variables:

- `pv_jb_idea_version_<ideaiu\ideaic>`

  - Description: Version of [Jetbrains IntelliJ IDEA](https://www.jetbrains.com/idea/)
  - Default: Dynamically find the latest form [updates xml](https://www.jetbrains.com/updates/updates.xml), like `2021.3.2`

- `pv_jb_idea_install_path_<ideaiu\ideaic>`

  - Description: Install Path
  - Default: `{{ pv_ua_user_share_dir }}/JetBrains/{{ pv_jb_idea_ideaiu_or_ideaic }}-{{ pv_jb_idea_version }}`

- `pv_jb_idea_icon_path_<ideaiu\ideaic>`
  - Description: Icon Path
  - Default: `{{ pv_ua_user_share_dir }}/applications/{{ pv_jb_idea_ideaiu_or_ideaic }}-{{ pv_jb_idea_version }}-userapps.desktop`

</details>

<details>
<summary>Microsoft Visual Studio Code</summary>

## Microsoft Visual Studio Code

---

Tag: `code`

Install vscode, and extensions Also creates a soft link to the `code` executable in `{{ pv_ua_user_bin_dir }}`

Variables:

- `pv_ua_code_version`

  - Description: Version of [Microsoft Visual Studio Code](https://code.visualstudio.com/updates).
  - Default: Dynamically find the [latest tag_name](https://api.github.com/repos/microsoft/vscode/releases/latest), like `1.64.2`.

- `pv_ua_code_install_path`

  - Description: Install Path.
  - Default: `{{ pv_ua_user_share_dir }}/vscode`

- `pv_ua_code_icon_path`

  - Description: Icon Path.
  - Default: `{{ pv_ua_user_share_dir }}/applications/code-userapps.desktop`

- `pv_ua_code_uri_handler_path`

  - Description: URI Handler path
  - Default: `{{ pv_ua_user_share_dir }}/applications/code-url-handler-userapps.desktop`

- `pv_ua_code_ext_to_be_installed`
  - Description: List of VSCode extension to be installed.
  - Type: `List[String]`
  - Default: [extensions-list.yml](tasks/code/extensions-list.yml)

</details>

<details>
<summary>Jetbrains PyCharm</summary>

## Jetbrains PyCharm

---

Tags:

- Ultimate Community: `pycharm_community`  
  _Not User Input_ `pv_jb_pycharm_professional_community` = `pycharm_community`

- Community Professional: `pycharm_professional`  
  _Not User Input_ `pv_jb_pycharm_professional_community` = `pycharm_professional`

Variables:

- `pv_jb_pycharm_version_<professional\community>`

  - Description: Version of [Jetbrains Pycharm](https://www.jetbrains.com/pycharm/)
  - Default: Dynamically find the latest form [updates xml](https://www.jetbrains.com/updates/updates.xml), like `2021.3.2`

- `pv_jb_pycharm_install_path_<professional\community>`

  - Description: Install Path
  - Default: `{{ pv_ua_user_share_dir }}/JetBrains/{{ pv_jb_pycharm_professional_community }}-{{ pv_jb_pycharm_version }}`

- `pv_jb_pycharm_desktop_icon_path_<professional\community>`
  - Description: Icon Path
  - Default: `{{ pv_ua_user_share_dir }}/applications/{{ pv_jb_pycharm_professional_community }}-{{ pv_jb_pycharm_version }}-userapps.desktop`

</details>

<details>
<summary>Fonts</summary>

## Fonts

---

Tag: `fonts`

Install below fonts in `{{ pv_ua_user_share_dir }}/fonts/<font-name>`

- [Hack Font](https://github.com/source-foundry/Hack)
- [Cascadia Code](https://github.com/microsoft/cascadia-code)

Variables:

- Not Applicable

</details>

<details>
<summary>Utility Scripts</summary>

## Utility Scripts

---

Tag: `scripts`

Install [Utility Scripts](https://github.com/arpanrec/util-scripts/tree/main/bin) to `{{ pv_ua_user_bin_dir }}`

Variables:

- Not Applicable

</details>

<details>
<summary>Gnome [Disabled by default]</summary>

## Install Gnome Extensions

---

Tag: `gnome`

Variables:

- `pv_gnome_extension_list`
  - Description: List of Extensions
  - Default: [extension-list](tasks/gnome/extension-list.yml)

</details>

<details>
<summary>Terminal Themes</summary>

## Install Terminal Themes

---

- [bash_it](https://github.com/Bash-it/bash-it)
- [oh-my-zsh](https://ohmyz.sh/) ([powerlevel10k](https://github.com/romkatv/powerlevel10k), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-completions](https://github.com/zsh-users/zsh-completions))
- [fzf](https://github.com/junegunn/fzf)

Tag: `terminal_themes`

Variables:

- Not Applicable

</details>
