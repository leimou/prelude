sudo apt-get install -y git emacs24 apt-file g++ openssh-server cscope wireshark

md ~/Github
git clone https://github.com/ggreer/the_silver_searcher.git ~/Github

sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' $(which dumpcap)
