#!/bin/sh

cd "$(realpath "$(dirname "${0}")")"

repo='https://gitlab.com/SpaceVim/SpaceVim'
git clone --depth 1 ${repo} ./.config/nvim
