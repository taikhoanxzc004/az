rm -rf /usr/local/src/xmrig/build/config.json
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
        "rx": [0, 1, 2, 3],
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
            "tls": false,
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
