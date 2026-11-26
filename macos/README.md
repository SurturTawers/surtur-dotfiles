# DOTFILES (macOS)

This repo holds dotfiles for two machines: `macos/` (this Mac) and `ubuntu/` (Ubuntu 24.04).

## GNU stow

```bash
brew install stow          # Ubuntu: sudo apt install stow
cd ~/dotfiles
stow -t ~ macos            # symlink everything in macos/ into ~
stow -D -t ~ macos         # remove those symlinks
```

`macos/.stow-local-ignore` keeps configs in the repo without linking them on this Mac:
`.config/skhd`, `.config/yabai` (replaced by AeroSpace), `.config/wezterm` (replaced by Ghostty),
`.config/zed` (Zed not installed) and `.ideavimrc` (no JetBrains IDE installed).
Remove a line there and re-run `stow -t ~ macos` to link one again.

## Private files (not in this repo)

Machine-specific and sensitive settings stay outside the repo:

| File | Holds |
|---|---|
| `~/.zshrc.local` | SSH shortcuts (`ck2`, `cfenix85`, ...), VPN aliases, loads `~/.servers` (sourced by `.zshrc` if present) |
| `~/.servers` | `NAME_IP=...` server variables |
| `~/.ssh/config` | SSH hosts, users and keys. Keys are passphrase-protected, passphrases live in the macOS Keychain (`UseKeychain yes`, `AddKeysToAgent yes`) |
| `~/.openapitoken`, `~/.geminiapitoken` | API keys, exported by `.zshrc` if the files exist |

Add a key's passphrase to the Keychain with `ssh-add --apple-use-keychain ~/.ssh/<key>`.

## .zshrc

- Node: the default nvm version goes on `PATH` at startup; `nvm` itself loads on first use (keeps shell startup fast)
- [oh-my-posh](https://ohmyposh.dev/)
- `.ohmybash.omp.json` as config for oh-my-posh (zsh and bash), recolored with the Catppuccin Mocha palette
  - segments: git, AWS profile, docker context, path, angular/php/node versions, os, user@host
  - stock alternative: `$(brew --prefix oh-my-posh)/themes/catppuccin_mocha.omp.json`

```bash
brew install oh-my-posh
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
brew install tmux
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

- [wezterm](https://wezfurlong.org/wezterm/index.html) (config kept but not stowed on this Mac; Ghostty is the terminal in use)
- [nerd fonts](https://www.nerdfonts.com/font-downloads)

```bash
brew install --cask wezterm
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

- [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) 0.12+ (uses native `vim.lsp.config`)
- lazy.nvim; most plugins load on first use (empty startup ~25 ms)
- LSP servers, formatters, linters and debug adapters install through Mason (`lua/surt/plugins/lsp/lsp-config.lua`)
- debug adapters for nvim-dap live in `~/daps`

```bash
brew install neovim ripgrep fd fzf tree-sitter-cli cmake php lazygit
# Rust (cargo) builds codesnap.nvim's screenshot generator on first install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### Code review keys

Full guide with workflows: [`.config/nvim/GIT-REVIEW.md`](.config/nvim/GIT-REVIEW.md) (`<leader>g?` opens it inside nvim).

| Keys | Action |
|---|---|
| `<leader>gvo` | Diffview: uncommitted changes |
| `<leader>gvm` | Diffview: this branch vs the default branch (PR-style) |
| `<leader>gvh` / `<leader>gvH` | Diffview: current file / repo history |
| `<leader>gvc` | Diffview: close |
| `]h` / `[h` | Next / previous hunk |
| `<leader>hp` / `<leader>hb` | Preview hunk inline / blame line |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (visual: selected lines) |
| `<leader>hw` / `<leader>hB` | Toggle word diff / inline blame |
| `<leader>hq` | All hunks in the repo into quickfix |
| `[x` / `<leader>uc` | Jump to / toggle the pinned code context |
| `<leader>lg` | LazyGit (`e` on a file opens it in this nvim) |

#### Code screenshots (visual mode)

| Keys | Action |
|---|---|
| `<leader>cc` | codesnap: copy to clipboard |
| `<leader>cs` | codesnap: save to `~/Documents/code_screenshots/` |
| `<leader>ch` | codesnap: copy with highlighted lines |
| `<leader>cn` | Open in carbon.now.sh |

## LAZYGIT / GIT DIFFS

- [lazygit](https://github.com/jesseduffield/lazygit): config in `.config/lazygit/config.yml`, loaded via `LG_CONFIG_FILE` in `.zshrc`
- [delta](https://github.com/dandavison/delta): pager for git CLI and lazygit (configured in `.gitconfig`)
- [difftastic](https://difftastic.wilfred.me.uk/): structural diff, alternate lazygit renderer (cycle with `|`)

```bash
brew install lazygit git-delta difftastic git-lfs
# ~/.config/lazygit is stowed like nvim/wezterm
# .gitconfig enables the git-lfs filter, so git-lfs must be installed
```

## THEME: CATPPUCCIN MOCHA

Same theme everywhere:

| Tool | Where |
|---|---|
| Ghostty | `theme = Catppuccin Mocha` in `.config/ghostty/config.ghostty` |
| nvim | `return colorschemes["catppuccin"]` at the end of `.config/nvim/lua/surt/plugins/colorschemes.lua` |
| tmux | `source-file ~/.config/.tmux/.tmux.catppuccin.conf` in `.tmux.conf` |
| oh-my-posh | palette in `.ohmybash.omp.json` |
| Zed (config kept, not stowed) | `"theme"` in `.config/zed/settings.json` |

Palette: https://github.com/catppuccin/palette. To switch themes, change each line above
(nightfox is still available in tmux and Zed; nvim ships only Catppuccin).

## .vimrc

- vim (ships with macOS)
