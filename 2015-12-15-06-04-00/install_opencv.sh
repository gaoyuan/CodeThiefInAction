sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libgtk2.0-dev
sudo apt-get install libatlas-base-dev gfortran

cd ~/Documents
mkdir opencv
cd opencv
git clone https://github.com/Itseez/opencv.git
git clone https://github.com/Itseez/opencv_contrib.git

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D BUILD_SHARED_LIBS=ON \
-D OPENCV_EXTRA_MODULES_PATH=~/Documents/opencv/opencv_contrib/modules \
-D BUILD_PERF_TESTS=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_DOCS=OFF ..

make -j4
sudo make install
sudo ldconfig