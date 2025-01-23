#!/bin/sh

FILENAME=linux_x64_64_sfx.exe
FILEPATH=${TEMPDIR}/${FILENAME}
GAMSVERSION=$1
URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMSVERSION}/linux/${FILENAME}

curl $URL -o $FILEPATH
chmod +x $FILEPATH
sudo mkdir /opt/gams
cd /opt/gams
sudo $FILEPATH
rm $FILEPATH
