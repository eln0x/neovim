# Neovim

<!-- markdownlint-disable MD013 -->

## Contents

<!-- toc -->

- [Screenshot](#screenshot)
- [Requirements](#requirements)
- [Installation](#installation)
- [Features](#features)
    * [Core UI](#core-ui)
    * [Core Editor](#core-editor)
    * [Completion](#completion)
    * [Coding](#coding)
    * [Syntax](#syntax)
    * [Development](#development)
    * [Copilot](#copilot)
- [Languages](#languages)
    * [Bash](#bash)
    * [Lua](#lua)
    * [Markdown](#markdown)
    * [Yaml](#yaml)

<!-- tocstop -->

### Screenshot

![Neovim](neovim.png "Neovim IDE")

### Requirements

- Neovim (version >= 0.11.0), run `nvim -v` to check neovim version.
- Python3 / Nodejs / Npm / Ripgrep / Fd-find / Xclip
- Exuberant Ctags or Universal Ctags.

```bash
# Pynvim
apt install python3-pynvim

# Nodejs & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install node

# Utils
apt install ripgrep fd-find xclip ncdu universal-ctags
```

### Installation

Backup:

```bash
bash <(curl -s https://gitlab.com/elnox/neovim/-/raw/master/utils/install) --bakup master
```

Install:

```bash
bash <(curl -s https://gitlab.com/elnox/neovim/-/raw/master/utils/install) \
    --release stable --config master
```

Cleanup:

```bash
rm -rf ~/.config/nvim ~/.cache/nvim ~/.local/nvim ~/.local/share/nvim ~/.local/state/nvim
```

Restore:

```bash
bash <(curl -s https://gitlab.com/elnox/neovim/-/raw/master/utils/install) --restore master
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
| 🩺   | `mfussenegger/nvim-lint`       | Lightweight, configurable code linting engine supporting multiple linters.    |
| 🧹   | `stevearc/conform.nvim`        | Code formatting manager for multiple filetypes.                               |
| 🐞   | `mfussenegger/nvim-dap`        | Debug Adapter Protocol support for multiple languages.                        |
| 🖥️   | `rcarriga/nvim-dap-ui`         | Provides a fancy UI for DAP with widgets, REPL, and interactive evaluation.   |
| 🔧   | `jay-babu/mason-nvim-dap.nvim` | Automatically installs and configures DAP adapters.                           |

#### Copilot

| Icon | Plugin                                      | Description                                     |
| ---- | ------------------------------------------- | ----------------------------------------------- |
| 🤖   | `zbirenbaum/copilot.lua`                    | AI pair programmer for inline suggestions.      |
| 🤖   | `CopilotC-Nvim/CopilotChat.nvim`            | AI chat assistant.                              |
| 📝   | `MeanderingProgrammer/render-markdown.nvim` | Enhanced markdown UI with copilot-chat support. |
| ⚡   | `giuxtaposition/blink-cmp-copilot`          | Blink completion support for copilot.           |

### Languages

#### Bash

| Icon | Tool                   | Type      | Purpose                                    |
| ---- | ---------------------- | --------- | ------------------------------------------ |
| 🧠   | `bash-language-server` | LSP       | Provides Bash diagnostics and completions. |
| ✨   | `shfmt`                | Formatter | Formats shell scripts.                     |
| 🧹   | `shellcheck`           | Linter    | Detects shell script issues.               |
| 🐞   | `bash-debug-adapter`   | Debugger  | Enables DAP debugging for Bash.            |

#### Lua

| Icon | Tool                  | Type      | Purpose                                                           |
| ---- | --------------------- | --------- | ----------------------------------------------------------------- |
| 🧠   | `lua-language-server` | LSP       | Provides Lua diagnostics, completion, and workspace intelligence. |
| ✨   | `stylua`              | Formatter | Formats Lua code consistently.                                    |
| 🧹   | `luacheck`            | Linter    | Detects code issues and unused variables.                         |

#### Markdown

| Icon | Tool                | Type      | Purpose                                                 |
| ---- | ------------------- | --------- | ------------------------------------------------------- |
| 🧠   | `marksman`          | LSP       | Language server for diagnostics, completion, and links. |
| ✨   | `prettier`          | Formatter | Formats Markdown files.                                 |
| 🪄   | `markdown-toc`      | Formatter | Generates a table of contents.                          |
| 🧹   | `markdownlint-cli2` | Linter    | Enforces Markdown style rules.                          |

#### Yaml

| Icon | Tool                   | Type      | Purpose                                        |
| ---- | ---------------------- | --------- | ---------------------------------------------- |
| 🧠   | `yaml-language-server` | LSP       | YAML diagnostics, validation, and completions. |
| ✨   | `yamlfmt`              | Formatter | Formats YAML files consistently.               |
| ✨   | `yamlfix`              | Formatter | Alternative YAML formatter.                    |
| 🧹   | `yamllint`             | Linter    | Checks YAML for syntax and style issues.       |
| 📦   | `SchemaStore.nvim`     | Schema    | Provides YAML schema definitions.              |
