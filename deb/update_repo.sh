#!/bin/bash

dpkg-scanpackages --arch amd64 pool/ > dists/drop/main/binary-amd64/Packages

sed -i 's/Maintainer.*/Maintainer: <makarov>/' dists/drop/main/binary-amd64/Packages
sed -i 's/Homepage.*/Homepage: https:\/\/dropfaas.com/' dists/drop/main/binary-amd64/Packages
sed -i 's/Description.*/Description: Distributed Reliable Operations Platform/' dists/drop/main/binary-amd64/Packages

cat dists/drop/main/binary-amd64/Packages | gzip -9 > dists/drop/main/binary-amd64/Packages.gz
./generate-release.sh > dists/drop/Release

