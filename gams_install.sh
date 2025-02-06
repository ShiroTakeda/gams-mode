#!/bin/sh

set -e  # Exit on errors
set -x  # Print commands

# Ensure GAMSVERSION is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <GAMSVERSION>"
    exit 1
fi

GAMSVERSION=$1

# Determine architecture
if [ "$(uname -m)" = "arm64" ]
then
    ARCH="arm64"
else
    if [ "$(uname)" = "Darwin" ]
    then
	ARCH="x86_64"
    else
	ARCH="x64_64"
    fi
fi

# Identify OS and set target variables
if [ "$(uname)" = "Darwin" ]
then
    INSTALLDIR=/Applications/GAMS
    FILENAME=osx_${ARCH}_sfx.exe
    URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/macosx/${FILENAME}
else
    INSTALLDIR=/opt/gams
    FILENAME=linux_${ARCH}_sfx.exe
    URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/linux/${FILENAME}
fi


# Define TMPDIR
TMPDIR=$(mktemp -d)
FILEPATH=${TMPDIR}/${FILENAME}

# Automatically clean up on script exit
trap 'rm -f "$FILEPATH"; rmdir "$TMPDIR"' EXIT

# Remove macOS quarantine attribute if needed
curl $URL --output $FILEPATH
if [ "$(uname)" = "Darwin" ]
then
    xattr -rd com.apple.quarantine $FILEPATH
fi

# Make executable & install
chmod +x $FILEPATH
sudo mkdir -p $INSTALLDIR
cd $INSTALLDIR
sudo $FILEPATH
