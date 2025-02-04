#!/bin/sh

set -e  # Exit on errors
set -x  # Print commands

# Define TMPDIR if not set
TMPDIR="${TMPDIR:-/tmp}"

FILENAME=linux_x64_64_sfx.exe
FILEPATH=${TMPDIR}/${FILENAME}
GAMSVERSION=$1
URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/linux/${FILENAME}

curl $URL --output $FILEPATH
chmod +x $FILEPATH
sudo mkdir --parents /opt/gams
cd /opt/gams
sudo $FILEPATH
rm $FILEPATH
