# Neovim

## Contents

- [Screenshot](#screenshot)
- [Requirements](#requirements)
- [Installation](#installation)

### Screenshot

![Neovim](neovim.png "Neovim IDE")

### Requirements

- Neovim (version >= 0.7.0), run `nvim -v` to check neovim version.
- Exuberant Ctags and/or Universal Ctags.
- Ripgrep & Fd-find

### Installation

Step 1: Cleanup
```
rm -rf ~/.config/nvim ~/.cache/nvim ~/.local/share/nvim
```

Step 2: Clone & fetch
```
git clone git@gitlab.com:elnox/neovim.git ~/.config/nvim
cd ~/.config/nvim && git fetch origin
```

Step 3: Plugins autoloader
```
sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Step 4: Load configuration
```
git checkout alpha
nvim +PlugClean +PlugInstall +qall
```

Step 5: Enjoy ;)
```
nvim
```
