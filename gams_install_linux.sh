#!/bin/sh

set -e  # Exit on errors
set -x  # Print commands

if [ "$(uname -m)" = "arm64" ]
then
    arch="arm64"
else
    arch="x64_64"
fi

# Define TMPDIR if not set
TMPDIR="${TMPDIR:-/tmp}"

INSTALLDIR=/opt/gams
FILENAME=linux_${arch}_sfx.exe
FILEPATH=${TMPDIR}/${FILENAME}
GAMSVERSION=$1
URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/linux/${FILENAME}

curl $URL --output $FILEPATH
chmod +x $FILEPATH
sudo mkdir -p $INSTALLDIR
cd $INSTALLDIR
sudo $FILEPATH
rm $FILEPATH
