image_name="nvchad"
container_name="nvchad"


mkdir -p ./local
podman build --layers -t ${image_name} .
# podman run --userns=keep-id --rm -it -w /root --volume ./local:/root/.local localhost/${image_name} nvim


config="astro"
if [ -n "${1:+}" ]; then
    config="${1}"
else
    echo "No Config set, defaulting to ${config}"
    echo "You may choose one of "
    ls ./data/
fi

# make the directories if this is a first run
conf_dir="./data/${config}/.config/nvim"
local_dir="./data/${config}/.local/share/nvim"
mkdir -p ${conf_dir} ${local_dir}


# --volume ./local:/root/.local   \
podman run --rm -it --userns=keep-id  \
    --volume $HOME:$HOME \
    --volume ${conf_dir}:$HOME/.config/nvim \
    --volume ${local_dir}:$HOME/.local/share/nvim \
    --volume ./data/${config}/init:/usr/bin/init-nvim \
    localhost/${image_name}  \
    /usr/bin/init-nvim && nvim


