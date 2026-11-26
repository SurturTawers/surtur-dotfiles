# Bring the Ubuntu setup in line with macOS

Instructions for a Claude Code session running on the **Ubuntu 24.04** machine, in `~/dotfiles`.
The macOS side (`macos/`) was cleaned up and improved on 2026-11-26; this file says what to port to
`ubuntu/`, what to leave alone, and how to verify each step.

## Ground rules

- **Only edit `ubuntu/`** (plus `~/.claude/settings.json` in step 4). Never change `macos/`: it is the reference.
- **Ask the user before**: deleting files outside the repo, changing the color theme, pushing, or anything
  irreversible. Show what you'll do first.
- **Never print secrets.** Check variables with `[ -n "$VAR" ] && echo set`, never `echo "$VAR"`.
  Check files with `wc -c`, never `cat`. (A key was leaked this way on the Mac; don't repeat it.)
- Work in the order below; each step ends with a verification. Stop and report if one fails.
- **Don't touch the user's tmux sessions.** Test tmux only on a separate socket (`tmux -L <name>`) with a
  plugin-free config (see step 3), and kill only servers you started.
- Leave the commit to the user unless they ask; suggest a message per step.

## What the repo looks like

- `macos/` and `ubuntu/` are separate GNU stow packages: `cd ~/dotfiles && stow -t ~ ubuntu`.
- `macos/` is the reference for nvim, tmux and the git-review setup. Compare with
  `diff -ru macos/.config/nvim ubuntu/.config/nvim` before and after each step.
- macOS README (`macos/README.md`) documents the result: key tables, private files, agent status.
- `ubuntu/` already got the shell fixes ($HOME instead of `/home/surt`, guarded optional files,
  tmux `tmux-256color`); nothing more to do in `ubuntu/.bashrc` except step 6.

## Do NOT port (macOS-only)

Homebrew, AeroSpace, Ghostty config, `.stow-local-ignore`, macOS Keychain SSH setup, the
`cred_encrypt` volume, `~/.zshrc.local`, the zsh config, Docker Desktop settings, macOS app changes.
The Ubuntu shell is **bash** (`ubuntu/.bashrc`) and the terminal is whatever the user runs there
(the repo has a WezTerm config); don't switch either.

---

## Step 0: Check the machine

```bash
nvim --version | head -1     # need >= 0.11 (vim.lsp.config); 0.12+ for diffopt "inline:char"
tmux -V                      # need >= 3.3 (popups, #{W:} loops, choose-tree -f)
git --version; git lfs version
for c in rg fd fdfind fzf lazygit delta difft jq make gcc cargo tree-sitter; do
  printf '%-12s %s\n' "$c" "$(command -v $c || echo MISSING)"; done
fc-list | grep -ci "JetBrainsMono Nerd Font"   # codesnap font; 0 = missing
```

Install what's missing (ask first; these need sudo):

```bash
sudo apt install ripgrep fd-find fzf jq make gcc git-lfs xclip   # xclip: tmux-yank + nvim clipboard on X11
# Ubuntu names fd "fdfind"; telescope calls "fd":
mkdir -p ~/.local/bin && ln -sf "$(command -v fdfind)" ~/.local/bin/fd
# lazygit, delta (git-delta), difftastic, tree-sitter-cli: apt versions are old or missing;
# use the GitHub release .deb/binaries or `cargo install difftastic tree-sitter-cli git-delta`
git lfs install
```

If nvim < 0.11, stop and ask the user to upgrade nvim (it lives in `/opt/nvim`, see `ubuntu/.bashrc`).
If nvim is 0.11.x, drop `inline:char` from the `diffopt` line in step 2.

---

## Step 1: Remove dead nvim config

1. `ubuntu/.config/nvim/init.lua`: confirm it only loads `surt` (`require("surt...")`). If so,
   `git rm -r ubuntu/.config/nvim/lua/josean` (old unused config; already removed on macOS).
2. Delete these plugin specs from `ubuntu/.config/nvim/lua/surt/plugins/` (all removed on macOS):
   - `avante.lua` (+ its deps go with it), `copilot.lua`, `dressing.lua`, `none-ls.lua`, `carbon-now.lua`
   - `flutter-tools.lua`: **ask first**. The Ubuntu `.bashrc` adds Flutter to PATH, so it may be in use there.
   - `lsp/mason.lua`: check what it does; on macOS Mason is set up inside `lsp/lsp-config.lua`.
     Remove it only after step 2 replaces `lsp-config.lua`.
   - `whick-key.lua` (misspelled): replaced by `which-key.lua` in step 2.
3. **Keep** the Ubuntu-only specs: `obsidian.lua` (vault in `~/Documents/Obsidian Vault`) and
   `remote-nvim.lua` (the user's own plugin `SurturTawers/remote_nvim`).

## Step 2: Port the nvim configuration

Copy these files from `macos/.config/nvim/` to `ubuntu/.config/nvim/` as-is:

| File | What it brings |
|---|---|
| `GIT-REVIEW.md` | Manual for gitsigns/diffview/lazygit, opened with `<leader>g?` |
| `lua/surt/lazy.lua` | `vim.uv`, rounded UI, disabled unused built-in plugins, 300 s build timeout |
| `lua/surt/plugins/lsp/lsp-config.lua` | Native `vim.lsp.config`, trimmed servers, intelephense only, stylua not started as LSP |
| `lua/surt/plugins/git-diffview.lua` | Lazy-loaded diffview + review presets (`<leader>gvo/gvm/gvh/gvH/gvc/gvt`, `<leader>g?`) |
| `lua/surt/plugins/gitsigns.lua` | Hunk navigation/preview/blame/stage keys (`]h [h`, `<leader>h*`, `ih`) |
| `lua/surt/plugins/treesitter-context.lua` | New: pinned function context (`[x`, `<leader>uc`) |
| `lua/surt/plugins/telescope.lua` | Lazy-loaded, hidden files included, ui-select hook, git pickers |
| `lua/surt/plugins/which-key.lua` | Group-only spec matching the real keymaps |
| `lua/surt/plugins/codesnap.lua` | Fixed for codesnap v2 (path per save), JetBrainsMono font |
| `lua/surt/plugins/nvim-tree.lua`, `aerial.lua`, `autosession.lua`, `bufferline.lua` | Lazy-loading triggers |
| `lua/surt/plugins/treesitter.lua` | Adds `diff`, `git_config`, `git_rebase`, `gitcommit` parsers |
| `lua/surt/plugins/lualine.lua` | Theme tied to the colorscheme (see the theme decision below) |
| `lua/surt/plugins/alpha.lua` | Redesigned start screen (see the theme decision below) |
| `lua/surt/vim-config/options.lua` | `diffopt` histogram/linematch (+ `inline:char` only on nvim 0.12+), diff fillchars |
| `lua/surt/vim-config/keymaps.lua` | Removes the broken `<leader>q` (netrw is disabled) |

Then merge by hand (don't overwrite; Ubuntu has its own content):

- **`dap.lua`**: keep the Ubuntu file (it has the Lua debugger and `daps_path = ~/programming/daps/`).
  Only add the `keys = { ... }` block from the macOS `dap.lua` so the debugger lazy-loads.
- **`formatting.lua`, `autopairs.lua`, `lazygit.lua`, `dap/init.lua`**: diff against macOS and port only
  clear fixes; keep Ubuntu-specific settings. Ask if unsure.
- **`lsp-config.lua` servers**: the macOS list covers TS/JS, PHP, Python, SQL, Lua, Docker, YAML, JSON,
  Markdown, Bash. If the Ubuntu machine works in other languages (e.g. Dart/Flutter, C), add those servers
  back and tell the user.

### Theme decision (ask the user)

macOS uses **Catppuccin Mocha** everywhere (nvim, tmux, oh-my-posh). Ubuntu uses **Nightfox** with a
transparent tmux. `alpha.lua` and `lualine.lua` on macOS read Catppuccin's palette, so:

- **Switch Ubuntu to Catppuccin (simplest, full parity):** copy `colorschemes.lua`, `alpha.lua`,
  `lualine.lua` as-is, and use the Catppuccin tmux theme in step 3.
- **Keep Nightfox:** keep the Ubuntu `colorschemes.lua`; in the copied `alpha.lua` replace
  `require("catppuccin.palettes").get_palette("mocha")` and the `p.<color>` names with Nightfox's palette
  (`require("nightfox.palette").load("nightfox")`: `magenta`, `blue`, `cyan`, `fg2`, `orange`, `comment`...);
  set lualine `theme = "nightfox"`; drop the catppuccin `integrations` block.

### Plugin sync and Mason

```bash
cd ~/dotfiles/ubuntu/.config/nvim
nvim --headless "+Lazy! clean" "+Lazy! install" +qa          # removes deleted plugins, adds treesitter-context
nvim --headless "+Lazy! update mason-lspconfig.nvim nvim-lspconfig" +qa
```

The new `lsp-config.lua` needs **mason-lspconfig >= 2.0** (its `automatic_enable` starts the servers).
On v1 nothing starts. Check: `git -C ~/.local/share/nvim/lazy/mason-lspconfig.nvim describe --tags`.

Uninstall the Mason packages for dropped servers/tools (only those not re-added above):

```bash
nvim --headless "+lua require('lazy').load({plugins={'nvim-lspconfig'}})" \
  "+MasonUninstall phpactor clangd cssmodules-language-server css-variables-language-server jedi-language-server pest-language-server svelte-language-server tailwindcss-language-server blade-formatter jsonlint quick-lint-js" \
  "+sleep 5" +qa
```

Install the new treesitter parsers (they download on first open otherwise):

```bash
nvim --headless "+lua require('lazy').load({plugins={'nvim-treesitter'}}); require('nvim-treesitter').install({'diff','git_config','git_rebase','gitcommit'}):wait(300000)" +qa
```

### Verify step 2

```bash
cd ~/dotfiles
# no startup errors, few plugins at startup
nvim --headless "+lua vim.defer_fn(function() local s=require('lazy').stats() print(s.count..' plugins, '..s.loaded..' at startup') print(vim.api.nvim_exec2('messages',{output=true}).output) vim.cmd('qa!') end,1500)"
# LSP attaches with settings applied (expect lua_ls only, globals = { "vim" })
nvim --headless ubuntu/.config/nvim/lua/surt/lazy.lua "+lua vim.defer_fn(function() for _,c in ipairs(vim.lsp.get_clients({bufnr=0})) do print(c.name) end local l=vim.lsp.get_clients({name='lua_ls'})[1] print(vim.inspect(l and l.config.settings.Lua.diagnostics.globals)) vim.cmd('qa!') end,4000)"
# empty startup time (macOS: ~22 ms)
nvim --headless --startuptime /tmp/nv.log +qa && grep 'NVIM STARTED' /tmp/nv.log
```

Also check by hand with the user: `<leader>g?` opens the manual, `<leader>gvo` opens diffview,
`]h` jumps hunks, `<leader>fs` finds dotfiles (e.g. `.bashrc`), and a codesnap save works
(`V` select, `<leader>cs`, file lands in `~/Documents/code_screenshots/`).

Gotchas seen on macOS:
- mason-lspconfig v2 silently ignores a `handlers = {}` table: settings never applied. The new file avoids it.
- lualine's Catppuccin theme name is `catppuccin-mocha` (not `catppuccin`).
- codesnap v2 has no `save_path` option; `:CodeSnapSave` needs the path. The new spec handles it.
- Telescope ignores dotfiles unless `fd --hidden` / `rg --hidden` (handled in the new spec).

## Step 3: tmux

Copy from `macos/` to `ubuntu/`:

| File | Notes |
|---|---|
| `.config/.tmux/.tmux.keybinds.conf` | as-is |
| `.config/.tmux/claude-status.sh` | as-is, then `chmod +x` |
| `.config/.tmux/agent-new.sh`, `.config/.tmux/repo-open.sh` | `prefix C` / `prefix o` workspace helpers, then `chmod +x`. Adjust paths if needed: agents start in `~/kastor/sigmund`, the picker lists git repos in `~/kastor` and `~/daps` plus `~/dotfiles` (ask the user where repos live on Ubuntu, e.g. `~/programming`) |
| `.config/.tmux/WORKSPACE.md` | workspace manual opened with `prefix h`; update paths/keys if anything differs on Ubuntu (e.g. no AeroSpace, so `alt+1..9` is free) |
| `.config/.tmux/.tmux.catppuccin.conf` | only if the user chose Catppuccin |
| `.tmux.conf` | then adapt: keep the Ubuntu theme line if Nightfox, and ask whether to keep Ubuntu's transparency block (`status-style bg=default`, `window-style`, `window-active-style`), which is active on Ubuntu |

If the user keeps **Nightfox**, port the agent-status parts of `.tmux.catppuccin.conf` into
`.tmux.nightfox.conf`: the `status-right` waiting counter and the `window-status-format` /
`window-status-current-format` lines with the `@claude_state` icons, using Nightfox colors
(orange for waiting, green for done).

What the new tmux config brings: `focus-events on` (nvim reloads files Claude changed, gitsigns refreshes),
50k history, windows from 1 with renumbering, folder-named windows, splits/new windows in the current path,
`prefix H/J/K/L` resize, vi copy mode, OSC52 clipboard, `prefix g` lazygit popup,
`prefix a` / `prefix A` for Claude agents.

Key-conflict rules learned on macOS (keep them):
- Don't bind **alt + arrows** in tmux: Claude Code uses alt-up/down (changed-files list) and alt-left/right (word jumps).
- vim-tmux-navigator owns **ctrl-h/j/k/l** in every pane (user's choice). So in Claude, `ctrl+j`/`ctrl+l`
  don't reach it; new line is **alt+enter**.
- The tmux prefix is **ctrl+x**; Claude's `ctrl+x ...` chords need `ctrl+x ctrl+x` first inside tmux.

Clean unused tmux plugins (on macOS the old catppuccin/kanagawa plugin dirs were stale):
`ls ~/.tmux/plugins` and remove theme plugins not referenced in `.tmux.conf` (ask first).

### Verify step 3

**Never start a test tmux server with the real `~/.tmux.conf`.** It loads tmux-continuum, which restores
all the user's saved sessions into the test server, and auto-saves; killing the test server mid-restore
left a stuck process on macOS that made the user's real tmux skip its restore, and the auto-save then
overwrote the `last` save. Test with a plugin-free copy:

```bash
sed -E '/@plugin|@continuum|@resurrect|tpm\/tpm/d' ~/.tmux.conf > /tmp/tmux-test.conf
tmux -L t -f /tmp/tmux-test.conf new-session -d -c ~/dotfiles && sleep 1
for o in focus-events history-limit base-index mode-keys; do echo "$o=$(tmux -L t show -gv $o 2>/dev/null || tmux -L t show -gwv $o)"; done
tmux -L t set -w @claude_state waiting
tmux -L t display -p '#{T:window-status-current-format}' | sed -E 's/#\[[^]]*\]//g'   # expect "● dotfiles"
tmux -L t display -p '#{T:status-right}' | sed -E 's/#\[[^]]*\]//g'                  # expect "● 1 waiting ..."
tmux -L t kill-server
```

Then in the user's real tmux: `prefix r` to reload, and **right after, save with `prefix C-s`**.
The new config numbers windows and panes from 1; saves made with the old numbering (from 0) restore
with a duplicated pane in every single-pane window (tmux-resurrect thinks pane 0 is missing). A fresh
save after the reload avoids that. If it happens anyway, the duplicates are the newest pane in each
affected window. Compare against the save file before closing anything.

## Step 4: Claude Code hooks (agent status)

Edit `~/.claude/settings.json` on Ubuntu. **Read it first and merge**; don't replace existing hooks
(on macOS there were unrelated `Stop`/`SessionEnd` hooks that had to stay). Add one command hook per event:

| Event | Command | Options |
|---|---|---|
| `UserPromptSubmit` | `"$HOME/.config/.tmux/claude-status.sh" working 2>/dev/null \|\| true` | `"timeout": 5` |
| `Notification` | `"$HOME/.config/.tmux/claude-status.sh" notify 2>/dev/null \|\| true` | `"timeout": 5` |
| `PostToolUse` | `"$HOME/.config/.tmux/claude-status.sh" resume 2>/dev/null \|\| true` | `"async": true, "timeout": 5` |
| `Stop` | `"$HOME/.config/.tmux/claude-status.sh" done 2>/dev/null \|\| true` | `"timeout": 5` |
| `SessionStart` | `"$HOME/.config/.tmux/claude-status.sh" clear 2>/dev/null \|\| true` | `"timeout": 5` |
| `SessionEnd` | `"$HOME/.config/.tmux/claude-status.sh" clear 2>/dev/null \|\| true` | `"timeout": 5` |

Shape of one entry (no `matcher` needed):

```json
"UserPromptSubmit": [
  { "hooks": [ { "type": "command", "command": "\"$HOME/.config/.tmux/claude-status.sh\" working 2>/dev/null || true", "timeout": 5 } ] }
]
```

Why these: `notify` ignores Claude's idle reminders after a finished turn (keeps "done"); `resume` only
moves waiting → working, so the async `PostToolUse` can't overwrite "done".

### Verify step 4

```bash
jq -e '.hooks | keys' ~/.claude/settings.json      # valid JSON, all six events present
tmux -L h -f /dev/null new-session -d; P=$(tmux -L h display -p '#{pane_id}')
for s in working notify resume done clear; do tmux -L h run-shell "TMUX_PANE=$P ~/.config/.tmux/claude-status.sh $s"; echo "$s -> $(tmux -L h show -wqv -t $P @claude_state)"; done
tmux -L h kill-server    # expect: working, waiting, working, done, (empty)
```

The user must restart running Claude sessions (or run `/hooks` once) for the hooks to load.

## Step 5: lazygit config

Copy `macos/.config/lazygit/config.yml` to `ubuntu/.config/lazygit/config.yml` (delta / delta side-by-side /
difftastic renderers cycled with `|`, `nvim-remote` edit preset). On Linux lazygit reads
`~/.config/lazygit/config.yml` by default, so no `LG_CONFIG_FILE` is needed. Change the first comment line
accordingly. Requires `delta` and `difft` from step 0.

Verify: `lazygit --version` and open it in a repo; `|` cycles renderers; from nvim (`<leader>lg`), `e` on a
file opens it in that nvim.

## Step 6: Unused API keys (ask the user)

`ubuntu/.bashrc` still exports `OPENAI_API_KEY` from `~/.openapitoken` and `GEMINI_API_KEY` from
`~/.geminiapitoken`. On macOS their only consumer was avante (removed in step 1), so they were removed there.
The Gemini key was also exposed and should be **revoked** in Google AI Studio.

Ask the user, then if they agree:
- remove the "API keys" block from `ubuntu/.bashrc`;
- move `~/.openapitoken` and `~/.geminiapitoken` to the trash (`gio trash <file>`), not `rm`;
- check other uses first without printing values: `grep -rl --exclude-dir=.git -e GEMINI_API_KEY -e OPENAI_API_KEY ~/projects ~/programming ~/.config 2>/dev/null`.

## Step 7: Stow, docs, commit

```bash
cd ~/dotfiles && stow -n -v -t ~ ubuntu     # dry run: no conflicts expected
stow -t ~ ubuntu
```

- Update `ubuntu/README.md`: point to `macos/README.md` sections (tmux keys, agent status, code review keys)
  or copy the relevant tables, adjusting apt-based install commands.
- Suggested commits (user runs them): one for nvim (step 1-2), one for tmux + hooks + lazygit (3-5),
  one for the API keys (6). End each message with the attribution line the session requires.

## Final checklist

- [ ] nvim starts with no messages; few plugins at startup; lua_ls/ts_ls/intelephense attach on matching files
- [ ] `<leader>fs` finds dotfiles; `<leader>g?` opens GIT-REVIEW.md; diffview and gitsigns keys work
- [ ] codesnap saves a PNG
- [ ] tmux: focus-events on; `prefix g` lazygit popup; resize with `prefix H/J/K/L`
- [ ] A Claude session in tmux shows ⚙ while working, ● (with bell) when asking permission, ✓ when done;
      `prefix a` jumps to the waiting one
- [ ] No secrets printed during the session
