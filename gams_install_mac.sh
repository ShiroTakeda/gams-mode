#!/bin/sh

set -e  # Exit on errors
set -x  # Print commands

if [ "$(uname -m)" = "arm64" ]
then
    arch="arm64"
else
    arch="x86_64"
fi

# Define TMPDIR if not set
TMPDIR="${TMPDIR:-/tmp}"

INSTALLDIR=/Applications/GAMS
FILENAME=osx_${arch}_sfx.exe
FILEPATH=${TMPDIR}/${FILENAME}
GAMSVERSION=$1
URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/macosx/${FILENAME}

curl $URL --output $FILEPATH
xattr -rd com.apple.quarantine $FILEPATH
chmod +x $FILEPATH
sudo mkdir -p $INSTALLDIR
cd $INSTALLDIR
sudo $FILEPATH
rm $FILEPATH
