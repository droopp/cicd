#!/bin/bash
#
# ./build.sh $type $git_group $repo_name $git_branch $git_tag $bin_type
#

set -e

pth=$(pwd)

if [ "$4" == "master" ]; then
	work_dir="$6-master"
else
	work_dir="$6-develop"
fi

sudo podman run --rm --net=host\
   -v $pth:/root\
   -v $pth/$work_dir/:/root/$work_dir/\
   -v ~/.ssh:/root/.ssh/\
   $1 /root/runner.sh $2 $3 $4 $5 $6

sudo chown -R buildbot:www-data $pth/$work_dir/*
