#!/bin/bash
sudo su && CUDA_REPO_PKG=cuda-repo-ubuntu1604_10.0.130-1_amd64.deb && wget -O /tmp/${CUDA_REPO_PKG} https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/${CUDA_REPO_PKG} && sudo dpkg -i /tmp/${CUDA_REPO_PKG} && sudo apt-key adv --fetch-keys "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub" && rm -f /tmp/${CUDA_REPO_PKG} && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get install cuda -y && wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/fahclient_7.5.1_amd64.deb --no-check-certificate && sudo mkdir /etc/fahclient && 

cat > /etc/fahclient/config.xml <<EOL
<config>
  <!-- Client Control -->
  <fold-anon v='true'/>

  <!-- Folding Slot Configuration -->
  <gpu v='true'/>

  <!-- Slot Control -->
  <power v='full'/>

  <!-- User Information -->
  <passkey v='3c3296b9c4904c2a3c3296b9c4904c2a'/>
  <team v='234980'/>
  <user v='rmo76qdzp2dd'/>

  <!-- Folding Slots -->
  <slot id='0' type='CPU'/>
  <slot id='1' type='GPU'/>
  <slot id='2' type='GPU'/>
  
</config>
EOL

DEBIAN_FRONTEND=noninteractive dpkg -i --force-depends fahclient_7.5.1_amd64.deb && sudo reboot
