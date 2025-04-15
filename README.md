# Neovim

<!-- markdownlint-disable MD013 -->

## Contents

- [Screenshot](#screenshot)
- [Requirements](#requirements)
- [Installation](#installation)
- [Features](#features)
- [Languages](#languages)
- [Mappings](#mappings)

### Screenshot

![Neovim](neovim.png "Neovim IDE")

### Requirements

- Neovim (version >= 0.11.0), run `nvim -v` to check neovim version.
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

### Features

#### Core UI

| Icon | Plugin                          | Description                                                                     |
| ---- | ------------------------------- | ------------------------------------------------------------------------------- |
| 🗂   | `akinsho/bufferline.nvim`       | Tab & buffer line management with icons and separators.                         |
| 📊   | `nvim-lualine/lualine.nvim`     | Customizable statusline, with git, diagnostics, mode, date, and DAP info.       |
| 💬   | `folke/noice.nvim`              | Enhanced Neovim UI for messages, cmdline, and popupmenu.                        |
| 🖼   | `nvim-mini/mini.icons`          | Filetype and filename icons for buffers, tabs, and dashboard.                   |
| 🧩   | `MunifTanjim/nui.nvim`          | UI component library for building popup menus, layouts, and custom UI elements. |
| 🥪   | `folke/snacks.nvim`             | A collection of QOL plugins like file explorer, notifications and more.         |
| 🌅   | `goolord/alpha-nvim`            | Startup screen / dashboard with recent files, quick links, and stats.           |
| 🌀   | `yuttie/comfortable-motion.vim` | Smooth scrolling for a more visually comfortable experience.                    |

#### Core Editor

| Icon | Plugin                     | Description                                                                  |
| ---- | -------------------------- | ---------------------------------------------------------------------------- |
| 🔍   | `MagicDuck/grug-far.nvim`  | Multi-file search and replace with configurable headers.                     |
| ⚡   | `folke/flash.nvim`         | Jump to any position in the buffer using visible labels.                     |
| ⌨️   | `folke/which-key.nvim`     | Displays keybinding hints for commands, registers, marks, and custom groups. |
| 🌿   | `lewis6991/gitsigns.nvim`  | Git integration: buffer signs, staged changes, and live updates.             |
| 📝   | `folke/trouble.nvim`       | Diagnostics, references, and quickfix list in a clean UI.                    |
| 🛠️   | `folke/todo-comments.nvim` | Highlights TODO/FIX/HACK/NOTE/PERF comments with icons and colors.           |
| 🔌   | `akinsho/toggleterm.nvim`  | Integrated floating terminal with multiple terminal toggles.                 |

#### Completion

| Icon | Plugin                         | Description                                                      |
| ---- | ------------------------------ | ---------------------------------------------------------------- |
| ⚡   | `saghen/blink.cmp`             | Autocompletion engine with LSP, path, snippet, buffer sources.   |
| 🖥️   | `folke/lazydev.nvim`           | Completion provider for Blink                                    |
| 📦   | `rafamadriz/friendly-snippets` | Collection of ready-to-use code snippets for multiple languages. |
| 🎨   | `catppuccin`                   | Theme integration for Blink completion menus.                    |

#### Coding

| Icon | Plugin                   | Description                                                                             |
| ---- | ------------------------ | --------------------------------------------------------------------------------------- |
| 🧩   | `nvim-mini/mini.pairs`   | Automatically inserts matching brackets, quotes, etc...                                 |
| 💬   | `folke/ts-comments.nvim` | Advanced commenting using Treesitter for smarter context-aware comments.                |
| ✂️   | `nvim-mini/mini.ai`      | Enhances text objects for motions, selections, and editing with more precise operators. |
| 🛠️   | `folke/lazydev.nvim`     | Lua development library for Neovim config.                                              |
| 📝   | `danymat/neogen`         | Generate docstrings and annotations automatically for multiple languages.               |

#### Syntax

| Icon | Plugin                                        | Description                                                         |
| ---- | --------------------------------------------- | ------------------------------------------------------------------- |
| 🌳   | `nvim-treesitter/nvim-treesitter`             | Syntax highlighting, parsing, indentation, and supported languages. |
| 🧩   | `nvim-treesitter/nvim-treesitter-textobjects` | Advanced text objects powered by Treesitter.                        |
| 🔖   | `windwp/nvim-ts-autotag`                      | Auto-closing tags for HTML, JSX, and similar filetypes.             |
| 📜   | `nvim-treesitter/nvim-treesitter-context`     | Shows current function/block context at the top of the window.      |

#### Development

| Icon | Plugin                         | Description                                                                   |
| ---- | ------------------------------ | ----------------------------------------------------------------------------- |
| 🖥️   | `neovim/nvim-lspconfig`        | Core LSP setup for Neovim with diagnostics, inlay hints, folding, and more... |
| 🛠️   | `mason-org/mason.nvim`         | Manages installation of LSP servers, linters, and formatters.                 |
| 🪄   | `nvimtools/none-ls.nvim`       | Integrates external formatters and linters into Neovim’s LSP ecosystem.       |
| 🩺   | `mfussenegger/nvim-lint`       | Lightweight, configurable code linting engine supporting multiple linters.    |
| 🧹   | `stevearc/conform.nvim`        | Code formatting manager for multiple filetypes.                               |
| 🐞   | `mfussenegger/nvim-dap`        | Debug Adapter Protocol support for multiple languages.                        |
| 🖥️   | `rcarriga/nvim-dap-ui`         | Provides a fancy UI for DAP with widgets, REPL, and interactive evaluation.   |
| 🔧   | `jay-babu/mason-nvim-dap.nvim` | Automatically installs and configures DAP adapters.                           |

#### Colors

| Icon | Plugin                        | Description                                                          |
| ---- | ----------------------------- | -------------------------------------------------------------------- |
| 🎨   | `LazyVim/LazyVim`             | Sets the preferred colorscheme (`jellybeans-nvim`).                  |
| 🌌   | `folke/tokyonight.nvim`       | Dark theme with multiple styles (`night`).                           |
| ☕   | `catppuccin/nvim`             | Soft pastel theme with deep plugin integrations across many plugins. |
| 🛠   | `rktjmp/lush.nvim`            | Provides framework to create your own colorschemes.                  |
| 🟢   | `metalelf0/jellybeans-nvim`   | Lua port of the Jellybeans colorscheme, with shipwright dependency.  |
| 🌈   | `norcalli/nvim-colorizer.lua` | Highlights color codes in buffers for better visibility.             |
| 🎛️   | `vague2k/huez.nvim`           | Dynamically manage and switch themes with fallback support.          |

#### Utilities

| Icon | Plugin                     | Description                                                    |
| ---- | -------------------------- | -------------------------------------------------------------- |
| 💾   | `folke/persistence.nvim`   | Automated session management, saving buffers, directories, ... |
| 📚   | `nvim-lua/plenary.nvim`    | Lua utility library required by many plugins.                  |
| 🏃   | `ahmedkhalf/project.nvim`  | Project detection and navigation based on patterns.            |
| ⏱    | `dstein64/vim-startuptime` | Measures and benchmarks Neovim startup time.                   |
| 🖥   | `Joorem/vim-haproxy`       | HAProxy syntax highlighting for configuration files.           |

### Languages

#### Bash

| Icon | Tool                   | Type      | Purpose                                    |
| ---- | ---------------------- | --------- | ------------------------------------------ |
| 🧠   | `bash-language-server` | LSP       | Provides Bash diagnostics and completions. |
| ✨    | `shfmt`                | Formatter | Formats shell scripts.                     |
| 🧹   | `shellcheck`           | Linter    | Detects shell script issues.               |
| 🐞   | `bash-debug-adapter`   | Debugger  | Enables DAP debugging for Bash.            |

#### Lua

| Icon | Tool                  | Type      | Purpose                                                           |
| ---- | --------------------- | --------- | ----------------------------------------------------------------- |
| 🧠   | `lua-language-server` | LSP       | Provides Lua diagnostics, completion, and workspace intelligence. |
| ✨    | `stylua`              | Formatter | Formats Lua code consistently.                                    |
| 🧹   | `luacheck`            | Linter    | Detects code issues and unused variables.                         |

#### Markdown

| Icon | Tool                | Type      | Purpose                                                 |
| ---- | ------------------- | --------- | ------------------------------------------------------- |
| 🧠   | `marksman`          | LSP       | Language server for diagnostics, completion, and links. |
| ✨    | `prettier`          | Formatter | Formats Markdown files.                                 |
| 🪄   | `markdown-toc`      | Formatter | Generates a table of contents.                          |
| 🧹   | `markdownlint-cli2` | Linter    | Enforces Markdown style rules.                          |

#### Yaml

| Icon | Tool                   | Type      | Purpose                                        |
| ---- | ---------------------- | --------- | ---------------------------------------------- |
| 🧠   | `yaml-language-server` | LSP       | YAML diagnostics, validation, and completions. |
| ✨    | `yamlfmt`              | Formatter | Formats YAML files consistently.               |
| ✨    | `yamlfix`              | Formatter | Alternative YAML formatter.                    |
| ✨    | `prettier`             | Formatter | Formats YAML using Prettier parser.            |
| 🧹   | `yamllint`             | Linter    | Checks YAML for syntax and style issues.       |
| 📦   | `SchemaStore.nvim` | Schema | Provides YAML schema definitions. |

#### Json

| Icon | Tool       | Type      | Purpose                                   |
| ---- | ---------- | --------- | ----------------------------------------- |
| 🧠   | `json-lsp` | LSP       | JSON validation, completion, and schemas. |
| ✨    | `jq`       | Formatter | Formats JSON programmatically.            |
| ✨    | `prettier` | Formatter | Formats JSON with Prettier parser.        |
| ✨    | `fixjson`  | Formatter | Repairs and formats JSON.                 |
| 🧹   | `jsonlint` | Linter    | Checks JSON for syntax errors.            |
| 📦   | `SchemaStore.nvim` | Schema | Provides JSON schema definitions. |

#### Terraform

| Icon | Tool           | Type      | Purpose                                                              |
| ---- | -------------- | --------- | -------------------------------------------------------------------- |
| 🧠   | `terraform-ls` | LSP       | Provides diagnostics, code completion, and validation for Terraform. |
| ✨    | `terraform`    | Formatter | Runs `terraform fmt` for code formatting.                            |
| 🧹   | `tflint`       | Linter    | Detects issues and enforces best practices in Terraform code.        |
| 🔎   | `telescope-terraform-doc.nvim` | Docs   | Browse Terraform provider docs via Telescope. |
| 📘   | `telescope-terraform.nvim`     | Search | Search Terraform modules and resources.       |

#### Python

| Icon | Tool           | Type      | Purpose                                                 |
| ---- | -------------- | --------- | ------------------------------------------------------- |
| 🧠   | `basedpyright` | LSP       | Python language server for completions and diagnostics. |
| ✨    | `black`        | Formatter | Formats Python code according to Black style.           |
| 🧹   | `ruff`         | Linter    | Checks for errors and enforces style; can auto-fix.     |
| 🧹   | `mypy`         | Linter    | Performs static type checking on Python code.           |
| 🐍   | `venv-selector.nvim` | Tool | Select and activate Python virtual environments. |

#### Golang

| Icon | Tool            | Type      | Purpose                                                             |
| ---- | --------------- | --------- | ------------------------------------------------------------------- |
| 🧠   | `gopls`         | LSP       | Go language server for completions, diagnostics, and code analysis. |
| ✨    | `goimports`     | Formatter | Formats code and manages imports automatically.                     |
| ✨    | `gofumpt`       | Formatter | Strict Go code formatting with canonical style.                     |
| ✨    | `golines`       | Formatter | Formats long lines to a specified max length (100).                 |
| 🧹   | `golangci-lint` | Linter    | Runs multiple Go linters for code quality.                          |
| 🛠️  | `impl`          | Helper    | Generates Go interface method stubs.                                |

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

