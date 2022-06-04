#!/bin/bash
#
# ./build.sh $type $git_group $repo_name $git_branch $git_tag $bin_type
#

set -e

pth=$(pwd)

sudo podman run --rm --net=host\
   -v $pth:/root\
   -v $pth/$6/:/root/$6/\
   -v ~/.ssh:/root/.ssh/\
   $1 /root/runner.sh $2 $3 $4 $5 $6

sudo chown -R buildbot:buildbot $pth/$6/*
