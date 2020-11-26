#! /bin/sh
tar -xzvf cudnn-10.0-linux-x64-v7.6.5.32.tgz
sudo cp -P cuda/include/cudnn.h /usr/local/cuda-10.0/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-10.0/lib64/
sudo chmod a+r /usr/local/cuda-10.0/lib64/libcudnn*
sudo apt-get install build-essential checkinstall cmake pkg-config yasm
sudo apt-get install libtiff5-dev libjpeg-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libv4l-dev
sudo apt-get install libtbb-dev
sudo apt-get install libqt4-dev libgtk2.0-dev
cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.2.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.2.0.zip
unzip opencv.zip
unzip opencv_contrib.zip
cd opencv-4.2.0
mkdir build
cd build
cmake -DWITH_XINE=ON -D WITH_OPENGL=ON -D WITH_TBB=ON -DBUILD_EXAMPLES=ON -DBUILD_opencv_world=ON -DBUILD_opencv_gapi=OFF -DWITH_NVCUVID=OFF -DWITH_CUDA=ON -DCUDA_FAST_MATH=ON -DWITH_CUBLAS=ON -DWITH_MKL=ON -DMKL_USE_MULTITHREAD=ON -DMKL_WITH_TBB=ON -DWITH_CUFFT=ON -DCUDA_ARCH_BIN=6.1 -DOPENCV_EXTRA_MODULES_PATH="/home/aindra/opencv_contrib-4.2.0/modules/" ..
make -j7
sudo make install
sudo apt-get install libboost-all-dev
sudo usermod -a -G dialout $USER
sudo apt-get install git
cd ~
git clone https://github.com/gabime/spdlog.git
cd spdlog && mkdir build && cd build
cmake .. && make -j
sudo make install


