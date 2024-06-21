# NVIM conf

## Needed

- cmake
- gcc
- fd
- ripgrep
- fzf
- cargo
- python
- wget
- npm
- wezterm or iterm2

## TMUX

- .tmux.conf is only here to keep track of my configuration

```bash
# To use this conf, nvim config must exist
cp ~/.config/nvim/.tmux.conf ~/.tmux.conf
# to update tmux conf
cp ~/.tmux.conf ~/.config/nvim/.tmux.conf
```

## CARGO

- Used for pest_ls

```bash
curl https://sh.rustup.rs -sSf | sh
# RELOAD ENV
. "$HOME/.cargo/env"
```

## YABAI AND SKHD (tiling manager and keyboard shortcuts)

- only for config maintaining purposes

```bash
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
#without repo
mkdir ~/.config/yabai ~/.config/skhd
mkdir ~/.config/yabai/yabairc ~/.config/skhd/skhdrc
#with my repo
cp yabai ~/.config/yabai
cp skhd ~/.config/skhd
# start services
yabai --start-service
skhd --start-service
```

´´´
brew install composer

python3 -m pip install --user --upgrade pynvim

# Install npm

# nvm install

nvim install 20
npm i -g neovim
´´´

## CONTENTS

- []

## Telescope

## LSP

-

## Tree-sitter

-

## Autocompletion

-

## Code Screenshots
