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
| fnm       |               |
| Lua       |               |
| jq        |               |
| fzf       |               |
| gh        |               |
| delta     |               |
| jpegoptim |               |
| svgo      |               |
| optipng   |               |


#### Formulae command

```sh
brew install git neovim deno bat ripgrep go bun wget python@3.12 fnm lua gh jq fzf oven-sh/bun/bun rust jpegoptim svgo optipng delta
```

#### Casks command

```sh
brew install --cask iterm2 raycast arc notion rectangle codewhisperer spotify slack meetingbar obsidian
```

## Neovim & Terminal

1. Clone the repo

```sh
git clone https://github.com/scottykaye/dotfiles.git
```

2. Remove or rename your old `.zshrc` and `.zprofile` if they exist and make sure a `.config/nvim/` folder doesn't exist yet so we can symlink our files. If there is no `.config/` folder we will create it.

3. Symlink `.zshrc` and `.zprofile` and the `.oh-my-zsh/` files and create `.config/` folder.

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.zshrc  ~/.zshrc
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.zprofile  ~/.zprofile
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.oh-my-zsh ~/
mkdir ~/.config
```

4. Symlink the `nvim/` folder and `packer.nvim/` folders inside of the `.config/nvim/` folder and `~/.local/share/nvim/site/pack/packer/start/`.
   We need to make sure we have a version of packer that is typically [cloned](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#quickstart).

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim ~/.config/nvim
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim/packer.nvim ~/.local/share/nvim/site/pack/packer/start
```

5. To make sure Neovim is set up correctly, you're going to need to now source it and run a `PackerSync`.

```sh
vim ~/<PATH_TO_DOTFILES>/dotfiles/nvim/lua/scottykaye/packer.lua
```

6. In Vim run the `source` command then run a `PackerSync` command.

```vim
:so
:PackerSync
```

The `plugin` folder should now compile in `~/<PATH_TO_DOTFILES>/dotfiles/nvim/plugin` and you should now see Neovim as expected.

## Add font support

1. Lets move the font in the `fonts/` folder to the font `/Library/Fonts` directory.

```sh
cp -R ~/<PATH_TO_DOTFILES>/dotfiles/fonts/DroidSansMono.otf ~/Library/Fonts/DroidSansMono.otf
```

### Let's go!!! 😤😵‍💫
