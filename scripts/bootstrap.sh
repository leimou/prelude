sudo apt-get install -y git emacs24 apt-file g++ openssh-server cscope wireshark dos2unix clang manpages-posix-dev terminator silversearcher-ag

sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' $(which dumpcap)

echo "Downloading redis ..."
wget http://download.redis.io/releases/redis-3.0.1.tar.gz

echo "Setting up bash ..."
cp .bash* ~/
. ~/.bashrc

echo "Setting up git ..."
. git-config.sh
