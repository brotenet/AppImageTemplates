#!/bin/bash

BINTRAY_USER=$1
BINTRAY_REPO=$2
BINTRAY_API_KEY=$3

NAME=SweetHome3D
VERSION=6.0
ARCH=x86_64
DOWNLOAD_URL=https://sourceforge.net/projects/sweethome3d/files/SweetHome3D/SweetHome3D-$VERSION/SweetHome3D-$VERSION-linux-x64.tgz

wget $DOWNLOAD_URL -O download.tgz
mkdir tmp
tar -xvzf download.tgz -C tmp
mv tmp/*/* $NAME/usr/bin/
rm download.tar.gz

cp _res/run.wrapper $NAME/usr/bin/run.wrapper
cp _res/AppRun $NAME/AppRun

if [ "$#" -eq 3 ]; then
	./appimagetool $NAME $NAME-$VERSION-$ARCH.AppImage --bintray-user=$BINTRAY_USER --bintray-repo=$BINTRAY_REPO
	echo ""
	echo "Uploading AppImage file to Bintray..."
	curl -T $NAME-$VERSION-$ARCH.AppImage -u$BINTRAY_USER:$BINTRAY_API_KEY https://api.bintray.com/content/$BINTRAY_USER/$BINTRAY_REPO/$NAME/$VERSION/$NAME-$VERSION-$ARCH.AppImage
	echo ""
	echo "Uploading zsync file to Bintray..."
	curl -T $NAME-$VERSION-$ARCH.AppImage.zsync -u$BINTRAY_USER:$BINTRAY_API_KEY https://api.bintray.com/content/$BINTRAY_USER/$BINTRAY_REPO/$NAME/$VERSION/$NAME-$VERSION-$ARCH.AppImage.zsync
	echo ""
else
	./appimagetool $NAME $NAME-$VERSION-$ARCH.AppImage
fi
