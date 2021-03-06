# install essential libraries
export CODE_DIR=~/code              #
#sudo apt-get install build-essential
#sudo apt-get install libjpeg-dev
#sudo apt-get install libtiff5-dev
echo "Do you want to install all packages regardless of size? [y/n] "
read dec
echo "Which branch of HotSpotter do you want? Just press [ENTER] for recommended (oldnewjoshmatt)"
read hsb
echo "Which branch of hesaff do you want? Just press [ENTER] for recommended branch (next):"
read hesaffb

# If user doesn't want to think about it anymore
if [[ "$dec" == "y" ]]
then
    #sudo apt-get install -y pkg-config
    sudo apt-get install -y libfreetype6-dev
    sudo apt-get install -y python2.7      #
    sudo apt-get install -y git 		    #
    #sudo apt-get install -y libqt4-dev
    #sudo apt-get install -y cmake
    sudo apt-get install -y python-qt4     #
    sudo apt-get install -y python-pip		#
    sudo apt-get install -y python-matplotlib
else
    #sudo apt-get install pkg-config
    sudo apt-get install libfreetype6-dev
    sudo apt-get install python2.7      #
    sudo apt-get install git 		    #
    #sudo apt-get install libqt4-dev
    #sudo apt-get install cmake
    sudo apt-get install python-qt4     #
    sudo apt-get install python-pip		#
    sudo apt-get install python matplotlib
fi


### Python libraries ###

# Now we'll pip
# core libraries
sudo pip install Pygments
sudo pip install argparse 
sudo pip install openpyxl
sudo pip install parse
sudo pip install pyreadline
sudo pip install python-dateutil
sudo pip install six

#speed libraries
sudo pip install Cython             #
sudo pip install pylru              #

# Essential Libraries
sudo pip install cmake              #

# interactive libs
#sudo pip install ipython
#sudo pip uninstall matplotlib         #
#sudo pip install matplotlib==1.3.1
#sudo pip install python-qt

# sci libs
sudo pip install pillow             #
sudo pip install numpy              #
#sudo pip install opencv-python
sudo pip install pandas             #
sudo pip install scipy              #
sudo pip install pyflann            #

# dev tools
#sudo pip install setuptools
#sudo pip install pyinstaller
#sudo pip install flake8
#sudo pip install pep8
#sudo pip install pyflakes
#sudo pip install pylint
sudo pip install utool              #
sudo pip install networkx           #

## On to the project ##
## Start with repos  ##
# several of these scripts expect to see stuff in ~/code, so we'll do that
mkdir ~/code
cd ~/code

# FLANN - Fast Library for Approximate Nearest Neighbors
git clone https://github.com/SU-ECE-18-7/flann.git                      #

# Hessian Affine Keypoint Detector
# git clone -b BRANCH https://github.com/SU-ECE-18-7/hesaff.git
if [ -n "$hesaffb" ]
then
    git clone -b "$hesaffb" https://github.com/SU-ECE-18-7/hesaff.git                     #
else
    git clone -b next https://github.com/SU-ECE-18-7/hesaff.git                     #
fi

# opencv
git clone -b hotsbranch248 https://github.com/SU-ECE-18-7/opencv.git    #

# Main HotSpotter repo
if [ -n "$hsb" ]
then
    git clone -b "$hsb" https://github.com/SU-ECE-18-7/hotspotter.git
else
    git clone -b oldnewjoshmatt https://github.com/SU-ECE-18-7/hotspotter.git
fi

## Let's build stuff ##

# Build opencv (this takes a looooong time)
cd ~/code/opencv
./unix_configure.sh
./unix_build.sh

# Build hesaff
cd ~/code/hesaff
./unix_build.sh
# Some branches have a different name. If it errors, try this:
#~/code/hesaff/unix_hesaff_build.sh

# Setup HotSpotter
cd ~/code/hotspotter
python setup.py cython

# Move it to the right place
cp ~/code/hesaff/build/libhesaff.so ~/code/hotspotter/hstpl/extern_feat/libhesaff.so

# I guess we need to rename this for some reason?
#mv ~/
# build flann... yum
cd ~/code/flann
./unix_build.sh

# Go back to the parent dir
cd ~/code
zenity --info --text='All done setting up.\n Feel free to run HotSpotter now.'

