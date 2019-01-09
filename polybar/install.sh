#!/bin/bash

Polybar dependencies
apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev\
    libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen\
    xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev\
    libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2;
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
make install
cd ../../

#Fonts install
fontPath="usr/share/fonts/TTF"
if [ ! -d /$fontPath ];then
  mkdir /$fontPath
fi
cp $fontPath/* /$fontPath/
