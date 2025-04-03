# Neovim

## Contents

- [Screenshot](#screenshot)
- [Requirements](#requirements)
- [Installation](#installation)
- [Mappings](#mappings)
- [Language](#language)

### Screenshot

![Neovim](neovim.png "Neovim IDE")

### Requirements

- Neovim (version >= 0.10.0), run `nvim -v` to check neovim version.
- Python3 / Nodejs / Npm / Ripgrep / Fd-find / Xclip
- Exuberant Ctags or Universal Ctags.
- Ncdu / Htop / Lazygit

```bash
# Nodejs & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install node

# Pynvim
apt install python3-pynvim

# Utils
apt install ripgrep fd-find xclip ncdu universal-ctags
```

### Installation

Backup:

```bash
bash <(curl -s https://gitlab.com/elnox/neovim/-/raw/master/utils/install) --bakup
```

Install:

```bash
bash <(curl -s https://gitlab.com/elnox/neovim/-/raw/master/utils/install) \
    --release stable --config lazy
```

Cleanup:

```bash
rm -rf ~/.config/nvim ~/.cache/nvim ~/.local/nvim ~/.local/share/nvim ~/.local/state/nvim
```

Restore:

```bash
bash <(curl -s https://gitlab.com/elnox/neovim/-/raw/master/utils/install) --restore
```

### Mappings

Leader command: \<space>

**Windows**

| Mode  | Mapping        | Action                  | Alternative     |
| --    | ---            | ---                     | --              |
| n     | C-w-Up         | Goto up window          | C-w-k           |
| n     | C-w-Down       | Goto down window        | C-w-j           |
| n     | C-w-Right      | Goto right window       | C-w-l           |
| n     | C-w-Left       | Goto left window        | C-w-h           |
| n     | leader-/       | Split horizontally      | :split          |
| n     | leader-!       | Split vertically        | :vsplit         |

**Buffers**

| Mode  | Mapping        | Action                  | Alternative      |
| --    | ---            | ---                     | --               |
| n     | leader-n       | Open new                | :enew            |
| n     | leader-Right   | Goto next               | :bnext           |
| n     | leader-Left    | Goto prev               | :bprev           |
| n     | C-Up           | Scroll backward         |                  |
| n     | C-Down         | Scroll forward          |                  |
| n     | C-b            | Scroll backward (-200)  |                  |
| n     | C-f            | Scroll forward (+200)   |                  |
| n     | leader-w       | Save file               | :write           |
| n     | leader-c       | Close file              | :quit            |
| n     | C-c            | Copy whole file         | :%y+             |

**Tabs**

| Mode  | Mapping        | Action                  | Alternative      |
| --    | ---            | ---                     | --               |
| n     | C-t            | New tab                 | :tabnew          |
| n     | C-PageUp       | Goto next               | :tabnext         |
| n     | C-PageDown     | Goto prev               | :tabprev         |

**Toggling**

| Mode  | Mapping        | Action                  | Alternative      |
| --    | ---            | ---                     | --               |
| n     | F1             | Alpha                   | :Alpha           |
| n     | F2             | Nvim tree               | :NvimTreeToggle  |
| n     | F3             | Tag bar                 | :TagbarToggle    |
| n     | F4             | Aerial                  | :AerialToggle    |
| n     | F5             | Mason                   | :Mason           |
| n     | F6             | Null ls info            | :NullLsInfo      |

**Searching**

| Mode  | Mapping        | Action                  | Alternative      |
| --    | ---            | ---                     | --               |
| n     | leader-fb      | Buffers                 | leader-b         |
| n     | leader-ff      | Files                   | leader-f         |
| n     | leader-fp      | Projects                | :Tel projects    |
| n     | leader-fg      | Live grep               | :Tel live_grep   |
| n     | leader-fn      | Notifications           | :Tel notify      |
| n     | leader-fo      | Changed                 | :Tel git_status  |
| n     | leader-fs      | Color schemes           | :Tel colorscheme |
| n     | leader-fc      | Commands                | :Tel commands    |
| n     | leader-fk      | Keymaps                 | :Tel keymaps     |
| n     | leader-fm      | Man pages               | :Tel man_pages   |

**Language Server Protocol**

| Mode  | Mapping        | Action                  | Alternative      |
| --    | ---            | ---                     | --               |
| n     | leader-l?      | Hover doc               | ?                |
| n     | leader-la      | Code action             | ga               |
| n     | leader-ld      | Goto definition         | gd               |
| n     | leader-lD      | Goto declaration        | gD               |
| n     | leader-lf      | Format buffer           | gf               |
| n     | leader-lh      | Signature helper        | gn               |
| n     | leader-li      | Goto implementation     | gi               |
| n     | leader-ln      | Goto next diagnostic    | dn               |
| n     | leader-lo      | Open Diagnostic         | do               |
| n     | leader-lp      | Goto prev diagnostic    | dp               |
| n     | leader-lr      | Get references          | gr               |
| n     | leader-ls      | Get symbols             | gs               |
| n     | leader-lS      | Workspace symbols       | gS               |
| n     | leader-lt      | Type definition         | gt               |
| n     | leader-lw      | Workspace diagnostics   | dl               |

**Terminals**

| Mode  | Mapping        | Action                  | Alternative      |
| --    | ---            | ---                     | --               |
| n     | leader-tg      | Lazygit                 |                  |
| n     | leader-tn      | Node                    |                  |
| n     | leader-tu      | Ncdu                    |                  |
| n     | leader-tt      | Htop                    |                  |
| n     | leader-tp      | Python                  |                  |
| n     | leader-tf      | Term float              |                  |
| n     | leader-th      | Term horizontal         |                  |
| n     | leader-tv      | Term vertical           |                  |

### Language

| Syntax        | LSP                   | Linter         | Format     |
| --            | ---                   | ---            | --         |
| bash          | bash-language-server  | shellcheck     | shfmt      |
| lua           | lua-language-server   | selene         | stylelua   |
| python        | python-lsp-server     | flake8         | black      |
| go            | gopls                 | golangci-lint  | goimports  |
| rust          | rust-analyzer         |                |            |
| c             | clangd                |                |            |
| perl          | perlnavigator         |                |            |
|               |                       |                |            |
