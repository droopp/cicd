#!/bin/bash

if [ "$1" == "master" ]; then
   dest=deb-master
else
   dest=deb-develop
fi

mv ~/$dest/*.deb ~/$dest/pool/main/

cd ~/$dest
dpkg-scanpackages --multiversion --arch amd64 pool/ > dists/drop/main/binary-amd64/Packages
cd -

sed -i 's/Maintainer.*/Maintainer: <makarov>/' ~/$dest/dists/drop/main/binary-amd64/Packages
sed -i 's/Homepage.*/Homepage: https:\/\/dropfaas.com/' ~/$dest/dists/drop/main/binary-amd64/Packages
sed -i 's/Description.*/Description: Distributed Reliable Operations Platform/' ~/$dest/dists/drop/main/binary-amd64/Packages

cat ~/$dest/dists/drop/main/binary-amd64/Packages | gzip -9 > ~/$dest/dists/drop/main/binary-amd64/Packages.gz
./generate-release.sh $dest > ~/$dest/dists/drop/Release

