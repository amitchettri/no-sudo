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
<summary>Bitwarden Desktop</summary>

## Bitwarden Desktop

---

- Tag: `bitwarden_desktop`

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

- Ultimate Edition: `ideaiu` *(`pv_jb_idea_ideaiu_or_ideaic` = `ideaiu`)

- Community Edition: `ideaic` *(`pv_jb_idea_ideaiu_or_ideaic` = `ideaic`)

Variables:

- `pv_jb_idea_version_<ideaiu\ideaic>`
  - Description: Version of [Jetbrains IntelliJ IDEA](https://www.jetbrains.com/idea/)
  - Default: Dynamically find the latest  form [updates xml](https://www.jetbrains.com/updates/updates.xml), like `2021.3.2`

- `pv_jb_idea_install_path_<ideaiu\ideaic>`
  - Description: Install Path
  - Default: `{{  pv_ua_user_share_dir  }}/JetBrains/{{  pv_jb_idea_ideaiu_or_ideaic  }}-{{  pv_jb_idea_version  }}`

- `pv_jb_idea_icon_path_<ideaiu\ideaic>`
  - Description: Icon Path
  - Default: `{{ pv_ua_user_share_dir }}/applications/{{  pv_jb_idea_ideaiu_or_ideaic  }}-{{ pv_jb_idea_version }}-userapps.desktop`

</details>

<details>
<summary>Microsoft Visual Studio Code</summary>

## Microsoft Visual Studio Code

---

- Tag: `code`

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

- Ultimate Community: `pycharm_community` *(`pv_jb_pycharm_professional_community` = `pycharm_community`)

- Community Professional: `pycharm_professional` *(`pv_jb_pycharm_professional_community` = `pycharm_professional`)

Variables:

- `pv_jb_pycharm_version_<professional\community>`
  - Description: Version of [Jetbrains Pycharm](https://www.jetbrains.com/pycharm/)
  - Default: Dynamically find the latest  form [updates xml](https://www.jetbrains.com/updates/updates.xml), like `2021.3.2`

- `pv_jb_pycharm_install_path_<professional\community>`
  - Description: Install Path
  - Default: `{{  pv_ua_user_share_dir  }}/JetBrains/{{  pv_jb_pycharm_professional_community  }}-{{  pv_jb_pycharm_version  }}`

- `pv_jb_pycharm_desktop_icon_path_<professional\community>`
  - Description: Icon Path
  - Default: `{{ pv_ua_user_share_dir }}/applications/{{  pv_jb_pycharm_professional_community  }}-{{ pv_jb_pycharm_version }}-userapps.desktop`

</details>

<details>
<summary>Fonts</summary>

## Fonts

---

Tag: `fonts`

Install below fonts in `{{  pv_ua_user_share_dir  }}/fonts/<font-name>`

- [Hack Font](https://github.com/source-foundry/Hack)
- [Cascadia Code](https://github.com/microsoft/cascadia-code)

Variables:

- Not Applicable

</details>
