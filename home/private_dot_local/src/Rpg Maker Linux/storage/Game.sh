#!/usr/bin/bash

set -e

# Check for required commands
if ! command -v cicpoffs >/dev/null 2>&1
then
    echo >&2 "cicpoffs is required but it's not installed."
    echo >&2 "Install it here: https://github.com/adlerosn/cicpoffs/releases/latest."
    exit 1
fi

if ! command -v gamemoderun >/dev/null 2>&1
then
    echo >&2 "gamemode is required but it's not installed."
    echo >&2 "Run to install: sudo apt install gamemode"
    exit 1
fi

clean_up() {
    # Unmount the game files
    if ! fusermount -u "${XDG_DATA_HOME:-${HOME}/.local/share}"/nwjs/www
    then
        echo "Error: Failed to unmount."; exit 1
    fi

    # Remove package.json in the game engine folder
    if ! rm "${XDG_DATA_HOME:-${HOME}/.local/share}"/nwjs/package.json
    then
        echo "Error: Failed to remove package.json."; exit 1
    fi
}
trap clean_up EXIT

# Check if the "www" folder exists
if [ ! -d "./www" ]
then
    echo "Error: 'www' folder not found."; exit 1
fi

# Copy package.json
if ! cp ./package.json "${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs/package.json"
then
    echo "Error: Failed to copy package.json."; exit 1
fi

# Mount the game files non case sensitive
if ! cicpoffs ./www "${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs/www"
then
    echo "Error: Failed to mount."; exit 1
fi

# Launch the main executable
if ! gamemoderun "${XDG_DATA_HOME:-${HOME}/.local/share}/nwjs/nw"
then
    echo "Error: Failed to launch."; exit 1
fi

echo "Finished!"
