# Git review manual: gitsigns, diffview, lazygit

Open this from nvim with `<leader>g?`. `<leader>` is Space.

Three tools, each for a different zoom level:

| Tool | Zoom | Use it to |
|---|---|---|
| **gitsigns** | one file, one hunk | see what changed while reading a file; preview, stage or undo a single change; blame a line |
| **diffview** | many files, side by side | review a whole change set: what Claude just did, a branch before a PR, a file's history |
| **lazygit** | the repository | stage, commit, push, branch, rebase, stash; quick per-file diffs |

---

## Common workflows

### 1. Review what Claude (or you) just changed

1. `<leader>gvo` opens diffview on all uncommitted changes (staged + unstaged) against `HEAD`.
2. `<tab>` / `<s-tab>` moves to the next / previous file. `]c` / `[c` jumps between changes inside the file.
3. Edits on the right side are real edits to the working file: fix things in place.
4. In the file panel (left), `-` stages / unstages a file, `X` throws away that file's changes.
5. `<leader>gvc` closes diffview.

For a quick look without leaving the file you're in: `]h` / `[h` to walk the hunks, `<leader>hp` to preview one inline, `<leader>hr` to undo it.

### 2. Review a branch like a pull request

1. `<leader>gvm` shows everything this branch changed since it split from the default branch (`origin/main` or whatever `origin/HEAD` points to). It's the same diff GitHub shows for a PR.
2. Walk it with `<tab>` and `]c` as above.
3. To compare against something else: `:DiffviewOpen origin/develop...HEAD`, or `:DiffviewOpen HEAD~3`.

### 3. Find out why a line is the way it is

1. `<leader>hb` shows the full commit that last touched the current line (blame).
2. `<leader>hB` toggles blame shown at the end of every line, as you move.
3. `<leader>gvh` opens the history of the current file: every commit that touched it, each with its diff. `<leader>gvH` does the same for the whole repo.
4. Inside the history: `<cr>` shows that commit's diff, `L` its full details, `y` copies its hash.

### 4. Commit only part of your changes

- **One hunk:** cursor on it, `<leader>hs` (stage) or `<leader>hr` (reset).
- **Some lines:** select them in visual mode, then `<leader>hs` / `<leader>hr`.
- **In lazygit:** `<leader>lg`, `<enter>` on a file, then `<space>` stages the current line, `v` selects a range, `a` toggles hunk mode. Then `<esc>` and `c` to commit.

### 5. Resolve a merge or rebase conflict

1. `:DiffviewOpen` during the conflict opens the 3-way merge tool (yours, merged result, theirs).
2. `]x` / `[x` jumps between conflicts.
3. `<leader>co` keeps OURS, `<leader>ct` THEIRS, `<leader>cb` BASE, `<leader>ca` all of them, `dx` deletes the conflict region. Capital letters (`<leader>cO`, ...) apply to the whole file.
4. Stage the file with `-` in the panel, then continue the rebase/merge in lazygit (`m`).

---

## gitsigns (inside any file)

Signs in the gutter: `+` added, `~` changed, `_` deleted.

| Keys | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk (in a diff window: next / previous change) |
| `<leader>hp` | Preview the hunk inline (old lines shown above the new ones) |
| `<leader>hs` | Stage hunk. Visual mode: stage only the selected lines |
| `<leader>hr` | Reset (undo) hunk. Visual mode: only the selected lines |
| `<leader>hS` / `<leader>hR` | Stage / reset the whole file |
| `<leader>hb` | Blame the current line (full commit message) |
| `<leader>hB` | Toggle blame at the end of each line |
| `<leader>hw` | Toggle word diff (highlights the exact changed words) |
| `<leader>hd` | Diff this file against the index (what you'd commit) |
| `<leader>hD` | Diff this file against the last commit |
| `<leader>hq` | Put every hunk in the repo into the quickfix list (`:cnext` / `:cprev` to walk) |
| `ih` | Text object for the hunk: `vih` selects it, `dih` deletes it |

## diffview (multi-file review)

### Opening

| Keys | Opens |
|---|---|
| `<leader>gvo` | Uncommitted changes vs `HEAD` |
| `<leader>gvm` | This branch vs the default branch (PR view) |
| `<leader>gvh` | History of the current file |
| `<leader>gvH` | History of the repo |
| `<leader>gvt` | Toggle the file panel |
| `<leader>gvc` | Close |
| `:DiffviewOpen <rev>` | Any comparison, e.g. `HEAD~2`, `main..feature`, `origin/main...HEAD` |

`A..B` compares the two commits directly; `A...B` compares B against where it split from A (what a PR shows).

### Inside a diff

| Keys | Action |
|---|---|
| `<tab>` / `<s-tab>` | Next / previous file |
| `[F` / `]F` | First / last file |
| `]c` / `[c` | Next / previous change inside the file |
| `gf` | Open the file in your previous tab, to keep working on it |
| `<C-w><C-f>` / `<C-w>gf` | Open the file in a split / new tab |
| `<leader>e` | Focus the file panel |
| `<leader>b` | Toggle the file panel |
| `g<C-x>` | Cycle layouts (side by side / stacked) |
| `g?` | Help with every key for the current view |

### File panel

| Keys | Action |
|---|---|
| `j` / `k`, `<cr>` / `o` | Move, open a file's diff |
| `-` or `s` | Stage / unstage the file |
| `S` / `U` | Stage all / unstage all |
| `X` | Restore the file to the left side (discards your changes to it) |
| `i` | Toggle list / tree view |
| `R` | Refresh |
| `L` | Commit log |

### File history panel

| Keys | Action |
|---|---|
| `<cr>` | Show that commit's diff |
| `L` | Commit details |
| `y` | Copy the commit hash |
| `X` | Restore the file as it was in that commit |
| `g!` | Options (e.g. follow renames, limit by author or date) |

## lazygit (`<leader>lg`, or `lazygit` in a terminal)

Panels on the left: **1** Status, **2** Files, **3** Branches, **4** Commits, **5** Stash. Jump with the number keys, cycle with `<tab>`. The right side shows the diff of whatever is selected.

### Everywhere

| Keys | Action |
|---|---|
| `?` | Every key available in the current panel. Use this whenever you're unsure |
| `<space>` | Main action (stage, checkout, ...) |
| `<enter>` | Go into the item (a file's hunks, a commit's files) |
| `e` / `o` | Edit the file in this nvim / open it with the default app |
| `/` | Search or filter the list |
| `z` / `Z` | Undo / redo (uses the reflog, so it can undo commits and rebases) |
| `P` / `p` | Push / pull |
| `\|` / `\` | Cycle the diff renderer: delta, delta side-by-side, difftastic |
| `{` / `}` | Less / more context lines in the diff |
| `<ctrl+w>` | Toggle ignoring whitespace in diffs |
| `W` | Diff any two refs (pick the first, then the second) |
| `+` | Bigger panel (cycles normal / half / full screen) |
| `:` | Run a shell command |
| `q` | Quit (`<esc>` goes back a level) |

### Files

| Keys | Action |
|---|---|
| `<space>` | Stage / unstage file |
| `a` | Stage / unstage everything |
| `<enter>` | Stage individual lines: `<space>` line, `v` range, `a` hunk mode, `<tab>` switch to the staged side |
| `c` / `C` | Commit / commit in nvim (for longer messages) |
| `A` | Amend the last commit |
| `d` | Discard changes in the file |
| `s` / `S` | Stash all / stash options |
| `D` | Reset options (soft, mixed, hard, nuke untracked) |
| `` ` `` | Toggle file tree view |
| `f` | Fetch |

### Branches

| Keys | Action |
|---|---|
| `<space>` | Check out branch |
| `n` | New branch |
| `c` | Check out by name |
| `r` | Rebase the current branch onto the selected one |
| `M` | Merge the selected branch into the current one |
| `o` | Create a pull request (opens the browser) |
| `u` | Set upstream |
| `d` | Delete branch |

### Commits

| Keys | Action |
|---|---|
| `<enter>` | Files changed in the commit (then `<enter>` again for the diff) |
| `s` | Squash into the commit below |
| `r` | Reword the message |
| `d` | Drop the commit |
| `e` | Edit the commit (starts an interactive rebase stopped there) |
| `F` | Create a fixup commit for the selected commit |
| `A` | Amend staged changes into the selected commit |
| `<ctrl+j>` / `<ctrl+k>` | Move the commit down / up |
| `t` | Revert the commit |
| `C` / `V` | Copy for cherry-pick / paste |
| `y` | Copy hash, message, URL, ... |
| `b` | Bisect |

### Rebasing and conflicts

| Keys | Action |
|---|---|
| `m` | Rebase options: continue, abort, skip |
| `<space>` / `b` in a conflict | Pick the hunk under the cursor / pick both |

For bigger conflicts, `<esc>` out of lazygit and use diffview's merge tool (workflow 5 above).

---

## Notes

- `[x` jumps to the pinned code context in normal files, but inside the diffview merge tool `[x` / `]x` move between conflicts. Diffview's keys win inside its own windows.
- Diffs use the `histogram` algorithm with line matching, so moved or reworded code lines up better than in plain `git diff`.
- `e` in lazygit opens the file in the nvim you launched it from; close the lazygit window to see it.
