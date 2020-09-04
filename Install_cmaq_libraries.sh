#!/bin/bash

# Ask the user for the name directory of the installation and the compiler locations
c=0
while [ $c -le 1 ]
do
    echo Enter the directory wher the input and outut benchmark data is: 
    read Bench_data
    echo Enter the home directory path of the installation: 
    read HOME_D
    echo Enter the CC compiler location: 
    read CC
    echo Enter the FC compiler location: 
    read FC
    echo Enter the C++ compiler locations: 
    read CXX

    export BENCH_DATA=${Bench_data}
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
apt-get -y update; wait
apt-get -y install git; wait
apt-get -y m4; wait
apt install csh; wait
apt-get -y install build-essential; wait
apt-get -y install gfortran; wait

# Set the compiler libraries
echo Enter the compiler paths: 
read paths
echo Enter the compiler libs: 
read libs
export PATH=${paths}
export LD_LIBRARY_PATH=${libs}

# Install OpenMPI
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.2.tar.gz
tar -xzvf openmpi-4.0.2.tar.gz
rm openmpi-4.0.2.tar.gz
cd openmpi-4.0.2
./configure --prefix=${CMAQ_LIBRARIES}/OpenMPI CC=${CC} FC=${FC} CXX=${CXX}; wait
make all install; wait
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
./configure --prefix=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1 --disable-netcdf-4 --disable-dap; wait
make check install |& tee make.install.log.txt; wait
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
make check |& tee make.check.log.txt; wait
make install |& tee ./make.install.log.txt; wait
export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
export LD_LIBRARY_PATH=${NFDIR}/lib:${LD_LIBRARY_PATH}
cd ..

# Install I/O API
git clone https://github.com/cjcoats/ioapi-3.2
cd ioapi-3.2
cp Makefile.template Makefile
echo Edit the main Makefile; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi Makefile
wait
read -p 'Did you edited the Mekefile correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

cd ioapi
cp Makeinclude.Linux2_x86_64ifort Makeinclude.Linux2_x86_64ifort_openmpi4.0.2_intel19.1
echo Edit the ioapi folder Makeinclude; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi Makeinclude.Linux2_x86_64ifort_openmpi4.0.2_intel19.1
wait
read -p 'Did you edited the Mekeinclude correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makeinclude
    sleep 5
else
    c=2
fi
done

cp Makefile.nocpl Makefile
echo Edit the ioapi folder nocpl Makefile; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi Makefile
wait
read -p 'Did you edited the Mekefile correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

cd ..
cd m3tools
cp Makefile.nocpl Makefile
echo Edit the m3tools Makefile; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi Makefile
wait
read -p 'Did you edited the Mekefile correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

cd ..
export BIN=Linux2_x86_64ifort_openmpi4.0.2_intel19.1
mkdir $BIN
cd $BIN
ln -s ${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1/lib/libnetcdf.a
ln -s ${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1/lib/libnetcdff.a
cd ..
make all |& tee make.log
wait
cp ${BIN}/*.mod ${CMAQ_LIBRARIES}/ioapi-3.2/ioapi/fixed_src; wait
cp ioapi/*.h ${CMAQ_LIBRARIES}/ioapi-3.2/ioapi/fixed_src; wait
cd ..
cd ..

# Install CMAQ-5.3.1
git clone -b master https://github.com/USEPA/CMAQ.git CMAQ_REPO
cd CMAQ_REPO
git checkout -b my_branch

echo Edit the build_oroject.csh; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi bldit_project.csh
wait
read -p 'Did you edited the build_oroject.csh file correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

./bldit_project.csh
wait
cd ..

echo Edit the config_cmaq.csh; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi config_cmaq.csh
wait
read -p 'Did you edited the config_cmaq.csh file correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

./config_cmaq.csh intel; wait

cp {$BENCH_DATA}/CMAQv5.3.1_Benchmark_2Day_Input_20191219.tar.gz ${CMAQ_HOME}/data; wait
cp {$BENCH_DATA}/CMAQv5.3.1_Benchmark_2Day_Output.tar.gz ${CMAQ_HOME}/data; wait
cd data
tar xvzf CMAQv5.3.1_Benchmark_2Day_Input_20191219.tar.gz; wait
tar xvzf CMAQv5.3.1_Benchmark_2Day_Output.tar.gz; wait
cd ..
cd CCTM/scripts

echo Edit the bldit_cctm.csh; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi bldit_cctm.csh
wait
read -p 'Did you edited the bldit_cctm.csh file correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

./bldit_cctm.csh intel |& tee bldit.cctm.log; wait

echo Edit the run_cctm_Bench_2016_12SE1.csh; echo .; sleep 2; echo .; sleep 2; echo .; sleep 2
c=0
while [ $c -le 1 ]
do
vi run_cctm_Bench_2016_12SE1.csh
wait
read -p 'Did you edited the run_cctm_Bench_2016_12SE1.csh file correctly? ' correct
if [ $correct != 'Y' ] && [ $correct != 'y' ] && [ $correct != 'YES' ] && [ $correct != 'yes' ] && [ $correct != 'Yes' ]
then
    echo Please edit the Makefile
    sleep 5
else
    c=2
fi
done

./run_cctm_Bench_2016_12SE1.csh |& tee cctm.log