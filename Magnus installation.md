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
    export CPPFLAGS='-DNDEBUG –DgFortran'

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
    mkdir ${CMAQ_LIBRARIES}/netcdf-c4.7.2-openmpi4.0.2-gcc7.3.0
    ```
4. Set the configuration script. 'prefix' is the directory where the installation will be made. It is necessay to disable 'netCDF 4' and 'DAP' for a correct installation.
    ```
    ./configure --prefix=${CMAQ_LIBRARIES}/netcdf-c4.7.2-openmpi4.0.2-gcc7.3.0 --disable-netcdf-4 --disable-dap
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