#! /bin/sh
sudo apt-get update
sudo apt-get install -y libmysqlclient-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsmpeg-dev libsdl1.2-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev zlib1g-dev
sudo add-apt-repository ppa:mc3man/bionic-media
sudo apt-get update
sudo apt-get install ffmpeg
sudo apt install libvips-tools
sudo apt-get install -y libgstreamer1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good
sudo add-apt-repository ppa:kivy-team/kivy
sudo apt-get install python3-kivy
sudo apt-get install build-essential