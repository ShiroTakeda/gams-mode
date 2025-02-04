#!/bin/sh

set -e  # Exit on errors
set -x  # Print commands

if [ "$(uname -m)" = "arm64" ]
then
    mac="arm64"
else
    mac="x86_64"
fi

FILENAME=osx_${mac}_sfx.exe
FILEPATH=~/Downloads/${FILENAME}
GAMSVERSION=$1
URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/macosx/${FILENAME}

curl $URL -o $FILEPATH
xattr -rd com.apple.quarantine $FILEPATH
chmod +x $FILEPATH
sudo mkdir /Applications/GAMS
cd /Applications/GAMS
sudo $FILEPATH
rm $FILEPATH
