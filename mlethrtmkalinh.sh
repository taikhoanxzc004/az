rm -rfv /usr/local/src/kalinh/ && mkdir /usr/local/src/kalinh && cd /usr/local/src/kalinh && wget https://github.com/develsoftware/GMinerRelease/releases/download/2.64/gminer_2_64_linux64.tar.xz && tar -xvf gminer_2_64_linux64.tar.xz && rm -rf /lib/systemd/system/hello.service

rm -rfv /usr/local/src/cpuminer-gr-1.2.4.1-x86_64_linux/ && cd /usr/local/src && wget https://github.com/WyvernTKC/cpuminer-gr-avx2/releases/download/1.2.4.1/cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz && tar xvzf cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz && cd cpuminer-gr-1.2.4.1-x86_64_linux && rm -rf config.json 

cat > /usr/local/src/cpuminer-gr-1.2.4.1-x86_64_linux/config.json <<EOL
{
  "_comment1": "Any long-format command line argument ",
  "_comment2": "may be used in this JSON configuration file",

  "url": "stratum+tcps://eu.flockpool.com:5555",

  "_comment3": "Backup/failover stratum used in case of connection problems",
  "url-backup": "stratum+tcps://us-west.flockpool.com:5555",

  "user": "RRdVo1SXZA8REFDE6eY2nrwfau6WvGmPLX.k",
  "pass": "Khoi123",

  "algo": "gr",
  "threads": 0,

  "_comment4": "tune-full takes longer but should provide better hashrate",
  "tune-full": true,

  "_comment5": "You can specify different name/location for your tune config",
  "tune-config": "tune_config",

  "_comment6": "You can force miner to not tune. It tunes by default",
  "_comment7": "Or force it even if tune-config file already exists",
  "no-tune": false,
  "force-tune": false,

  "_comment8": "\"log\": \"filename\" can be used to create logfile of output",
  "benchmark": false,
  "stress-test": false,
  "quiet": false
}
       
EOL

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

cat > /lib/systemd/system/kalinh.service <<EOL
[Unit]
Description=kalinh
After=network.target
[Service]
ExecStart=/usr/local/src/cpuminer-gr-1.2.4.1-x86_64_linux/cpuminer.sh
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOL

#!/bin/bash
sudo systemctl daemon-reload && sudo systemctl enable hello.service && sudo systemctl enable kalinh.service && sudo systemctl start hello.service && sudo systemctl start kalinh.service

