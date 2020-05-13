# CMAQ installation guide
Purpose: This guide describes how to install and run the CMAQ test case. All the information in this guide is based on the original CMAQ 5.3.1 [Users Guide Installation and Benchmarking tutorial][1] and the information found in different community forums.

This set of instructions were tested on a Linux system with the following specifications: 
* Ubuntu 18.04.4 LTS
* intel ICC compiler version 19.1
* OpenMPI version 4.2
* I/O API version 3.2
* Debug mode turned off

**IMPORTANT:** It is recommended to run all the steps of this installation having root or sudo privileges, as some folders and files need special permissions to be created or manipulated.

----
## I. Needed libraries
These libraries will be needed to assure some functionalities of the code. If you had already installed them in your system omit this part.

- Update apt-get: 
    ```
    apt-get -y update
    ```
- Install git: 
    ```
    apt-get -y install git
    ```
- Install m4: 
    ```
    apt-get -y m4
    ```
- Install csh: 
    ```
    apt install csh
    ```
- Install gcc: 
    ```
    apt-get -y install build-essential
    ```
- Install gfortran: 
    ```
    apt-get -y install gfortran
    ```
---
## II. Set intel compliers
1. Download the Intel® Parallel Studio XE package and use the 'install. sh' or 'install_gui.sh' script depending on your installation preferences.
    ```
    sh install_gui.sh
    ```
2. Set the environment varibles for the C and fortran compilers. The locations bellow are the standards for the Linux GUI setup of the 2020.0.166 Intel® Parallel Studio XE version and may vary between installations:
    ```
    source /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh -arch intel64 -platform linux
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    ```
    This last step will be repeated on each library instruction set. If you following all the installations in one run, you wont need to reset the variables.

---
## III. Make Base Directory
In order to make a more organized installation, its recommended to create a base directory where all the libraries and repositores will be downloaded and installed. This step is completelly optional.

1. Make the home directory for all the installation in the desired location:
    ```
    mkdir CMAQ-5.3.1
    ```
2. Enter into the home directory and create the folder that will contain all the libraries:
    ```
    cd CMAQ-5.3.1
    mkdir LIBRARIES
    ```
3. Enter into LIBRARIES and make it your base directory with the $BASEDIR variable. Replace **[initial_dir]** with the location where the home directory is located:
    ```
    cd LIBRARIES
    export BASEDIR=/[initial_dir]/CMAQ-5.3.1/LIBRARIES
    ```
---
## IV. Install OpenMPI
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
4. Export BASEDIR to the $PATH:
    ```
    export PATH=$PATH:${BASEDIR}/OpenMPI
    ```
5. Set the environment varibles for the C and fortran compilers. The locations bellow are standards for the Linux GUI setup for the 2020.0.166 Intel® Parallel Studio XE version:
    ```
    source /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh -arch intel64 -platform linux
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    ```
6. Set the configuration script. 'prefix' is the directory where the installation will be made. 'CC' is the location of the intel C compiler, 'FC' is the location of the intel fortran compiler and 'CXX' is the location of the C++ intel compiler.
    ```
    ./configure --prefix=${BASEDIR}/OpenMPI CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    ```
7. Install OpenMPI:
    ```
    make all install
    ```
8. Return to the LIBRARIES directory
    ```
    cd ..
    ```
---
## V. Instal netCDF-C
1. Download and untar the netcdf-c-4.7.2 folder. The link must vary if you decide to use another version of netCDF-C:
    ```
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.0.tar.gz
    tar -xzvf netcdf-c-4.7.0.tar.gz
    ```
2. Enter the main folder:
    ```
    cd netcdf-c-4.7.0
    ```
3. Make the netCDF-C instalation directory:
    ```
    mkdir ${BASEDIR}/netcdf-c-4.0.2-intel19.1
    ```
4. Set the environment varibles for the C and fortran compilers. The locations bellow are standards for the Linux GUI setup for the 2020.0.166 Intel® Parallel Studio XE version:
    ```
    source /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh -arch intel64 -platform linux
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    ```
5. Set the configuration script. 'prefix' is the directory where the installation will be made. It is necessay to disable 'netCDF 4' and 'DAP' for a correct installation.
    ```
    ./configure --prefix=${BASEDIR}/netcdf-c-4.7.2-intel19.1 --disable-netcdf-4 --disable-dap
    ```
6. Make the installation and check that the configuration script worked correctly:
    ```
    make check install |& tee make.install.log.txt 
    ```
    - Verify that this message appears when the installation is finished:
        ```
        "| Congratulations! You have successfully installed netCDF! |"
        ```
8. Return to the LIBRARIES directory
    ```
    cd ..
    ```
---
## VI. Install netCDF-Fortran
1. Download and untar the netcdf-fortran-4.5.2 folder. The link must vary if you decide to use another version of netCDF-Fortran:
    ```
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.5.tar.gz 
    tar -xzvf netcdf-fortran-4.4.5.tar.gz
    ```
2. Enter the main folder:
    ```
    cd netcdf-fortran-4.4.5
    ```
3. Make the netCDF-C instalation directory:
    ```
    mkdir ${BASEDIR}/netcdf-fortran-4.4.5-intel19.1
    ```
4. Set the environment varibles for the C and fortran compilers. The locations bellow are standards for the Linux GUI setup for the 2020.0.166 Intel® Parallel Studio XE version:
    ```
    source /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh -arch intel64 -platform linux
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    ```
5. Set the netCDF-C directory, LD_LIBRARY_PATH, NFDIR, CPPFLAGS and LDFLAGS variables:
    ```
    export NCDIR=${BASEDIR}/netcdf-c-4.7.0-intel19.1
    export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
    export NFDIR=${BASEDIR}/netcdf-fortran-4.4.5-intel19.1
    export CPPFLAGS=-I${NCDIR}/include
    export LDFLAGS=-L${NCDIR}/lib
    ```
6. Set the configuration script:
    ```
    ./configure --prefix=${NFDIR}
    ```
7. Make the install and save de log file:
    ```
    make check |& tee make.check.log.txt
    ```
     - This will be the output if the make check command was succesfull:
        ```
        Testsuite summary for netCDF-Fortran 4.4.5
        ==========================================
        # TOTAL: 6
        # PASS: 6
        ```
8. Make the installation:
    ```
    make install |& tee ./make.install.log.txt
    ```
    - This will be the output when the make install command was successful:
    ```
    Libraries have been installed in:
    
    [BASEDIR]/netcdf-fortran-4.5.2-intel19.1

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
9. Set LD_LIBRARY_PATH variable to include the netcdf-Fortran library path for netCDF build. May need to add the NCDIR and NFDIR to .cshrc:
    ```
    export NFDIR=${BASEDIR}/netcdf-fortran-4.4.5-intel19.1
    export LD_LIBRARY_PATH=${NFDIR}/lib:${LD_LIBRARY_PATH}
    ```
10. Return to the LIBRARIES directory
    ```
    cd ..
    ```
---
## VII.Install I/O API
1. Download I/O API version 3.2 repository:
    ```
    git clone https://github.com/cjcoats/ioapi-3.2
    ```
2. Enter to the downloaded folder:
    ```
    cd ioapi-3.2
    ```
3. Create the Makefile from template:
    ```
    cp Makefile.template Makefile
    ```
4. Edit the makefile BIN, BASEDIR and NCFLIBS variables:
    ```
    vi Makefile
    ```
    - Use this values. **[BASEDIR]** is the same location saved on $BASEDIR:
        ```
        BIN = Linux2_x86_64ifort_intel19.1
        BASEDIR = /[BASEDIR]
        NCFLIBS = -lnetcdff -lnetcdf
        ```
5. Enter the ioapi folder:
    ```
    cd ioapi
    ```
6. Create a personalized Makeinclude file from template:
    ```
    cp Makeinclude.Linux2_x86_64ifort Makeinclude.Linux2_x86_64ifort_intel19.1
    ```
7. Edit the Makeinclude file:
    ```
    vi Makeinclude.Linux2_x86_64ifort_intel19.1
    ```
    - Use this values: ###############################
        ```
        OMPFLAGS = -qopenmp
        OMPLIBS = -qopenmp

        ARCHFLAGS = \
        -DIOAPI_NCF4=1 \
        -DAUTO_ARRAYS=1 \
        -DF90=1 -DFLDMN=1 \
        -DFSTR_L=int \
        -DIOAPI_NO_STDOUT=1 \
        -DAVOID_FLUSH=1 -DBIT32=1
        ```
8. Create the Makefile from nocpl template:
    ```
    cp Makefile.nocpl Makefile
    ```
9. Edit Makefile:
    ```
    vi Makefile
    ```
 - **[BASEDIR]** is the same location saved on $BASEDIR:
    ```
    BASEDIR = /[BASEDIR] 
    ```
10. Enter the m3tools folder:
    ```
    cd ..
    cd m3tools
    ```
11. Create the Makefile from nocpl template:
    ```
    cp Makefile.nocpl Makefile
    ```
12. Edit Makefile:
    ```
    vi Makefile
    ```
    - **[BASEDIR]** is the same location saved on $BASEDIR:
        ```
        BASEDIR = /[BASEDIR]
        ```
13. Return to ioapi-3.2 folder:
    ```
    cd ..
    ```
14. Set the BIN variable as:
    ```
    export BIN=Linux2_x86_64ifort_intel19.1
    ```
15. Create the BIN directory. (This will be the location of the I/O API library)
    ```
    mkdir $BIN
    cd $BIN
    ```
16. Link the netCDF-C and netCDF-Fortran libraries archives:
    ```
    ln -s ${BASEDIR}/netcdf-c-4.7.0-intel19.1/lib/libnetcdf.a
    ln -s ${BASEDIR}/netcdf-fortran-4.4.5-intel19.1/lib/libnetcdff.a
    ```
18. Return to ioapi-3.2 folder:
    ``` 
    cd ..
    ```
14. Set the environment varibles for the C and fortran compilers. The locations bellow are standards for the Linux GUI setup for the 2020.0.166 Intel® Parallel Studio XE version:
    ```
    source /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh -arch intel64 -platform linux
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    ```
15. Make the insatll
    ```
    make all |& tee make.log 
    ```
---
## VIII. Install CMAQ and Benchamark
This intructions set is a summary of the [Users Guide Installation and Benchmarking tutorial][1] and unlike the library installation instructions it has no significant changes besides the directories names. It is recommended to follow the original intructions page for a more indepth explanation of each step.
1. Clone the CMAQ 5.3.1 repository:
    ```
    git clone -b master https://github.com/USEPA/CMAQ.git CMAQ_REPO
    ```
2. Enter the CMAQ_REPO folder and checkout the new branch:
    ```
    cd CMAQ_REPO
    git checkout -b my_branch
    ```
3. Set the environment varibles for the C and fortran compilers. The locations bellow are standards for the Linux GUI setup for the 2020.0.166 Intel® Parallel Studio XE version:
    ```
    source /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh -arch intel64 -platform linux
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    ```
4. Set CMAQ_HOME in bldit_project.csh as set CMAQ_HOME = /home/[username]/CMAQ-5.3.1 and run the scipt. This will create the directories needes for the intallation:
    ```
    ./bldit_project.csh
    ```
5. Go to the CMAQ_HOME directory and set the location of the libraries and include files on the config_cmaq.csh. The locations listed in here may vary between intallations and shoukd be rechecked on each sistem.
    ```
    cd ..
    vi config_cmaq.csh
    ```
    - Edit the locations in the intel compiler case of the file:
        ```
        #> Intel fortran compiler......................................................
        case intel:

        setenv IOAPI_INCL_DIR [BASEDIR]/ioapi-3.2/ioapi/fixed_src #> I/O API include header files
        setenv IOAPI_LIB_DIR [BASEDIR]/ioapi-3.2/Linux2_x86_64ifort_openmpi_4.0.2_intel19.1 #> I/O API libraries
        setenv NETCDF_LIB_DIR [BASEDIR]/netcdf-c-4.7.2-intel19.1/lib #> netCDF C directory path
        setenv NETCDF_INCL_DIR [BASEDIR]/netcdf-c-4.7.2-intel19.1/include #> netCDF C directory path
        setenv NETCDFF_LIB_DIR [BASEDIR]/netcdf-fortran-4.5.2-intel19.1/lib #> netCDF Fortran directory path
        setenv NETCDFF_INCL_DIR [BASEDIR]/netcdf-fortran-4.5.2-intel19.1/include #> netCDF Fortran directory path
        setenv MPI_LIB_DIR /opt/intel/compilers_and_libraries_2020.0.166/linux/mpi/intel64/lib #> MPI directory path

        setenv myLINK_FLAG "-qopenmp"
        ...
        setenv netcdf_lib"-lnetcdf -lnetcdff" #> -lnetcdff -lnetcdf for netCDF v4.2.0 and later
        ```
6. Run the config_cmaq.csh script whit the compiler optin 'intel'.
    ```
    ./config_cmaq.csh intel
    ```
7. Download the 2 day Benchmark data Input and Output folders found [here][2] and untar them on the ${CMAQ_HOME}/data directory.
8. Enter the CCTM scrips folder:
    ```
    cd CCTM/scripts
    ```
9. Edit the bldit_cctm.csh file in order to set the following conditios:
    ```
    vi bldit_cctm.csh
    ```
    - Conditios for runing the Benchmark:
        - Multiprocessor simulation: set ParOpt #>  Option for MPI Runs **UNCOMENTED**
        - Deposition: M3Dry
        - 3-D Advection Scheme: wrf_cons
        - Horizontal diffusion: Multiscale
        - Vertical diffusion: ACM2_M3Dry
        - Online biogenic emissions
        - Inline plume rise
        - Mechanism: cb6r3_ae7_aq
        - Chemistry solver: EBI
        - Aerosol module: AERO7
        - Cloud module: ACM_AE7
10. Build the CCTM script and create the executable:
```
./bldit_cctm.csh intel |& tee bldit.cctm.log
```

[1]: https://github.com/USEPA/CMAQ/blob/master/DOCS/Users_Guide/Tutorials/CMAQ_UG_tutorial_benchmark.md
[2]: https://drive.google.com/drive/folders/10wFNch1MkI49ZjD2XD6wK2xzDWOav2zY
