#!/usr/bin/env sh

symlink() {
    OVERWRITTEN=""

    if [ -e "$2" ] || [ -h "$2" ]; then
        OVERWRITTEN=" (overwritten)"
        if ! rm -r "$2"; then
            error "Failed to remove existing file(s) at '$2'."
        fi
    fi

    if ln -s "$1" "$2"; then
        success "Symlinked '$1' to '$2'$OVERWRITTEN."
    else
        error "Failed to symlink '$1' to '$2'."
    fi
}

clear_broken_symlinks() {
    find -L "$1" -type l | while read path; do
        if rm "$path"; then
            success "Removed broken symlink at '$path'."
        else
            error "Failed to remove broken symlink at '$path'."
        fi
    done
}
