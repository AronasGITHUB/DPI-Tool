#!/bin/bash
# BEFORE MODIFCATION, SELLING, COPYING, ETC. PLEASE CHECK OUR LICENSE
# LICENSES ARE NOT LEGAL ADVICE.

GITHUB_REPO="https://github.com/AronasGITHUB/DPI-Tool"
LOCAL_DIR="/DPI-Tool"

echo "======================"
echo "  DPI Updater - 1.0   " # Funny how people update the updater.
echo "======================"

LATEST_RELEASE=$(curl -s "$GITHUB_REPO/releases/latest" | grep "href=\"/AronasGITHUB/DPI-Tool/releases/tag/" | head -1 | sed -E 's/.*\/tag\/(.*)\".*/\1/')
echo "Latest release found: $LATEST_RELEASE"

# Just in case your computer gets deleted.
read -p "[!] This will delete ALL files in $LOCAL_DIR, are you sure you want to continue? (y/n) " confirm

if [[ $confirm == [yY] ]]; then
    echo "Removing current files in $LOCAL_DIR..."
    rm -rf "$LOCAL_DIR/*"
    echo "Cloning the latest release..."
    git clone --branch "$LATEST_RELEASE" "$GITHUB_REPO.git" "$LOCAL_DIR"
    echo "Files updated successfully."
else
    echo "Operation canceled."
fi

