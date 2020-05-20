#!/bin/bash

# Ask the user for the hame directory of the installation and the compiler locations
c=0
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
    echo Please enter the correct paths
    echo
else
    c=2
fi
done

# Set the home CMAQ directory
cd ${HOME_D}
mkdir CMAQ-5.3.1
cd CMAQ-5.3.1
mkdir LIBRARIES
export CMAQ_HOME=${PWD}
export CMAQ_LIBRARIES=${CMAQ_HOME}/LIBRARIES
cd ${CMAQ_LIBRARIES}

# Install system libraries
apt-get -y update
apt-get -y install git
apt-get -y m4
apt install csh
apt-get -y install build-essential
apt-get -y install gfortran

# Set the compiler libraries
echo Enter the compiler paths: 
read paths
echo Enter the compiler libs: 
read libs
export PATH=${paths}
export LD_LIBRARY_PATH=${libs}

# Install OpenMPI
mkdir OpenMPI
cd OpenMPI
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.2.tar.gz
tar -xzvf openmpi-4.0.2.tar.gz
rm openmpi-4.0.2.tar.gz
cd openmpi-4.0.2
./configure --prefix=${CMAQ_LIBRARIES}/OpenMPI CC=${CC} FC=${FC} CXX=${CXX}
make all install
export PATH=$PATH:${CMAQ_LIBRARIES}/OpenMPI/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CMAQ_LIBRARIES}/OpenMPI/lib
cd ..
cd ..

# Install netCDF-C
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.2.tar.gz
tar -xzvf netcdf-c-4.7.2.tar.gz
rm netcdf-c-4.7.2.tar.gz
cd netcdf-c-4.7.2
mkdir ${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1
./configure --prefix=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1 --disable-netcdf-4 --disable-dap
make check install |& tee make.install.log.txt
cd ..

# Install netCDF-Fortran
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.5.2.tar.gz 
tar -xzvf netcdf-fortran-4.5.2.tar.gz
rm netcdf-fortran-4.5.2.tar.gz
cd netcdf-fortran-4.5.2
mkdir ${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
export NCDIR=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1
export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
export CPPFLAGS=-I${NCDIR}/include
export LDFLAGS=-L${NCDIR}/lib
./configure --prefix=${NFDIR}
make check |& tee make.check.log.txt
make install |& tee ./make.install.log.txt
export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
export LD_LIBRARY_PATH=${NFDIR}/lib:${LD_LIBRARY_PATH}
cd ..