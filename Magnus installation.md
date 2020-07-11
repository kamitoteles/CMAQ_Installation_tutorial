# Magnus installation
## I. Set conda environment

Create conda enviroment whith the CMAQ installation version
```
module load anaconda/python3.7
conda create --name cmaq_5.0.2_env
```
Enter the environment
```
conda activate cmaq_5.0.2_env
```
Cd to the conda enviroment folder that was created
```
cd [conda_prefix]
```
---
## II. Install needed libraries

- Install git: `conda install git`
- Install m4: `conda intall m4`
- Install gcc: `conda install -c anaconda gcc_linux-64`
- Install gfortran: `conda install -c anaconda gfortran_linux-64`
- Install g++: `conda install -c anaconda g++_linux-64`
---
## III. Set the CMAQ home and library
```
mkdir CMAQ_5.0.2

cd CMAQ_5.0.2

mkdir LIBRARIES

cd LIBRARIES

export CMAQ_LIBRARIES=$PWD
```
---
## IV. Install openmpi
1. Set the enviroment varibles:
    ```
    export CFLAGS=-O

    export FFLAGS='-O –w'
    ```
1. Make the OpenMPI directory:
    ```
    mkdir OpenMPI
    cd OpenMPI
    ```
2. Download OpenMPI 4.0.2 and untar the packages:
    ```
    wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.2.tar.gz
    gunzip -c openmpi-4.0.2.tar.gz | tar xf -
    ```
3. Enter the main folder:
    ```
    cd openmpi-4.0.2
    ```
6. Set the configuration script.
    ```
    ./configure --prefix=${CMAQ_LIBRARIES}/OpenMPI CC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin/x86_64-conda_cos6-linux-gnu-gcc FC=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin/x86_64-conda_cos6-linux-gnu-gfortran CXX=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_5.0.2_env/bin/x86_64-conda_cos6-linux-gnu-g++
    ```
7. Install OpenMPI:
    ```
    make all install
    ```
4. Export Openmpi libraries and executables to the $PATH:
    ```
    export PATH=$PATH:${CMAQ_LIBRARIES}/OpenMPI/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CMAQ_LIBRARIES}/OpenMPI/lib
    ```
---
## V. Instal netCDF-C
1. Download and untar the netcdf-c-4.7.2 folder. The link must vary if you decide to use another version of netCDF-C:
    ```
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.2.tar.gz
    tar -xzvf netcdf-c-4.7.2.tar.gz
    ```
2. Enter the main folder:
    ```
    cd netcdf-c-4.7.2
    ```
3. Make the netCDF-C instalation directory:
    ```
    mkdir ${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-gcc7.3.0
    ```
4. Set the configuration script. 'prefix' is the directory where the installation will be made. It is necessay to disable 'netCDF 4' and 'DAP' for a correct installation.
    ```
    ./configure --prefix=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-gcc7.3.0 --disable-netcdf-4 --disable-dap
    ```
5. Make the installation and check that the configuration script worked correctly:
    ```
    make check install |& tee make.install.log.txt 
    ```
    - Verify that this message appears when the installation is finished:
        ```
        "| Congratulations! You have successfully installed netCDF! |"
        ```
6. Return to the LIBRARIES directory
    ```
    cd ..
    ```
---
## VI. Install netCDF-Fortran
1. Download and untar the netcdf-fortran-4.5.2 folder. The link must vary if you decide to use another version of netCDF-Fortran:
    ```
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.5.2.tar.gz 
    tar -xzvf netcdf-fortran-4.5.2.tar.gz
    ```
2. Enter the main folder:
    ```
    cd netcdf-fortran-4.5.2
    ```
3. Make the netCDF-C instalation directory:
    ```
    mkdir ${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-gcc7.3.0
    ```
4. Set the netCDF-C directory, LD_LIBRARY_PATH, NFDIR, CPPFLAGS and LDFLAGS variables:
    ```
    export NCDIR=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-gcc7.3.0
    export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
    export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-gcc7.3.0
    export CPPFLAGS=-I${NCDIR}/include
    export LDFLAGS=-L${NCDIR}/lib
    ```
5. Set the configuration script:
    ```
    ./configure --prefix=${NFDIR}
    ```
6. Make the install and save de log file:
    ```
    make check |& tee make.check.log.txt
    ```
     - This will be the output if the make check command was succesfull:
        ```
        Testsuite summary for netCDF-Fortran 4.4.5
        ==========================================
        # TOTAL: 1
        # PASS: 1
        ```
7. Make the installation:
    ```
    make install |& tee ./make.install.log.txt
    ```
    - This will be the output when the make install command was successful:
    ```
    Libraries have been installed in:
    
    [CMAQ_LIBRARIES]/netcdf-fortran-4.5.2-intel19.1

    If you ever happen to want to link against installed libraries
    in a given directory, LIBDIR, you must either use libtool, and
    specify the full pathname of the library, or use the '-LLIBDIR'
    flag during linking and do at least one of the following:
    - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
    during execution
    - add LIBDIR to the 'LD_RUN_PATH' environment variable
    during linking
    - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
    - have your system administrator add LIBDIR to '/etc/ld.so.conf'
    ```
8. Set LD_LIBRARY_PATH variable to include the netcdf-Fortran library path for netCDF build. May need to add the NCDIR and NFDIR to .cshrc:
    ```
    export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
    export LD_LIBRARY_PATH=${NFDIR}/lib:${LD_LIBRARY_PATH}
    ```
9. Return to the LIBRARIES directory
    ```
    cd ..
    ```
---