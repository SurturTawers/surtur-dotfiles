# Workspace manual: tmux + Claude agents + repos

Open this from tmux with `prefix h` (`q` to close). The prefix is `ctrl+x`.

## The idea

Two tmux sessions, and windows that exist only while you need them:

| Session | One window per | Opened with | Close it when |
|---|---|---|---|
| **`agents`** | task (`k2-pagos`, `fenix-hotfix`, `qa-tcel`) running Claude from `~/kastor/sigmund` | `prefix C` | the task is merged or dropped |
| **`repos`** | repo you're working on (nvim, lazygit, git, ssh), plus long-lived ones like `dotfiles` | `prefix o` | you're done with that repo |

Why: Claude always starts from `~/kastor/sigmund` (its hooks and skills live there) and reaches into the repos
from there, so agents are organised by **task**, not by repo. Repo windows are cheap to reopen, and every one
left open usually holds an nvim with a language server (200–500 MB each on an 8 GB Mac).

## A typical day

1. **Start a task:** `prefix C`, type a short name (`k2 pagos`), Enter. A window `k2-pagos` opens in
   `agents`, in `~/kastor/sigmund`, with `claude` already running. Give it the task.
2. **Start another task** while the first one works: `prefix C` again. Each task gets its own window.
3. **Know who needs you:** tabs show each agent's state (below). When one turns **● peach**, `prefix a`
   jumps straight to it. `prefix A` lists every agent window with its state to pick from.
4. **Review what an agent did:** `prefix o`, pick the repo, open nvim there and use `<leader>gvo`
   (uncommitted changes) or `<leader>gvm` (branch vs main). See `<leader>g?` in nvim for the full review manual.
   `prefix g` opens lazygit in a popup for staging and committing.
5. **Finish:** in the agent window exit Claude (`/exit` or `ctrl+d`) and `exit` the shell; close repo windows
   the same way. Windows renumber themselves.

## Agent states (window tabs)

| Tab | Meaning | Set when |
|---|---|---|
| `⚙ k2-pagos` | working | you send a prompt; after you approve a tool |
| `● k2-pagos` (peach, bell) | **waiting for you**: a permission prompt or a question | Claude asks |
| `✓ k2-pagos` (green) | finished its turn, ready for review | Claude stops |
| no icon | no Claude session, or it ended | session start/end |

The right of the status bar shows **`● N waiting`** while any agent in the session needs you.
States come from Claude Code hooks in `~/.claude/settings.json` calling `claude-status.sh`; a Claude session
started before the hooks existed needs a restart (or `/hooks` once) to report its state.

## Keys

### Workspace

| Keys | Action |
|---|---|
| `prefix C` | New Claude task window (asks for the name; switches to it if it already exists) |
| `prefix o` | Repo picker: type to filter, Enter opens or switches to the repo's window, Esc cancels |
| `prefix a` | Jump to the next agent waiting for you |
| `prefix A` | Pick any agent window (shows state and folder) |
| `prefix s` | Pick any session or window |
| `prefix g` | lazygit popup in the current folder |
| `prefix h` | This manual |

### Windows and panes

| Keys | Action |
|---|---|
| `prefix 1..9` | Window 1..9 of the current session |
| `prefix tab` | Previous window |
| `prefix c` | New plain window in the current folder |
| `prefix ,` | Rename window |
| `prefix .` | Move window (e.g. to another session: `repos:`) |
| `prefix \|` / `prefix -` | Split right / below, in the current folder |
| `ctrl h/j/k/l` | Move between panes and nvim splits |
| `prefix H/J/K/L` | Resize (repeatable: press the prefix once, then tap) |
| `prefix m` or `prefix z` | Zoom the current pane |
| `prefix x` / `prefix &` | Close pane / window |
| `prefix d` | Detach (everything keeps running) |

### Copy and scroll

| Keys | Action |
|---|---|
| `prefix [` | Copy mode: scroll with `ctrl-u/d`, `/` to search |
| `v` / `ctrl-v` / `y` | Select / rectangle / copy to the macOS clipboard |
| `q` | Leave copy mode |

### Save and restore

tmux-continuum saves the layout every 10 minutes and restores it when tmux starts after a reboot.
Folders come back, programs don't: each agent window restarts as a plain shell in `~/kastor/sigmund`.
Run `claude --resume` there and pick that task's conversation (`--continue` would take the most recent one
in the folder, and all agents share `~/kastor/sigmund`).

| Keys | Action |
|---|---|
| `prefix C-s` | Save now (do it after reorganising windows) |
| `prefix C-r` | Restore the last save |
| `prefix r` | Reload the tmux config |

## Claude inside tmux: keys to know

| You want | Use | Why |
|---|---|---|
| New line in the prompt | `alt+enter` | `ctrl+j` and Ghostty's `shift+enter` (`\n`) are caught by pane navigation |
| Claude's `ctrl+x ...` shortcuts (`ctrl+x ctrl+e` editor, `ctrl+x ctrl+k` kill agents) | press `ctrl+x` twice first | `ctrl+x` is the tmux prefix; `ctrl+g` also opens the editor |
| Clear the prompt | remap Claude's `chat:clearInput` in `~/.claude/keybindings.json` if you need it | `ctrl+l` moves to the pane on the right |
| Word jumps, changed-files list | `alt+←/→`, `alt+↑/↓` | free in tmux (pane resize moved to `prefix H/J/K/L`) |
| Switch macOS workspace | `alt+1..9` | AeroSpace owns these; tmux windows use `prefix 1..9` |

## Troubleshooting

- **No icons on agent tabs:** the Claude session predates the hooks; restart it or run `/hooks` once.
  Check the hooks with `jq '.hooks | keys' ~/.claude/settings.json`.
- **`prefix C` / `prefix o` do nothing:** reload with `prefix r`; the scripts live in `~/.config/.tmux/`
  and must be executable (`chmod +x ~/.config/.tmux/*.sh`).
- **A repo is missing from the picker:** it lists git repos directly inside `~/kastor` and `~/daps`, plus
  `~/dotfiles`. Anything else: `prefix c` then `cd`.
- **After a reboot the sessions didn't come back:** `prefix C-r`. Saves live in
  `~/.local/share/tmux/resurrect/` (`last` points to the newest); older ones can be restored by pointing
  `last` at them.
