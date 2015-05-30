sudo apt-get install -y git emacs24 apt-file g++ openssh-server cscope wireshark dos2unix clang manpages-posix-dev terminator silversearcher-ag

sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' $(which dumpcap)

cp .bash* ~/
. ~/.bashrc
