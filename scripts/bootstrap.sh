echo "Setting up git ..."
. git-config.sh

echo "Setting up bash ..."
cp .bash* ~/
. ~/.bashrc

sudo apt-get install -y git emacs24 apt-file g++ openssh-server cscope wireshark dos2unix clang manpages-posix-dev terminator silversearcher-ag cmake autoconf libtool meld

sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' $(which dumpcap)
