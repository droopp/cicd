#!/bin/bash

set -e

echo $6

# fix ruby version
if [ "$5" == "rpm" ]; then
	source /opt/rh/rh-ruby27/enable
fi

export GIT_SSL_NO_VERIFY=true
REPO_URL="https://github.com"

echo "start building rpm.."
echo "target url "+$REPO_URL
echo "repo "+$1+$2
echo "branch "+$3

BUILD_DIR=$2"_"$3"_"$5

# create branch dir

rm -rf ~/$BUILD_DIR
echo "create dir $BUILD_DIR"
mkdir ~/$BUILD_DIR

# clone repo

cd ~/$BUILD_DIR/
git clone $REPO_URL/$1/$2.git
cd $2
git checkout $3

# set version

last_tag=$(git rev-list --tags --max-count=1)

echo "Tag version "$ver
if [ -z "$last_tag" ]
      then
        echo "No tag version"
        ver="0.1.0"
else
     ver=$(git describe --tags $last_tag)
fi

# if dev - add 4dig commit

if [ "$3" == "master" ]; then
        echo "build master version: $ver"
else
	cmt=$(git rev-parse --short HEAD)
        ver="$ver-$cmt"
        echo "build develop version: $ver"
fi

# move to dest

rm -rf ~/$BUILD_DIR/$2/.git
cp -r ~/$BUILD_DIR/$2 /opt/

# execute build script if exists

if [ -f "./install.sh" ]; then 
    bash ./install.sh
    rm -rf /opt/$2/install.sh
fi

# build rpm/deb

if [ -d "/opt/$2/conf-scripts" ]; then
  # Control will enter here if $DIRECTORY exists.

   fpm -s dir -t $5 -n $2 -v $ver --prefix /opt/$2\
    --before-install /opt/$2/conf-scripts/before-install\
    --after-install /opt/$2/conf-scripts/after-install\
    --before-remove /opt/$2/conf-scripts/before-install\
    -C /opt/$2
else
   fpm -s dir -t $5 -n $2 -v $ver --prefix /opt/$2\
    -C /opt/$2
fi

# mv to repo

if [ "$3" == "master" ]; then
        mv ~/$BUILD_DIR/$2/*.$5 ~/$5-master/
else
        mv ~/$BUILD_DIR/$2/*.$5 ~/$5-develop/
fi

# remove files

cd ~
rm -rf ~/$BUILD_DIR

# update repo

cd ~/repo_scripts/$5
./update_repo.sh $3

echo "repo $5 updated.."
