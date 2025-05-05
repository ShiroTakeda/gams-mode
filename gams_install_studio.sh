#!/bin/bash

# Script to download and install GAMS Studio for macOS
# This script detects the system architecture and downloads the appropriate DMG file

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to display error messages and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error_exit "This script is only for macOS systems."
fi

# Determine system architecture
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    ARCH_TYPE="arm_64"
elif [[ "$ARCH" == "x86_64" ]]; then
    ARCH_TYPE="x86_64"
else
    error_exit "Unsupported architecture: $ARCH"
fi

echo "Detected architecture: $ARCH_TYPE"

# Get the latest release version from GitHub
echo "Fetching latest GAMS Studio version..."
if command_exists curl; then
    LATEST_URL=$(curl -s -L -I -o /dev/null -w '%{url_effective}' https://github.com/GAMS-dev/studio/releases/latest)
    VERSION=$(echo "$LATEST_URL" | grep -o '[^/]*$')
elif command_exists wget; then
    LATEST_URL=$(wget --spider -S "https://github.com/GAMS-dev/studio/releases/latest" 2>&1 | grep Location | tail -1 | awk '{print $2}')
    VERSION=$(echo "$LATEST_URL" | grep -o '[^/]*$')
else
    error_exit "Neither curl nor wget is installed. Please install one of them."
fi

if [[ -z "$VERSION" ]]; then
    error_exit "Could not determine the latest version."
fi

echo "Latest version: $VERSION"

# Construct download URL
DOWNLOAD_URL="https://github.com/GAMS-dev/studio/releases/download/$VERSION/GAMS_Studio-${VERSION#v}-$ARCH_TYPE.dmg"
DMG_FILE="/tmp/GAMS_Studio-${VERSION#v}-$ARCH_TYPE.dmg"

echo "Downloading GAMS Studio from $DOWNLOAD_URL..."
if command_exists curl; then
    curl -L "$DOWNLOAD_URL" -o "$DMG_FILE" || error_exit "Failed to download GAMS Studio."
elif command_exists wget; then
    wget "$DOWNLOAD_URL" -O "$DMG_FILE" || error_exit "Failed to download GAMS Studio."
fi

echo "Download completed. Installing GAMS Studio..."

# Mount the DMG file
MOUNT_POINT="/Volumes/GAMS Studio"
hdiutil attach "$DMG_FILE" || error_exit "Failed to mount the DMG file."

# Check if GAMS Studio is already installed
if [ -d "/Applications/GAMS Studio.app" ]; then
    echo "GAMS Studio is already installed. Removing the old version..."
    rm -rf "/Applications/GAMS Studio.app" || error_exit "Failed to remove the old version."
fi

# Copy the app to Applications folder
echo "Copying GAMS Studio to Applications folder..."
cp -R "$MOUNT_POINT/GAMS Studio.app" /Applications/ || error_exit "Failed to copy GAMS Studio to Applications folder."

# Unmount the DMG file
echo "Unmounting the DMG file..."
hdiutil detach "$MOUNT_POINT" || error_exit "Failed to unmount the DMG file."

# Clean up
echo "Cleaning up..."
rm "$DMG_FILE"

echo "GAMS Studio has been successfully installed in the Applications folder."
