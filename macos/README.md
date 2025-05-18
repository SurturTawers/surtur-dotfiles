# DOTFILES

## GNU stow

```bash
sudo apt install stow
#COMMANDS
stow <dirToSymlink> # This will symlink to parent directory
stow . # Will symlink current dir to ../

stow <dirToSymlink> -t <targetDir> # This will Symlink to targetDir
```

## .zshrc

- [oh-my-posh](https://ohmyposh.dev/)
- .ohmytheme.omp.json as config for oh-my-posh

```bash
# INSTALL into /usr/local/bin , use sudo su
brew install jandedobbeleer/oh-my-posh/oh-my-posh
# INIT
oh-my-posh init <shell> --config ~/<yourTheme> #initializes the shell
#.bashrc
eval "$(oh-my-posh init <shell> --config ~/<yourTheme>)"
exec bash
#customize themes
oh-my-posh config export --output ~/<yourCustomTheme>
```

## .tmux.conf

- [tmux](https://github.com/tmux/tmux/wiki/Installing)
- [tpm](https://github.com/tmux-plugins/tpm)

```bash
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux attach
```

- ctrl + <leader>, shift + u
  - update tpm plugins
- ctrl + <leader>, shift + i
  - install tpm plugins

## .config

### .WEZTERM

- [wezterm](https://wezfurlong.org/wezterm/index.html)
- [nerd fonts](https://www.nerdfonts.com/font-downloads)

```bash
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm
```

### NVIM

[Plugins](https://dotfyle.com/neovim/plugins/trending)

- [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- fzf
- ripgrep
- php
- python
- lazygit
- xdebug
- cargo
- make
- delve
- gcc
- git

```bash
sudo apt install git gcc make python3 php ripgrep fzf cargo
sudo apt install neovim
# OR

```

## .vimrc

- vim

```bash
sudo apt install vim
```

## .ideavimrc

- for jetbrains products
- in development
