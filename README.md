# Scotty Kaye dotfiles

Instructions on setting up dotfiles:

## Applications

1. To do everything we're going to want to have [homebrew](https://brew.sh/).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Here is a list of Homebrew `Formulae` and `casks` I use.

| Formulae  | Casks         |
| --------- | ------------- |
| Git       | Iterm2        |
| Neovim    | Raycast       |
| Deno      | Arc           |
| Bat       | Notion        |
| wget      | Rectangle     |
| Ripgrep   | Codewhisperer |
| Go        | Spotify       |
| Rust      | Slack         |
| Bun       | Meetingbar    |
| Python    | obsidian      |
| fnm       | discord       |
| Lua       | ghostty       |
| jq        |               |
| fzf       |               |
| gh        |               |
| delta     |               |
| jpegoptim |               |
| svgo      |               |
| optipng   |               |
| fzf       |               |
| lazygit   |               |
| fd        |               |
| make      |               |

#### Formulae command

```sh
brew install git neovim deno bat ripgrep go bun wget python@3.12 fnm lua gh jq fzf oven-sh/bun/bun rust jpegoptim svgo optipng delta lazygit fd make
```

#### Casks command

```sh
brew install --cask iterm2 raycast arc notion rectangle codewhisperer spotify slack meetingbar obsidian discord ghostty
```

## Install

1. Clone the repo

```sh
git clone https://github.com/scottykaye/dotfiles.git
```

2. Symlink `.zshrc` and `.zprofile` and the `.oh-my-zsh/` files and create `.config/` folder.

> [!IMPORTANT]
> If you already have a `.zshrc` or `.zprofile` be sure to move anything into the `zsh/.zshrc` or `zsh/.zprofile` files in the repo.

> [!NOTE]
> I write `<PATH_TO_DOTFILES>` in place of a folder I typically called `code/` in case I or other users want to use another path.

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.zshrc  ~/.zshrc
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.zprofile  ~/.zprofile
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.oh-my-zsh ~/
```

3. Symlink the `nvim/` folder at `.config/nvim/` and  `.config/ghostty`

> [!TIP]
> It's possible if you're on a new machine you don't yet have a hidden `~/.config` folder path and you'll need to create it to store the `~/.config/nvim` folder

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim ~/.config/nvim
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/ghostty ~/.config
```

> [!NOTE]
> Once you've created all these 4 paths, you'll need to either source all these folders and files (.zshrc, .zprofile, .oh-my-zsh, .config/nvim) or just shut the terminal and reopen!

## Ghostty terminfo (fixes "terminal is not fully functional")

If you use [Ghostty](https://ghostty.org) and see this when running `git diff`, `man`, or
anything that opens a pager:

```
WARNING: terminal is not fully functional
Press RETURN to continue
```

…it means this machine doesn't have the `xterm-ghostty` terminfo entry installed. Ghostty
sets `TERM=xterm-ghostty`, but programs like `less` can't find a matching terminfo database,
so they fall back to dumb mode.

> [!IMPORTANT]
> Terminfo is a **compiled, machine-local database** — it does **not** travel with a file
> copy or a `git clone`. Every new machine needs the one-time `tic` step below. This is also
> why `~/.ghostty.terminfo` is a real copied file (consumed once by `tic`), not a symlink like
> the other dotfiles.

### Fix (run once per machine)

```sh
# 1. Put the terminfo source in your home dir (symlink or copy — both work)
ln -sf ~/<PATH_TO_DOTFILES>/dotfiles/.ghostty.terminfo ~/.ghostty.terminfo

# 2. Compile/install it into the terminfo database (this is the step that actually matters)
tic -x ~/.ghostty.terminfo

# 3. Reload your shell
exec zsh
```

Verify it worked:

```sh
infocmp xterm-ghostty >/dev/null 2>&1 && echo "installed ✅" || echo "still missing ❌"
```

### Alternatives

- **No terminfo file handy?** Set a universally-known `TERM` on that machine instead:
  `echo 'export TERM=xterm-256color' >> ~/.zshrc` (loses a few Ghostty-specific niceties).
- **Over SSH?** Add `shell-integration-features = ssh-terminfo` to `ghostty/config` so Ghostty
  auto-installs its terminfo on remote hosts you connect to.

5. Open vim and Lazy should auto install! If not run lazy

```vim
:Lazy
```

The `plugin` folder should now compile in `~/<PATH_TO_DOTFILES>/dotfiles/nvim/plugin` and you should now see Neovim as expected.

## Headline ZSH Theme

The [headline](https://github.com/Moarram/headline) theme is vendored directly into this repo at `zsh/.oh-my-zsh/custom/themes/headline/` — no submodule, no extra clone step on new machines.

### Setup

The theme files are already committed in this repo. You just need the symlink so oh-my-zsh can discover it as `ZSH_THEME="headline"`:

```sh
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/headline/headline.zsh-theme ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/headline.zsh-theme
```

> [!NOTE]
> If you used the symlink in step 2 (`ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.oh-my-zsh ~/`) this symlink is already included and no extra step is needed.

### How it works

1. The full theme source is committed as regular files (the `.git` directory from the clone is removed)
2. The symlink above makes oh-my-zsh find it as `ZSH_THEME="headline"`:
   ```
   zsh/.oh-my-zsh/custom/themes/headline.zsh-theme -> headline/headline.zsh-theme
   ```
3. Customizations (like the git status caching/throttling) live in `.zshrc`, not in the theme file itself

### How to update headline

To pull in a newer version from upstream:

```sh
git clone --depth 1 https://github.com/Moarram/headline.git /tmp/headline
rm -rf /tmp/headline/.git
rm -rf zsh/.oh-my-zsh/custom/themes/headline
mv /tmp/headline zsh/.oh-my-zsh/custom/themes/headline
git add zsh/.oh-my-zsh/custom/themes/headline
git commit -m "update headline theme"
```

## Add font support

1. Lets move the font in the `fonts/` folder to the font `/Library/Fonts` directory.

```sh
cp -R ~/<PATH_TO_DOTFILES>/dotfiles/fonts/DroidSansMono.otf ~/Library/Fonts/DroidSansMono.otf
```

### Let's go!!! 😤😵
