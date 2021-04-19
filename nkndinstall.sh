clear
echo "============================================================================================="
echo "                              WELCOME TO NKNAgent FAST DEPLOY!"
echo "============================================================================================="
echo
echo "This script will automatically provision a node as you configured it in your snippet."
echo "So grab a coffee, lean back or do something else - installation will take about 5 minutes."
echo -e "============================================================================================="
echo
echo "Hardening your OS..."
echo "---------------------------"
export DEBIAN_FRONTEND=noninteractive
apt-get -qq update
apt-get -qq upgrade -y
echo "Installing necessary libraries..."
echo "---------------------------"
apt-get install make curl git unzip whois makepasswd -y --allow-downgrades --allow-remove-essential --allow-change-held-packages
apt-get install unzip jq -y --allow-downgrades --allow-remove-essential --allow-change-held-packages
#curl --insecure --data "secret=7482da1b67fd4d21ffb6c3ca847e99a91c269181" https://api.nknag.org/fast-deploy/callbacks/created
sudo groupadd nknag
sudo useradd -g nknag -b /home -s /usr/sbin/nologin nknag
mkdir -p /home/nknag/.ssh
mkdir -p /home/nknag/.nknag
adduser nknag sudo
chsh -s /bin/bash nknag
PASSWORD=$(mkpasswd zktcqx0L)
usermod --password $PASSWORD nknag > /dev/null 2>&1
cd /home/nknag
echo "Installing NKN Commercial..."
echo "---------------------------"
wget --quiet --continue --show-progress https://commercial.nkn.org/downloads/nkn-commercial/linux-amd64.zip > /dev/null 2>&1
unzip -qq linux-amd64.zip
cd linux-amd64
cat >config.json <<EOF
{
    "nkn-node": {
       "args": "--no-nat",
       "noRemotePortCheck": true
    }
}
EOF
#./nkn-commercial -b nknagXXXXGKct2cZuhSGW6xqiqeFVd5nJtAzg -c /home/nknag/linux-amd64/config.json -d /home/nknag/nkn-commercial -u nknag install > /dev/null 2>&1
./nkn-commercial -b NKNFrqAuM6mSv79sjCMBBn4o1d7Bh8TfGqSD -c /home/nknag/linux-amd64/config.json -d /home/nknag/nkn-commercial -u nknag install > /dev/null 2>&1
chown -R nknag:nknag /home/nknag
chmod -R 755 /home/nknag
echo "Waiting for wallet generation..."
echo "---------------------------"
while [ ! -f /home/nknag/nkn-commercial/services/nkn-node/wallet.json ]; do sleep 10; done
echo "Downloading pruned snapshot..."
echo "---------------------------"
#curl --insecure --data "secret=7482da1b67fd4d21ffb6c3ca847e99a91c269181" https://api.nknag.org/fast-deploy/callbacks/downloading-snapshot
cd /home/nknag/nkn-commercial/services/nkn-node/
systemctl stop nkn-commercial.service
rm -rf ChainDB
#wget -c https://nkn.org/ChainDB_pruned_latest.tar.gz -O - | tar -xz
#wget -c "https://onedrive.live.com/download?cid=B409482F4F7DA231&resid=B409482F4F7DA231%21106&authkey=AEvytR8r9nemPqw" -O - | tar -xz
sudo -u nknag curl -L -s "https://onedrive.live.com/download?cid=B409482F4F7DA231&resid=B409482F4F7DA231%21106&authkey=AEvytR8r9nemPqw" | sudo -u nknag tar -zxf -
#curl --insecure --data "secret=7482da1b67fd4d21ffb6c3ca847e99a91c269181" https://api.nknag.org/fast-deploy/callbacks/unzipping-snapshot
chown -R nknag:nknag ChainDB/
systemctl start nkn-commercial.service
echo "Applying finishing touches..."
echo "---------------------------"
addr=$(jq -r .Address /home/nknag/nkn-commercial/services/nkn-node/wallet.json)
cd /home/nknag/.nknag
cat >donationcheck <<EOF
cd /home/nknag/linux-amd64
#response=\$(curl --write-out %{http_code} --silent --output /dev/null "https://openapi.nkn.org/api/v1/addresses/ZZZYYY/hasMinedToAddress/nknagXXXXGKct2cZuhSGW6xqiqeFVd5nJtAzg")
response=\$(curl --write-out %{http_code} --silent --output /dev/null "https://openapi.nkn.org/api/v1/addresses/ZZZYYY/hasMinedToAddress/NKNFrqAuM6mSv79sjCMBBn4o1d7Bh8TfGqSD")
if [ "\$response" -eq 202 ]
then
systemctl stop nkn-commercial.service
./nkn-commercial -b NKNFrqAuM6mSv79sjCMBBn4o1d7Bh8TfGqSD -c /home/nknag/linux-amd64/config.json -d /home/nknag/nkn-commercial -u nknag install
chown -R nknag:nknag /home/nknag
chmod -R 755 /home/nknag
cd /home/nknag/.nknag
crontab -l > tempcron
sed -i '$ d' tempcron
crontab tempcron > /dev/null 2>&1
rm tempcron > /dev/null 2>&1
#curl --insecure --data "secret=7482da1b67fd4d21ffb6c3ca847e99a91c269181" https://api.nknag.org/fast-deploy/callbacks/donated
rm /home/nknag/.nknag/donationcheck > /dev/null 2>&1
fi
EOF
sed -i "s/ZZZYYY/$addr/g" donationcheck
crontab -l > tempcron
echo "43 * * * * /home/nknag/.nknag/donationcheck >/dev/null 2>&1" >> tempcron
crontab tempcron
rm tempcron
chown -R nknag:nknag /home/nknag
chmod -R 755 /home/nknag
#curl --insecure --data "secret=7482da1b67fd4d21ffb6c3ca847e99a91c269181" https://api.nknag.org/fast-deploy/callbacks/finish-install
sleep 2
clear
echo
echo
echo
echo
echo "                                  --------------------------"
echo "                                  |  NKNAgent FAST-DEPLOY  |"
echo "                                  --------------------------"
echo
echo "============================================================================================="
echo "   NKN ADDRESS OF THIS NODE: $addr"
echo "   PASSWORD FOR THIS WALLET IS: zktcqx0L"
echo "============================================================================================="
echo "   ALL MINED NKN WILL GO TO: NKNFrqAuM6mSv79sjCMBBn4o1d7Bh8TfGqSD"
echo "   (FIRST MINING WILL BE DONATED TO NKNAgent-TEAM)"
echo "============================================================================================="
echo
echo "You can now disconnect from your terminal. The node will automatically appear in nknag after 1 minute."
echo
echo
echo
echo
