# Neovim config

### Install Neovim

```shell
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz
./nvim-macos/bin/nvim
```

```shell
brew install neovim
```

```sh
brew install --cask iterm2 raycast arc notion rectangle codewhisperer spotify slack meetingbar obsidian discord
```

## Install Dotfiles Config

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

3. Symlink the `nvim/` folder at `.config/nvim/` folder and `~/.local/share/nvim/site/pack/packer/start/`.

> [!TIP]
> It's possible if you're on a new machine you don't yet have a hidden `~/.config` folder path and you'll need to create it to store the `~/.config/nvim` folder

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim ~/.config/nvim
```

5. To make sure Neovim is set up correctly, you're going to need to now source the `lazy.lua` file and run the `Lazy` command.

```sh
vim ~/<PATH_TO_DOTFILES>/dotfiles/nvim/init.lua
```

6. In Vim run the `source` command then run a `Lazy` command.

```vim
:so
:Lazy
```

The `plugin` folder should now compile in `~/<PATH_TO_DOTFILES>/dotfiles/nvim/plugin` and you should now see Neovim as expected.

## Add font support

1. Lets move the font in the `fonts/` folder to the font `/Library/Fonts` directory.

```sh
cp -R ~/<PATH_TO_DOTFILES>/dotfiles/fonts/DroidSansMono.otf ~/Library/Fonts/DroidSansMono.otf
```

### Let's go!!! 😤😵
