#!/bin/bash

# KEYSTORE EXPLORER

BINTRAY_USER=$1
BINTRAY_REPO=$2
BINTRAY_API_KEY=$3

DOWNLOAD_URL=https://github.com/kaikramer/keystore-explorer/releases/download/v5.2.2/kse-522.zip
NAME=KeystoreExplorer
VERSION=5.2.2
ARCH=x86_64

wget $DOWNLOAD_URL -O download.zip
unzip download.zip -d tmp
rm download.zip
mv tmp/*/* $NAME/usr/bin/
rm $NAME/usr/bin/kse.exe
rm $NAME/usr/bin/kse.sh
rm $NAME/usr/bin/readme.txt
mv $NAME/usr/bin/kse.jar $NAME/usr/bin/application.jar

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
