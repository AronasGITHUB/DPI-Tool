#!/bin/bash

# Set the GitHub repository URL
REPO="https://github.com/AronasGITHUB/DPI-Tool"
RELEASE_URL="$REPO/releases/latest"
LOCAL_DIR="$HOME/DPI-Tool"

# Function to check the latest release
function check_latest_release() {
    echo "Checking for the latest release..."
    # Get the latest release tag from GitHub
    latest_version=$(curl -sL -o /dev/null -w %{url_effective} $RELEASE_URL | grep -o 'v[0-9.]*$')
    echo "Latest version: $latest_version"
}

# Function to update the DPI Tool
function update_dpi_tool() {
    if [ -d "$LOCAL_DIR" ]; then
        echo "DPI Tool found locally. Pulling updates..."
        cd "$LOCAL_DIR" && git pull
        echo "DPI Tool updated to the latest version."
    else
        echo "DPI Tool not found locally. Cloning the repository..."
        git clone "$REPO" "$LOCAL_DIR"
        echo "DPI Tool installed."
    fi
}

# Function to run the update check and process
function run_update() {
    check_latest_release
    update_dpi_tool
}

# Main process
run_update

