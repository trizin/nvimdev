#!/bin/bash

#!/bin/bash

# Check if the .config directory exists
if [ ! -d "${HOME}/.config" ]; then
	mkdir -p "${HOME}/.config"
fi

# Create a symbolic link to /neovim if it doesn't already exist
if [ ! -e "${HOME}/.config/nvim" ]; then
	cp -r /neovim "${HOME}/.config/nvim"
fi

if ! diff -r --include='*.lua' /neovim "${HOME}/.config/nvim" >/dev/null 2>&1; then
	cp -r /neovim/* "${HOME}/.config/nvim/"
fi

cd /workspace
exec /bin/zsh
