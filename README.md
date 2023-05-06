# Neovim Development Container

This is a simple script to manage development containers for Neovim. It allows you to create, list, attach to, and remove Neovim development containers using Docker or Podman. This can be useful for working in isolated environments and managing multiple development instances with ease.

## Prerequisites

- Docker or Podman installed on your system.
- Neovim config

## Usage
```bash
./nvim_dev_container.sh [COMMAND] [OPTIONS]
```


### Commands

- `run`: Run a container or attach to an existing one.
- `list`: List all containers created by this script.
- `remove`: Remove a stopped container.
- `logs`: Display logs of a container.
- `-h`, `--help`: Display help message.

### Options

- `--workspacedir DIR`: Set the workspace directory (default: current directory).
- `--neovimdir DIR`: Set the Neovim configuration directory (default: `~/.config/nvim`).
- `--id ID`: Set the container ID (default: 1).
- `--ssh`: Mount the SSH directory inside the container.
