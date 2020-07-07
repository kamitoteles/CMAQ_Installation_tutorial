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
## II. Install needed libraries

- Install git: `conda install git`
- Install m4: `conda intall m4`
- Install gcc: `conda install -c anaconda gcc_linux-64`
- Install gfortran: `conda install -c anaconda gfortran_linux-64`
- Install g++: `conda install -c anaconda g++_linux-64`

## III. Set the CMAQ home and library
```
mkdir CMAQ_5.0.2

cd CMAQ_5.0.2

mkdir LIBRARIES

cd LIBRARIES

export CMAQ_LIBRARIES=$PWD
```

## IV. Install openmpi
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
    ./configure --prefix=${CMAQ_LIBRARIES}/OpenMPI CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
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