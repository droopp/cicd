echo "                    ___           ___           ___        "
echo "     _____         /\  \         /\  \         /\  \       "
echo "    /::\  \       /::\  \       /::\  \       /::\  \      "
echo "   /:/\:\  \     /:/\:\__\     /:/\:\  \     /:/\:\__\     "
echo "  /:/  \:\__\   /:/ /:/  /    /:/  \:\  \   /:/ /:/  /     "
echo " /:/__/ \:|__| /:/_/:/__/___ /:/__/ \:\__\ /:/_/:/  /      "
echo " \:\  \ /:/  / \:\/:::::/  / \:\  \ /:/  / \:\/:/  /       "
echo "  \:\  /:/  /   \::/~~/~~~~   \:\  /:/  /   \::/__/        "
echo "   \:\/:/  /     \:\~~\        \:\/:/  /     \:\  \        "
echo "    \::/  /       \:\__\        \::/  /       \:\__\       "
echo "     \/__/         \/__/         \/__/         \/__/       "
echo "                                                           "
echo "                                                           "
echo "     Bootstrap Script                                      "
echo "                                                           "
echo " curl https://dropfaas.com/boot/drop-bootstrap.sh|sh       "
echo "                                                           "

# Parameters

REPOURL="http://134.122.23.140"
BRANCH="master"
YUM_OPTS='--disablerepo="*" --enablerepo="drop"'

# check distrib version

distrib="$(awk -F= '/^NAME/{print $2}' /etc/os-release)"
if [[ "$distrib" == *"Ubuntu"* ]]; then
    echo "Installing drop on $distrib"                                                                   

elif [[ "$distrib" == *"CentOS"* ]]; then
    echo "Installing drop on $distrib"                                                                   

else
    echo "undefine OS"                                                          
    exit 1
fi


# system conf
#
# ulimit -n 1000000
# 
# sysctl -w vm.swappiness=60 # 10
# sysctl -w vm.vfs_cache_pressure=400  # 10000
# sysctl -w vm.dirty_ratio=40 # 20
# sysctl -w vm.dirty_background_ratio=1
# sysctl -w vm.dirty_writeback_centisecs=500
# sysctl -w vm.dirty_expire_centisecs=30000
# sysctl -w kernel.panic=10
# sysctl -w fs.file-max=1000000
# sysctl -w net.core.netdev_max_backlog=10000
# sysctl -w net.core.somaxconn=65535
# sysctl -w net.ipv4.tcp_syncookies=1
# sysctl -w net.ipv4.tcp_max_syn_backlog=262144
# sysctl -w net.ipv4.tcp_max_tw_buckets=720000
# sysctl -w net.ipv4.tcp_tw_recycle=1
# sysctl -w net.ipv4.tcp_timestamps=1
# sysctl -w net.ipv4.tcp_tw_reuse=1
# sysctl -w net.ipv4.tcp_fin_timeout=30
# sysctl -w net.ipv4.tcp_keepalive_time=1800
# sysctl -w net.ipv4.tcp_keepalive_probes=7
# sysctl -w net.ipv4.tcp_keepalive_intvl=30
# sysctl -w net.core.wmem_max=33554432
# sysctl -w net.core.rmem_max=33554432
# sysctl -w net.core.rmem_default=8388608
# sysctl -w net.core.wmem_default=4194394
# sysctl -w net.ipv4.tcp_rmem="4096 8388608 16777216"
# sysctl -w net.ipv4.tcp_wmem="4096 4194394 16777216"

echo ""
echo "STEP 1. Define repo.."
echo ""

if [[ "$distrib" == *"Ubuntu"* ]]; then

echo 'deb [trusted=yes] '$REPOURL'/deb-'$BRANCH'/ drop main' > /etc/apt/sources.list.d/drop.list

elif [[ "$distrib" == *"CentOS"* ]]; then

echo '[drop]
name=DROP
baseurl='$REPOURL'/rpm-'$BRANCH'/
gpgcheck=0
enabled=1
metadata_expire=1m
http_caching=packages
mirrorlist_expire=1m
' > /etc/yum.repos.d/drop.repo


fi

echo ""
echo "STEP 2. Install packages.."
echo ""


if [[ "$distrib" == *"Ubuntu"* ]]; then

apt-get update
apt-get -t drop install -y erlang

elif [[ "$distrib" == *"CentOS"* ]]; then

yum update
yum install $YUM_OPTS -y erlang 

fi

