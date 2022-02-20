# ansible-playbook-userapps

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

## Jetbrains IntelliJ IDEA

---

Tags:

- Ultimate Edition: `ideaiu`

- Community Edition: `ideaic`

Variables:

- pv_jb_idea_version
  - Description: Version of [Jetbrains IntelliJ IDEA](https://www.jetbrains.com/idea/)
  - Default: Dynamically find the latest  form [updates xml](https://www.jetbrains.com/updates/updates.xml), like `2021.3.2`

- pv_jb_idea_install_path
  - Description: Install Path
  - Default: `"{{ pv_ua_user_share_dir }}/idea-{{  pv_jb_idea_ultimate_or_community  }}-{{ pv_jb_idea_version }}"`

- pv_jb_idea_icon_path
  - Description: Icon Path
  - Default: `{{ pv_ua_user_share_dir }}/applications/idea-{{  pv_jb_idea_ultimate_or_community  }}-{{ pv_jb_idea_version }}-userapps.desktop`

## Microsoft Visual Studio Code

---

- Tag: `code`

Variables:

- pv_ua_code_version
  - Description: Version of [Microsoft Visual Studio Code](https://code.visualstudio.com/updates)
  - Default: Dynamically find the latest form [github/microsoft/vscode](https://api.github.com/repos/microsoft/vscode/releases/latest), like `1.64.2`

- pv_ua_code_install_path
  - Description: Install Path
  - Default: `{{  pv_ua_user_share_dir  }}/vscode`

- pv_ua_code_icon_path
  - Description: Icon Path
  - Default: `{{  pv_ua_user_share_dir  }}/applications/code-userapps.desktop`

- pv_ua_code_uri_handler_path
  - Description: URI Handler path
  - Default: `{{  pv_ua_user_share_dir  }}/applications/code-url-handler-userapps.desktop`

- pv_ua_code_ext_to_be_installed
  - Description: List of VSCode extension to be installed
  - Type: `List[String]`
  - [Default](tasks/code/extensions-list.yml)
