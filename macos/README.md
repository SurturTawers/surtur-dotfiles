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
- `.ohmybash.omp.json` as config for oh-my-posh (zsh and bash), recolored with the Catppuccin Mocha palette
  - segments: git, AWS profile, docker context, path, angular/php/node versions, os, user@host
  - stock alternative: `$(brew --prefix oh-my-posh)/themes/catppuccin_mocha.omp.json`

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

Themes live in `.config/.tmux/.tmux.<theme>.conf`; uncomment one `source-file` line in `.tmux.conf`.
Active: `.tmux.catppuccin.conf`, plain styles (no catppuccin/tmux plugin needed):

- session name on the left, mauve (red while the prefix is pressed)
- windows as `index name`; current window is a solid blue block, activity = orange text, bell = orange block, ` Z` = zoomed pane
- date/time on the right
- the "Transparency overrides" block at the bottom of `.tmux.conf` is commented out (only useful with a translucent terminal)

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

### .GHOSTTY

- [ghostty](https://ghostty.org/)
- JetBrainsMono Nerd Font (`font-family = JetBrainsMono Nerd Font Mono`)
- config in `.config/ghostty/config.ghostty`, stowed to `~/.config/ghostty`
- theme `Catppuccin Mocha` (built-in), no background opacity, left option = Alt, `shift+enter` sends a newline (Claude Code)
- `.tmux.conf` sets `terminal-features` for `xterm-ghostty:RGB` (truecolor inside tmux)

```bash
brew install --cask ghostty
brew install --cask font-jetbrains-mono-nerd-font
ghostty +validate-config
# macOS also loads ~/Library/Application Support/com.mitchellh.ghostty/config.ghostty
# after ~/.config/ghostty; delete it if Ghostty recreates it so it can't override
```

- cmd + , open config
- cmd + shift + , reload config

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

## LAZYGIT / GIT DIFFS

- [lazygit](https://github.com/jesseduffield/lazygit): config in `.config/lazygit/config.yml`, loaded via `LG_CONFIG_FILE` in `.zshrc`
- [delta](https://github.com/dandavison/delta): pager for git CLI and lazygit (configured in `.gitconfig`)
- [difftastic](https://difftastic.wilfred.me.uk/): structural diff, alternate lazygit renderer (cycle with `|`)

```bash
brew install lazygit git-delta difftastic
# ~/.config/lazygit is stowed like nvim/wezterm
```

## THEME: CATPPUCCIN MOCHA

Same theme everywhere, matching Zed (`"theme": "Catppuccin Mocha"`):

| Tool | Where |
|---|---|
| Ghostty | `theme = Catppuccin Mocha` in `.config/ghostty/config.ghostty` |
| nvim | `return colorschemes["catppuccin"]` at the end of `.config/nvim/lua/surt/plugins/colorschemes.lua` |
| tmux | `source-file ~/.config/.tmux/.tmux.catppuccin.conf` in `.tmux.conf` |
| oh-my-posh | palette in `.ohmybash.omp.json` |
| Zed | `"theme"` in `.config/zed/settings.json` |

Palette: https://github.com/catppuccin/palette. To switch themes, change each line above
(nightfox is still available in nvim, tmux and Zed).

## .vimrc

- vim

```bash
sudo apt install vim
```

## .ideavimrc

- for jetbrains products
- in development
