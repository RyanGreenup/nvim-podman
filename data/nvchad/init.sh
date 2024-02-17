#!/bin/sh

cd "$(realpath "$(dirname "${0}")")"

repo='https://github.com/NvChad/NvChad'
git clone --depth 1 ${repo} ./.config/nvim

