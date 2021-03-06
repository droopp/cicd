#!/bin/sh
set -e

do_hash() {
    HASH_NAME=$1
    HASH_CMD=$2
    echo "${HASH_NAME}:"
    for f in $(find ~/$3/ -type f|grep *.deb); do
        f=$(echo $f | cut -c3-) # remove ./ prefix
        if [ "$f" = "Release" ]; then
            continue
        fi
        echo " $(${HASH_CMD} ${f}  | cut -d" " -f1) $(wc -c $f)"
    done
}

cat << EOF
Origin: DROP Repository
Label: DROP
Suite: drop
Codename: drop
Version: 1.0
Architectures: amd64
Components: main
Description: Distributed Reliable Operations Platform
Date: $(date -Ru)
EOF
do_hash "MD5Sum" "md5sum" $1
do_hash "SHA1" "sha1sum" $1
do_hash "SHA256" "sha256sum" $1
