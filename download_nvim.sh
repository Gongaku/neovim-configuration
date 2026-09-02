#!/usr/bin/env bash

get_os() { uname -s | grep "Darwin" -q && printf "macos" || printf "linux"; }

is_installed() { command -v "$1" &> /dev/null; }

filter_version_string() { head -n 1 | awk '{print $2}'; }

get_neovim_version() { nvim --version | filter_version_string; }

is_update_available() {
	local LATEST_RELEASE_URL LATEST_VERSION
	LATEST_RELEASE_URL="https://api.github.com/repos/neovim/neovim/releases"
	LATEST_VERSION=$(curl "$LATEST_RELEASE_URL" --silent | jq -r '.[0] | .body' | grep -E '^NVIM' | filter_version_string)
	[[ "$(get_neovim_version)" != "$LATEST_VERSION" ]]
}

# SCRIPT_DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))
OPERATING_SYSTEM="$(get_os)"
ARCHITECTURE="$(arch)"
TARBALL="nvim-$OPERATING_SYSTEM-$ARCHITECTURE.tar.gz"
URL="https://github.com/neovim/neovim/releases/download/nightly/$TARBALL"
IS_DOWNLOAD_REQUIRED=true

if is_installed nvim && is_update_available; then
	MESSAGE="Upgrade Neovim from '$(get_neovim_version)' to"
elif is_installed nvim; then
	MESSAGE="No update available. Current version:"
	IS_DOWNLOAD_REQUIRED=false
else
	MESSAGE="Installed Neovim version:"
fi

if "$IS_DOWNLOAD_REQUIRED"; then
	echo "Starting download"
	_cleanup_nvim_tarball() { rm -f -- "$TARBALL"; }
	trap _cleanup_nvim_tarball EXIT
	curl "$URL" -LO "$TARBALL" --silent

	EXTRACT_COMMANDS=$(
		cat <<- EXTRACT
			rm -rf /usr/bin/nvim* /opt/neovim
			tar -C /opt -xzf "$TARBALL" \
				&& mv /opt/${TARBALL%%.*} /opt/neovim \
				&& chown 0:0 /opt/neovim/bin/nvim

			if [ ! -e /usr/local/bin/nvim ]; then
				ln -sf "/opt/neovim/bin/nvim" "/usr/local/bin/nvim"
			fi
		EXTRACT
	)

	echo "Installing Neovim for system-wide usage requires 'sudo' access:"
	sudo bash -c "$EXTRACT_COMMANDS"
fi

printf "%s '%s'\n" "$MESSAGE" "$(get_neovim_version)"
