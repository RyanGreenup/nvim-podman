#!/bin/sh

echo "
This requires a bit more thought as Lunarvim has more than ~/.local/share and ~/.config
It also changes the name of the binary.

Lunarvim might atleast require mount

Either way I've only cloned the repo here
"

cd "$(realpath "$(dirname "${0}")")"

repo='https://github.com/LunarVim/LunarVim'
git clone --depth 1 ${repo} ./.config/nvim
