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

## Jetbrains IntelliJ IDEA Ultimate

Variables
 |  |
pv_jb_ideaui_install_path | Install Path |

- pv_jb_ideaui_version
  - Description: Version of [Jetbrains IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/)
  - Default: Dynamically find the latest  form [updates xml](https://www.jetbrains.com/updates/updates.xml)

- pv_jb_ideaui_version
  - Description: Install Path
  - Default: `{{ pv_ua_user_share_dir }}/IdeaUltimate-{{ pv_jb_ideaui_version }}`

Icon Path: `{{ pv_ua_user_share_dir }}/IdeaUltimate-{{ pv_jb_ideaui_version }}-userapps.desktop`
