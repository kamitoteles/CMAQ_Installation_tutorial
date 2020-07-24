# !/bin/bash
# Seteo de librerias requeridas para la instalacion de CMAQ 5.02
# con compilador GNU
# Autor: Camilo Moreno

# Directorio de intalacion de cmaq y librerias 
export CMAQ_INST=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/CMAQ_5.0.2
export CMAQ_LIBRARIES=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/CMAQ_5.0.2/LIBRARIES

# Compiladores
export CC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin/x86_64-conda_cos6-linux-gnu-gcc
export FC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin/x86_64-conda_cos6-linux-gnu-gfortran
export CXX=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin/x86_64-conda_cos6-linux-gnu-g++

# Librerias de sistema 
export LD_LIBRARY_PATH=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/CMAQ_5.0.2/LIBRARIES/netcdf-c-4.7.2-openmpi4.0.2-gcc7.3.0/lib:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/CMAQ_5.0.2/LIBRARIES/OpenMPI/lib
export PATH=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin:/hpcfs/apps/anaconda/3.7/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/ganglia/bin:/opt/ganglia/sbin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/hpcfs/home/ca.moreno12/.local/bin:/hpcfs/home/ca.moreno12/bin:/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/CMAQ_5.0.2/LIBRARIES/OpenMPI/bin

# Librerias instaladas
export PATH=$PATH:${CMAQ_LIBRARIES}/OpenMPI/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CMAQ_LIBRARIES}/OpenMPI/lib
export NCDIR=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-gcc7.3.0
export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-gcc7.3.0
export CPPFLAGS=-I${NCDIR}/include
export LDFLAGS=-L${NCDIR}/lib
export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-gcc7.3.0
export LD_LIBRARY_PATH=${NFDIR}/lib:${LD_LIBRARY_PATH}
