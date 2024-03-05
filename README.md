# Scotty Kaye dotfiles

Instructions on setting up dotfiles:

1. Clone the repo

```sh
git clone https://github.com/scottykaye/dotfiles.git
```

2. Remove or rename your old `.zshrc` and `.zprofile` if they exist. Make sure in your `.config/` root folder has an `nvim/` folder.

```sh
mkdir ~/.config/nvim
```

3. Symlink `.zshrc` and `.zprofile`

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.zshrc  ~/.zshrc
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/zsh/.zprofile  ~/.zprofile
```

4. Symlink the following inside of the `.config/nvim/` folder: `after/`, `init.lua`, `lua/`

```sh
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim/after  ~/.config/nvim/after
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim/init.lua  ~/.config/nvim/init.lua
ln -s ~/<PATH_TO_DOTFILES>/dotfiles/nvim/lua  ~/.config/nvim/lua
```

5. To make sure Neovim is set up correctly, you're going to need to now source it and run a `PackerSync`

```sh
vim ~/<PATH_TO_DOTFILES>/dotfiles/nvim/lua/scottykaye/packer.lua
```

In Vim run the `source` command then run a `PackerSync` command

```vim
:so
:PackerSync
```

The `plugin` folder should now compile in `~/<PATH_TO_DOTFILES>/dotfiles/nvim/plugin` and you should now see Neovim as expected.
