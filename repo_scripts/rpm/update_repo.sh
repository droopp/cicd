#!/bin/bash

if [ "$1" == "master" ]; then
   dest=rpm-master
else
   dest=rpm-develop
fi

createrepo --update ~/$dest/
