# Neovim in a Podman

This allows a user to use multiple neovim configs by creating a container with mounts based on command line arguments.

## Usage

### Quick Start

for example to use astrovim:

```sh
# Build the image
./run build

# Run the container
./run.py run -c astro
```

### How it Works

When the container runs, it will check if there is a `./data/astro/.config/.git` directory and if there isn't it will run `./data/astro/init.sh` in order to clone the config files into `./data/astro/{.config,.local/share}`. These two directories are then mounted as volumes into the container under `$HOME` as usual.


### Listing all the configs


```sh
ls ./data
```

```
astro  luna  nvchad  personal  space
```


### Creating your own configs

```sh
conf_name="my_config"
mkdir -p ./data/${conf_name}/.local/share/nvim
mkdir -p ./data/${conf_name}/.config/nvim

# an init script to clone the config into ./data/${conf_name}/.config/nvim
nvim ./data/${conf_name}/init.sh
```
