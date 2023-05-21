#!/bin/bash

# Check if the .config directory exists
if [ ! -d "${HOME}/.config" ]; then
	mkdir -p "${HOME}/.config"
fi

# Create a symbolic link to /config if it doesn't already exist
if [ ! -e "${HOME}/.config/nvim" ]; then
	cp -ar /config/. "${HOME}"
fi

if ! diff -r --include='*.lua' /config "${HOME}/.config/nvim" >/dev/null 2>&1; then
	cp -ar /config/. "${HOME}"
fi

if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "$GIT_USER_EMAIL" ]; then
	git config --global user.name "$GIT_USER_NAME"
	git config --global user.email "$GIT_USER_EMAIL"
fi

chmod 600 ${HOME}/.ssh/id_rsa 

cd /workspace
exec /bin/zsh
