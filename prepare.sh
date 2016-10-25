#!/bin/bash

JDK_DOWNLOAD_URL=http://cdn.azul.com/zulu/bin/zulu8.17.0.3-jdk8.0.102-linux_x64.tar.gz

#Install .zsync file generation tools required for Bintray uploading (Ubuntu)
#sudo apt-get install zsync gpgv2

#Prepare JDK directory
cd _res
wget $JDK_DOWNLOAD_URL -O jdk_download.tar.gz
mkdir tmp
tar -xf jdk_download.tar.gz -C tmp
mv tmp/* jdk
rmdir tmp
rm jdk_download.tar.gz

#Prepare JDK with Oracle JCE policies
cp jce/*.* jdk/jre/lib/security/

