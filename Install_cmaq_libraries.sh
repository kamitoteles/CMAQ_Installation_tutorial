#!/bin/bash

# Ask the user for the hame directory of the installation and the compiler locations
c=10
while [ $c -le 1 ]
do
echo Enter the home directory path of the installation: 
read HOME_D
echo Enter the CC compiler location: 
read CC
echo Enter the FC compiler location: 
read FC
echo Enter the C++ compiler locations: 
read CXX

export HOME_D=${HOME_D}
export CC=${CC}
export FC=${FC}
export CXX=${CXX}
export F77=${FC}

echo The home directory was set to: $HOME_D
echo The CC location is set to: $CC
echo The FC location is set to: $FC
echo The C++ location is set to: $CXX
echo The F77 location is set to: $F77

read -p 'Are those the correct locations? ' correct

if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please reenter the correct paths
    echo
else
    c=0
fi
done

# Set the home CMAQ directory
#cd ${HOME_D}
#mkdir CMAQ-5.3.1
#cd CMAQ-5.3.1
#mkdir LIBRARIES
#export CMAQ_HOME=${PWD}
#export CMAQ_LIBRARIES=${CMAQ_HOME}/LIBRARIES
#cd ${CMAQ_LIBRARIES}

# Install system libraries
#apt-get -y update
#apt-get -y install git
#apt-get -y m4
#apt install csh
#apt-get -y install build-essential
#apt-get -y install gfortran

# Install OpenMPI

