# Home-Manager + Flake

This is my personal home-manager configuration. I've created it as a hybrid of scripts and flakes as I learn and improve my nix skills.

This was used and tested with Ubuntu 22.10.

```shell
./install.sh #Installs everything I use + nix & home-manager
```

```shell
./reload.sh #Rebuilds and switches to the home environment.
```

## Neovim

I'm using a config file for neovim (/.config/nvim/init.vim) because I haven't taken the time to migrate to flake settings. Since it's static, you'll need to do a few things manually to get it to work:

1. Install VIMPlug

    ```shell 
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```

2. Launch Neovim and click `<enter>` through the errors.

3. Use VIMPlug to install the plugins.

    ```vim
    :PlugInstall 
    ```

4. Load any package info you want:

    ```vim
    :TSInstall yaml toml go javascript python rust cpp
    ```

5. Install any binaries you want:

    ```vim
    :GoInstallBinaries
    ```
