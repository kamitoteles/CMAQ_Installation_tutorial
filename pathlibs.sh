export PATH=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/bin/intel64:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/bin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/mpi/intel64/libfabric/bin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/mpi/intel64/bin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/debugger_2020/gdb/intel64/bin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/bin:/hpcfs/apps/anaconda/3.7/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/ganglia/bin:/opt/ganglia/sbin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/hpcfs/home/ca.moreno12/.local/bin:/hpcfs/home/ca.moreno12/bin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/openmpi-1.8.1/install/bin

export LD_LIBRARY_PATH=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-c-4.7.2-openmpi-1.8.1-intel/lib:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/compiler/lib/intel64_lin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/mpi/intel64/libfabric/lib:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/ipp/lib/intel64:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/mkl/lib/intel64_lin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/tbb/lib/intel64/gcc4.8:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/debugger_2020/python/intel64/lib:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/debugger_2020/libipt/intel64/lib:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries_2020.2.254/linux/daal/lib/intel64_lin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-c-4.7.2-openmpi-1.8.1-intel/lib:/opt/openmpi/lib:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/openmpi-1.8.1/install/lib

export CC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/icc 
export FC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/ifort 
export F77=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/ifort 
export CXX=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/icpc


#OPENMPI 1.8.1
./configure --prefix=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/openmpi-1.8.1/install CC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/icc FC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/ifort CXX=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/intel/compilers_and_libraries/linux/bin/intel64/icpc

#NEtCDF 4.7.2
./configure --prefix=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-c-4.7.2-openmpi-1.8.1-intel --disable-netcdf-4 --disable-dap

# NetCDF fortran 4.5.2
export NCDIR=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-c-4.7.2-openmpi-1.8.1-intel
export NFDIR=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-fortran-4.5.2-openmpi-1.8.1-intel
export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
export CPPFLAGS=-I${NCDIR}/include
export LDFLAGS=-L${NCDIR}/lib



# IOAPI 3.2
BIN = Linux2_x86_64ifort_openmpi-1.8.1_intel
INSTALL = /hpcfs/home/ca.moreno12/.conda/envs/cmaq_env
NCFLIBS = -lnetcdff -lnetcdf

ln -s /hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-c-4.7.2-openmpi-1.8.1-intel/lib/libnetcdf.a
ln -s /hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/netcdf-fortran-4.5.2-openmpi-1.8.1-intel/lib/libnetcdff.a

#Pario y Stenex
export M3HOME=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO
export M3LIB=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/lib
export M3DATA=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/data
export M3MODEL=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/models
export WORK=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/scripts

