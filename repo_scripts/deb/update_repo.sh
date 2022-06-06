#!/bin/bash

mv ~/deb/*.deb ~/deb/pool/

dpkg-scanpackages --arch amd64 ~/deb/pool/ > ~/deb/dists/drop/main/binary-amd64/Packages

sed -i 's/Maintainer.*/Maintainer: <makarov>/' ~/deb/dists/drop/main/binary-amd64/Packages
sed -i 's/Homepage.*/Homepage: https:\/\/dropfaas.com/' ~/deb/dists/drop/main/binary-amd64/Packages
sed -i 's/Description.*/Description: Distributed Reliable Operations Platform/' ~/deb/dists/drop/main/binary-amd64/Packages

cat ~/deb/dists/drop/main/binary-amd64/Packages | gzip -9 > ~/deb/dists/drop/main/binary-amd64/Packages.gz
./generate-release.sh > ~/deb/dists/drop/Release

