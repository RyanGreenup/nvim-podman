#!/bin/sh

cd "$(realpath "$(dirname "${0}")")"

repo='https://github.com/AstroNvim/AstroNvim'
git clone --depth 1 ${repo} ./.config/nvim
