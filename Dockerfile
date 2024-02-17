# FROM alpine:latest
#
# WORKDIR /root
#
# RUN apk add --no-cache \
#     git \
#     nodejs \
#     npm \
#     python3 \
#     neovim \
#     ripgrep \
#     build-base \
#     clang17-extra-tools \
#     deno \
#
#     wget
# RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# CMD ["nvim"]



FROM fedora

WORKDIR /root

RUN dnf install -y  \
    git \
    nodejs \
    nodejs-npm \
    python3 \
    neovim \
    ripgrep \
    clang clang-devel \
    wget \
    unzip
CMD ["nvim"]
