#!/bin/bash
mkdir -p layer/bin
cd layer/bin
curl -L https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip --output chromedriver.zip
curl -L https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-45/stable-headless-chromium-amazonlinux-2017-03.zip --output chromeheadless.zip
unzip chromedriver.zip
unzip chromeheadless.zip
rm chromedriver.zip
rm chromeheadless.zip
chmod +x chromedriver
chmod +x headless-chromium
