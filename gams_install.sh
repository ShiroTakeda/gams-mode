#!/bin/sh

set -e  # Exit on errors

# Ensure GAMSVERSION is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <GAMSVERSION> [INSTALLDIR]"
    exit 1
fi

GAMSVERSION=$1

# Check if custom installation directory is provided (only for Linux)
if [ -n "$2" ]; then
    INSTALLDIR="$2"
fi

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
    MAJOR=${GAMSVERSION%%.*}
    INSTALLDIR=/Library/Frameworks/GAMS.framework/Versions/${MAJOR}/Resources/
    FILENAME=GAMS${GAMSVERSION}.pkg
    if [ "$ARCH" = "arm64" ]
    then
	ARCH_URL=macosx_arm64
    else
	ARCH_URL=macosx
    fi
else
    # Only set default INSTALLDIR if not already set
    if [ -z "$INSTALLDIR" ]; then
        INSTALLDIR=/opt/gams
    fi
    FILENAME=linux_${ARCH}_sfx.exe
    ARCH_URL=linux
fi

URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/${ARCH_URL}/${FILENAME}

# Define TMPDIR
TMPDIR=$(mktemp -d)
FILEPATH=${TMPDIR}/${FILENAME}

# Automatically clean up on script exit
trap 'rm -f "$FILEPATH"; rmdir "$TMPDIR"' EXIT

echo "Download GAMS ${GAMSVERSION} for $(uname) ${ARCH}"
curl "$URL" --output "$FILEPATH"

echo ""
echo "Install GAMS ${GAMSVERSION} to $INSTALLDIR"
set -x  # Print commands
if [ "$(uname)" = "Darwin" ]
then
    sudo installer -pkg "$FILEPATH" -target /
else
    # Make executable & install
    chmod +x "$FILEPATH"
    sudo mkdir -p "$INSTALLDIR"
    cd "$INSTALLDIR"
    sudo "$FILEPATH"
fi

set +x  # Stop printing commands

echo "GAMS installation completed successfully!"
if [ "$(uname)" = "Darwin" ]
then
    echo "GAMS was installed in /Library/Frameworks/GAMS.framework/Resources."
else
    echo "GAMS was installed in $INSTALLDIR/$(ls -t | head -n 1)."
fi
echo "Remember to add this folder to your PATH!"
