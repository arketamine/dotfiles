#!/usr/bin/env sh

WORKING_DIR=fish

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/index.sh

sudo -v

PREVIOUS_DIRECTORY=$(pwd)
cd $WORKING_DIR

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/.config/fish)"

info "Setting up Fish..."
info "Creating Fish config directories..."

mkdir -p "$DESTINATION/functions"
mkdir -p "$DESTINATION/completions"

info "Symlinking Fish config files..."

find * -name "*.fish" | while read path; do
    symlink "$SOURCE/$path" "$DESTINATION/$path"
done

clear_broken_symlinks "$DESTINATION"

set_fish_shell() {
    if grep -quiet fish <<<"$SHELL"; then
        success "Fish is already the default shell."
    else
        info "Adding Fish executable to /etc/shells"

        if grep --fixed-strings --line-regexp --quiet "$(which fish)" /etc/shells; then
            success "Fish executable already exists in /etc/shells"
        else
            if sudo bash -c "echo "$(which fish)" >> /etc/shells"; then
                success "Fish executable added to /etc/shells"
            else
                error "Failed adding Fish executable to /etc/shells"
                return 1
            fi
        fi

        info "Setting default shell to Fish..."

        if chsh -s "$(which fish)"; then
            success "Default shell set to Fish."
        else
            error "Failed to set default shell to Fish."
            return 1
        fi

        info "Running Fish initial setup"
        fish -c "setup"
    fi
}

if set_fish_shell; then
    success "Fish shell setup complete."
else
    error "Fish shell setup failed."
fi

cd $PREVIOUS_DIRECTORY
