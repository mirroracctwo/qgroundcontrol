#! /usr/bin/env bash

if ! command -v brew &> /dev/null
then
	# install Homebrew if not installed yet
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	eval "$(/usr/local/bin/brew shellenv)"
fi

brew update
brew install cmake ninja ccache geographiclib git SDL2 exiv2 expat zlib shapelib pkgconf create-dmg

# Install GStreamer
GST_URL=https://gstreamer.freedesktop.org/data/pkg/osx
GST_VERSION=1.22.12
GST_DEV_PKG=gstreamer-1.0-devel-$GST_VERSION-universal.pkg
GST_PKG=gstreamer-1.0-$GST_VERSION-universal.pkg
pushd $TMPDIR
curl -O $GST_URL/$GST_VERSION/$GST_DEV_PKG
curl -O $GST_URL/$GST_VERSION/$GST_PKG
echo "Sudo may be required to install GStreamer"
sudo installer -pkg "$GST_DEV_PKG" -target /
sudo installer -pkg "$GST_DEV_PKG" -target /
rm $TMPDIR/$GST_DEV_PKG
rm $TMPDIR/$GST_PKG
popd