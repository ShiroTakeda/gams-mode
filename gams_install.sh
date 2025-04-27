#!/bin/sh

set -e  # Exit on errors

# Ensure GAMSVERSION is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <GAMSVERSION> [INSTALLDIR]"
    exit 1
fi

GAMSVERSION=$1

# Check if custom installation directory is provided
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
	ARCH="x86_64"
    fi
fi

# Identify OS and set target variables
if [ "$(uname)" = "Darwin" ]
then
    # Only set default INSTALLDIR if not already set
    if [ -z "$INSTALLDIR" ]; then
        INSTALLDIR=/Applications/GAMS
    fi
    FILENAME=osx_${ARCH}_sfx.exe
    URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/macosx/${FILENAME}
else
    # Only set default INSTALLDIR if not already set
    if [ -z "$INSTALLDIR" ]; then
        INSTALLDIR=/opt/gams
    fi
    FILENAME=linux_${ARCH}_sfx.exe
    URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/linux/${FILENAME}
fi


# Define TMPDIR
TMPDIR=$(mktemp -d)
FILEPATH=${TMPDIR}/${FILENAME}

# Automatically clean up on script exit
trap 'rm -f "$FILEPATH"; rmdir "$TMPDIR"' EXIT

echo "/nDownloading GAMS ${GAMSVERSION} for $(uname) ${ARCH}"
curl $URL --output $FILEPATH
# Remove macOS quarantine attribute if needed
if [ "$(uname)" = "Darwin" ]
then
    xattr -rd com.apple.quarantine $FILEPATH
fi


echo "Installing GAMS ${GAMSVERSION} to $INSTALLDIR"
set -x  # Print commands
# Make executable & install
chmod +x $FILEPATH
sudo mkdir -p $INSTALLDIR
cd $INSTALLDIR
sudo $FILEPATH
set +x  # Stop printing commands

echo "GAMS installation completed successfully!"
echo "GAMS was installed in $INSTALLDIR/$(ls -t | head -n 1)."
echo "Remember to add this folder to your PATH!"
