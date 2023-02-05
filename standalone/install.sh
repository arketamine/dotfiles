#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/index.sh

sudo -v

info "Downloading and installing Nix..."
curl -L https://nixos.org/nix/install | sh
success "Nix installed successfully."
