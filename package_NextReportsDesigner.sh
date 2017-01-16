#!/bin/bash

# NEXTREPORTS DESIGNER

BINTRAY_USER=$1
BINTRAY_REPO=$2
BINTRAY_API_KEY=$3

DOWNLOAD_URL=http://www.asf.ro/next_reports_releases/nextreports-designer-9.1.zip
NAME=NextReportsDesigner 
VERSION=9.1.0
ARCH=x86_64

wget $DOWNLOAD_URL -O download.zip
unzip download.zip -d tmp
rm download.zip
mv tmp/*/jdbc-drivers $NAME/usr/lib/jdbc-drivers
mv tmp/*/lib/* $NAME/usr/lib/

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