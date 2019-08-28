#!/bin/bash

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update
apt-get -y install openjdk-8-jdk
apt-get update
apt-get install -y apt-transport-https
apt-get install -y ruby ruby-ffi ruby-dev build-essential ruby-bundler zlib1g-dev firefox libgconf-2-4 xvfb
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs) && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list
curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
apt-get update && apt-get install -y azure-cli
apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-keys 023EDB0B
echo deb https://dl.bintray.com/gauge/gauge-deb nightly main | tee -a /etc/apt/sources.list
apt-get update && apt-get install -y gauge
apt-get install -y docker.io
wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz
sh -c 'tar -x geckodriver -zf geckodriver-v0.24.0-linux64.tar.gz -O > /usr/bin/geckodriver'
chmod +x /usr/bin/geckodriver
rm geckodriver-v0.24.0-linux64.tar.gz

