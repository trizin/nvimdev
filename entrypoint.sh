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

if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "$GIT_USER_EMAIL" ]; then
	git config --global user.name "$GIT_USER_NAME"
	git config --global user.email "$GIT_USER_EMAIL"
fi

cd /workspace
exec /bin/zsh
