#!/usr/bin/env python3
from subprocess import run as sh
import click
import os

HOME = os.getenv('HOME')
assert HOME is not None, "Unable to access $HOME directory env var"

image_name = "nvim"
container_name = "nvim"


@click.group()
def cli():
    "Run a Neovim Config in a Container"


@cli.command()
def build():
    this_dir = os.path.dirname(os.path.realpath(__file__))
    sh(["podman", "build", "--layers", "-t", image_name, f"{this_dir}"])


@cli.command()
@click.option("-e", "engine",
              default="podman",
              show_default=True,
              help="The Container Runtime Engine, podman, docker or lilipod")
@click.option("-s", "--shell",
              default=False,
              is_flag=True,
              help="Start the container in a shell instead of neovim")
@click.option("-c", "config",
              default="astro",
              show_default=True,
              help=("The config to use, this must be the name of  a directory "
                    "under ./data/ which in turn contains both "
                    ".config/nvim and .local/share/nvim"))
def run(engine: str, config: str, shell: bool):
    # Setup config and local directories
    create_directories(config)
    conf_dir = f"./data/{config}/.config/nvim"
    local_dir = f"./data/{config}/.local/share/nvim"

    # Check if there is a git repo, if not assume there's no config
    if not os.path.exists(f"{conf_dir}/.git"):
        print(f"No Config under {conf_dir}! Cloning one with ./data/{config}/init.sh")
        sh(["sh", f"./data/{config}/init.sh"], check=True)

        # Command
    cmd = ["podman", "run"]

    # Options
    opt = ["-it"]
    opt += ["--rm"]
    opt += ["--userns=keep-id"]
    opt += vol(HOME, HOME)
    opt += vol(conf_dir, f"{HOME}/.config/nvim")
    opt += vol(local_dir, f"{HOME}/.local/share/nvim")
    cmd += opt

    # Specify image
    if engine == "podman":
        cmd += [f"localhost/{image_name}"]
    else:
        cmd += [f"{image_name}"]

    # Specify the command
    if shell:
        cmd += ["/bin/sh"]
    else:
        cmd += ["nvim"]

    print(" ".join(cmd))
    sh(cmd)



def create_directories(config: str):
    dirs = [".local/share/nvim", ".config/nvim"]
    dirs = [f"./data/{config}/" + d for d in dirs]

    for dir in dirs:
        if not os.path.exists(dir):
            os.makedirs(dir, exist_ok=True)


def vol(outside: str, inside: str):
    return ["--volume", f"{outside}:{inside}"]


if __name__ == "__main__":
    cli()
