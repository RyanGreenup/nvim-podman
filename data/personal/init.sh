#!/bin/sh
set -euf

cd "$(dirname "$(realpath "${0}")")"

conf=".config/"
local=".local/share/"

mkdir -p "${conf}" "${local}"

for dir in "${conf}" "${local}"; do
    doas cp -ar "${HOME}/${dir}/nvim" ./"${dir}/"
done

# Create a git file so the py script doesn't try and run init again
touch "./${conf}/nvim/.git"
