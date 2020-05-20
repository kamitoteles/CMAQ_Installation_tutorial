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

- Update apt-get: `apt-get -y update`
- Install git: `apt-get -y install git`
- Install m4: `apt-get -y m4`
- Install csh: `apt install csh`
- Install gcc: `apt-get -y install build-essential`
- Install gfortran: `apt-get -y install gfortran`
---
## II. Make Base Directory
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
3. Enter into LIBRARIES and make it your base directory with the $CMAQ_LIBRARIES variable. Replace **[initial_dir]** with the location where the home directory is located:
    ```
    cd LIBRARIES
    export CMAQ_LIBRARIES=/[initial_dir]/CMAQ-5.3.1/LIBRARIES
    ```
---
## III. Set intel compliers
1. Download the Intel® Parallel Studio XE package and use the 'install. sh' or 'install_gui.sh' script depending on your installation preferences.
    ```
    sh install_gui.sh
    ```
    The predifined intallation location is: `/opt/intel/`. This will be important in order to set the libraries and bin locations for the compilers. If you use another intallation location, you must change the locations of the `PATH` and `LD_LIBRARY_PATH` variables.

2. Set the PATH and LD_LYBRARY_PATH to include no mpi libraries diferent from the OpenMPI:
    ```
    export LD_LIBRARY_PATH=/opt/intel/compilers_and_libraries_2020.0.166/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/ipp/lib/intel64:/opt/intel/compilers_and_libraries_2020.0.166/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/tbb/lib/intel64/gcc4.8:/opt/intel/compilers_and_libraries_2020.0.166/linux/tbb/lib/intel64/gcc4.8:/opt/intel/debugger_2020/python/intel64/lib:/opt/intel/debugger_2020/libipt/intel64/lib:/opt/intel/compilers_and_libraries_2020.0.166/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/daal/../tbb/lib/intel64_lin/gcc4.4:/opt/intel/compilers_and_libraries_2020.0.166/linux/daal/../tbb/lib/intel64_lin/gcc4.8

    export PATH=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64:/opt/intel/compilers_and_libraries_2020.0.166/linux/bin:/opt/intel/debugger_2020/gdb/intel64/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:
    ```
3. Set compilers variables: **Aparently not neccesary**
    ```
    export FC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
    export CC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
    export CXX=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icpc
    export F77=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
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
6. Set the configuration script. 'prefix' is the directory where the installation will be made. 'CC' is the location of the intel C compiler, 'FC' is the location of the intel fortran compiler and 'CXX' is the location of the C++ intel compiler.
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
8. Return to the LIBRARIES directory
    ```
    cd ..
    cd ..
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
    mkdir ${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1
    ```
4. Set the configuration script. 'prefix' is the directory where the installation will be made. It is necessay to disable 'netCDF 4' and 'DAP' for a correct installation.
    ```
    ./configure --prefix=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1 --disable-netcdf-4 --disable-dap
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
    mkdir ${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
    ```
4. Set the netCDF-C directory, LD_LIBRARY_PATH, NFDIR, CPPFLAGS and LDFLAGS variables:
    ```
    export NCDIR=${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1
    export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
    export NFDIR=${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1
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
4. Edit the makefile BIN, CMAQ_LIBRARIES and NCFLIBS variables:
    ```
    vi Makefile
    ```
    - Use this values. **[CMAQ_LIBRARIES]** is the same location saved on $CMAQ_LIBRARIES:
        ```
        BIN = Linux2_x86_64ifort_openmpi4.0.2_intel19.1
        INSTALL = /[CMAQ_LIBRARIES]
        NCFLIBS = -lnetcdff -lnetcdf
        ```
5. Enter the ioapi folder:
    ```
    cd ioapi
    ```
6. Create a personalized Makeinclude file from template:
    ```
    cp Makeinclude.Linux2_x86_64ifort Makeinclude.Linux2_x86_64ifort_openmpi4.0.2_intel19.1
    ```
7. Edit the Makeinclude file:
    ```
    vi Makeinclude.Linux2_x86_64ifort_openmpi4.0.2_intel19.1
    ```
    - Use this values: ###############################
        ```
        FC   = ifort -auto -warn notruncated_source
        OMPFLAGS = -qopenmp
        OMPLIBS = -qopenmp

        ARCHFLAGS = \
        -DIOAPI_NCF4=1 \
        -DAUTO_ARRAYS=1 \
        -DF90=1 -DFLDMN=1 \
        -DFSTR_L=int \
        -DIOAPI_NO_STDOUT=1 \
        -DAVOID_FLUSH=1 -DBIT32=1
        ARCHLIB   =
        ```
8. Create the Makefile from nocpl template:
    ```
    cp Makefile.nocpl Makefile
    ```
9. Edit Makefile:
    ```
    vi Makefile
    ```
    - **[CMAQ_LIBRARIES]** is the same location saved on $CMAQ_LIBRARIES:
        ```
        BASEDIR = /[CMAQ_LIBRARIES]/ioapi-3.2
        INSTDIR = /[CMAQ_LIBRARIES]/Linux2_x86_64ifort_openmpi4.0.2_intel19.1 
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
    - **[CMAQ_LIBRARIES]** is the same location saved on $CMAQ_LIBRARIES:
        ```
        BASEDIR = /[CMAQ_LIBRARIES]
        ```
13. Return to ioapi-3.2 folder:
    ```
    cd ..
    ```
14. Set the BIN variable as:
    ```
    export BIN=Linux2_x86_64ifort_openmpi4.0.2_intel19.1
    ```
15. Create the BIN directory. (This will be the location of the I/O API library)
    ```
    mkdir $BIN
    cd $BIN
    ```
16. Link the netCDF-C and netCDF-Fortran libraries archives:
    ```
    ln -s ${CMAQ_LIBRARIES}/netcdf-c-4.7.2-openmpi4.0.2-intel19.1/lib/libnetcdf.a
    ln -s ${CMAQ_LIBRARIES}/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1/lib/libnetcdff.a
    ```
17. Return to ioapi-3.2 folder:
    ``` 
    cd ..
    ```
18. Make the insatll
    ```
    make all |& tee make.log 
    ```
19. Copy .mod and .h files into the include directory (fixed_src):
    ```
    cp ${BIN}/*.mod ${CMAQ_LIBRARIES}/ioapi-3.2/ioapi/fixed_src
    cp ioapi/*.h ${CMAQ_LIBRARIES}/ioapi-3.2/ioapi/fixed_src
    ```
20. Return to the home directory:
    ```
    cd ..
    cd ..
    ```
---
## VIII. Install CMAQ and Benchamark
This intructions set is a summary of the [Users Guide Installation and Benchmarking tutorial][1] and unlike the library installation instructions it has no significant changes besides the directories names. It is recommended to follow the original intructions page for a more indepth explanation of each step.

**Note:** If for some reason the libraries instalation and the CMAQ building are made in diferent terminal sessions, you must export the complete path of all the compilers and libraries before proceding whit the installation. An example of the libraries needes is shown in the code bellow, but the locations could change depending on your specific build.
```
export PATH=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64:/opt/intel/compilers_and_libraries_2020.0.166/linux/bin:/opt/intel/debugger_2020/gdb/intel64/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/camilo/CMAQ-5.3.1/LIBRARIES/OpenMPI/bin
export LD_LIBRARY_PATH=/home/camilo/CMAQ-5.3.1/LIBRARIES/ioapi-3.2/Linux2_x86_64ifort_openmpi4.0.2_intel19.1:/home/camilo/CMAQ-5.3.1/LIBRARIES/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1/lib:/home/camilo/CMAQ-5.3.1/LIBRARIES/netcdf-c-4.7.2-openmpi4.0.2-intel19.1/lib:/opt/intel/compilers_and_libraries_2020.0.166/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/ipp/lib/intel64:/opt/intel/compilers_and_libraries_2020.0.166/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/tbb/lib/intel64/gcc4.8:/opt/intel/compilers_and_libraries_2020.0.166/linux/tbb/lib/intel64/gcc4.8:/opt/intel/debugger_2020/python/intel64/lib:/opt/intel/debugger_2020/libipt/intel64/lib:/opt/intel/compilers_and_libraries_2020.0.166/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2020.0.166/linux/daal/../tbb/lib/intel64_lin/gcc4.4:/opt/intel/compilers_and_libraries_2020.0.166/linux/daal/../tbb/lib/intel64_lin/gcc4.8:/home/camilo/CMAQ-5.3.1/LIBRARIES/OpenMPI/lib
```

1. Clone the CMAQ 5.3.1 repository:
    ```
    git clone -b master https://github.com/USEPA/CMAQ.git CMAQ_REPO
    ```
2. Enter the CMAQ_REPO folder and checkout the new branch:
    ```
    cd CMAQ_REPO
    git checkout -b my_branch
    ```
3. Set CMAQ_HOME in bldit_project.csh as set CMAQ_HOME = /home/[username]/CMAQ-5.3.1 and run the scipt. This will create the directories needes for the intallation:
    ```
    ./bldit_project.csh
    ```
4. Go to the CMAQ_HOME directory and set the location of the libraries and include files on the config_cmaq.csh. The locations listed in here may vary between intallations and shoukd be rechecked on each sistem.
    ```
    cd ..
    vi config_cmaq.csh
    ```
    - Edit the locations in the intel compiler case of the file:
        ```
        #> Intel fortran compiler......................................................
        case intel:

        setenv IOAPI_INCL_DIR [CMAQ_LIBRARIES]/ioapi-3.2/ioapi/fixed_src #> I/O API include header files
        setenv IOAPI_LIB_DIR [CMAQ_LIBRARIES]/ioapi-3.2/Linux2_x86_64ifort_openmpi4.0.2_intel19.1 #> I/O API libraries
        setenv NETCDF_LIB_DIR [CMAQ_LIBRARIES]/netcdf-c-4.7.2-openmpi4.0.2-intel19.1/lib #> netCDF C directory path
        setenv NETCDF_INCL_DIR [CMAQ_LIBRARIES]/netcdf-c-4.7.2-openmpi4.0.2-intel19.1/include #> netCDF C directory path
        setenv NETCDFF_LIB_DIR [CMAQ_LIBRARIES]/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1/lib #> netCDF Fortran directory path
        setenv NETCDFF_INCL_DIR [CMAQ_LIBRARIES]/netcdf-fortran-4.5.2-openmpi4.0.2-intel19.1/include #> netCDF Fortran directory path
        setenv MPI_LIB_DIR [CMAQ_LIBRARIES]/OpenMPI/lib #> MPI directory path
        
        setenv myFC mpifort
        setenv myLINK_FLAG "-qopenmp"
        ...
        setenv netcdf_lib"-lnetcdf -lnetcdff" #> -lnetcdff -lnetcdf for netCDF v4.2.0 and later
        ```
5. Run the config_cmaq.csh script whit the compiler optin 'intel'.
    ```
    ./config_cmaq.csh intel
    ```
6. Download the 2 day Benchmark data Input and Output folders found [here][2] and untar them on the ${CMAQ_HOME}/data directory. The code below assumes that your download destination was the /home/[user]/Downloads
    ```
    cp /home/[user]/Downloads/CMAQv5.3.1_Benchmark_2Day_Input_20191219.tar.gz /home/camilo/CMAQ-5.3.1/data
    cp /home/[user]/Downloads/CMAQv5.3.1_Benchmark_2Day_Output.tar.gz /home/camilo/CMAQ-5.3.1/data
    cd data
    tar xvzf CMAQv5.3.1_Benchmark_2Day_Input_20191219.tar.gz
    tar xvzf CMAQv5.3.1_Benchmark_2Day_Output.tar.gz
    cd ..
    ```
7. Enter the CCTM scrips folder:
    ```
    cd CCTM/scripts
    ```
8. Edit the bldit_cctm.csh file in order to set the following conditios:
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
9. Build the CCTM script and create the executable:
    ```
    ./bldit_cctm.csh intel |& tee bldit.cctm.log
    ```
10. Check if the .EXE file was created:
    ```
    ls -al BLD_CCTM_v531_intel/CCTM_v531.exe
    ```
11. Edit de CCTM run script depending on your specific setup for the run:
    ```
    vi run_cctm_Bench_2016_12SE1.csh
    ```
    - Delete the compiler version variable when the config_cmaq.csh is runed in the script:
        ```
        source ./config_cmaq.csh $compiler
        ```
    - Set the directories locations for the run:
        ```
        #> Set the build directory (this is where the CMAQ executable is located by default).
        set BLD       = /home/camilo/CMAQ-5.3.1/CCTM/scripts/BLD_CCTM_${VRSN}_${compilerString}

        setenv WORKDIR /home/camilo/CMAQ-5.3.1/CCTM/scripts       #> Working Directory. Where the runscript is.
        setenv OUTDIR  /home/camilo/CMAQ-5.3.1/data/output_CCTM_${RUNID} #> Output Directory
        setenv INPDIR  /home/camilo/CMAQ-5.3.1/data/CMAQv5.3.1_Benchmark_2Day_Input/2016_12SE1  #Input Directory
        ```
    - Set the **number of processors** that you will use for the run:
        ```
        @ NPCOL  =  2; @ NPROW =  2
        ```
    The multiplication betwee `NPCOL` and `NPROW` sill be the total number of processors that will be used. The values of the command above are set for a 4 processor machine.

    - This conditiosn must be set whith Y:
        ```
        setenv CTM_BIDI_FERT_NH3 Y
        ```
    - Set the OpenMPI run script location and allow run as root:
        ```
        set MPI = /[CMAQ_LIBRARIES]/OpenMPI/bin
        set MPIRUN = $MPI/mpirun
        ( /usr/bin/time -p mpirun --allow-run-as-root -np $NPROCS $BLD/$EXEC ) |& tee buff_${EXECUTION_ID}.txt
        ```
12. Run the script:
    ```
    ./run_cctm_Bench_2016_12SE1.csh |& tee cctm.log
    ```
    - When the run is succesful, this message will apear in the terminal:
        ```
        >>----> Program completed successfully <----<<
        ```
---
## IX. Installing VERDI
In this tutorial we recomend using VERDI for quick checking the Benchmark output. This is not a mandatory requiriment, but it is recomended in order to realize possible errors in the run script configuration.

1. Download VERDI. For this step you must have an CMAS account and download the tar.gz package fron [this page][3]. In this guide is used the 2.0 beta version of VERDI.
2. Extract the tar file:
    ```
    tar -xvf /home/camilo/Downloads/VERDI_2.0_beta_linux64_20190820.tar.gz
    ```
3. Edit the `DIR` varible on `verdi.sh` to match the location of the installation:
    ```
    vi verdi.sh
    ```
4. Make a *verdi* directory:
    ```
    mkdir verdi
    ```
5. Create an empti text file named `verdi.alias` into the *verdi* directory:
    ```
    cd verdi
    vi verdi.alias
    ```
    - Check that the text file have 0 lenght:
        ```
        ls -sh verdi.alias
        ```
6. Copy the `config.propierties.TEMPLATE` into the *verdi* directory and rename it as `config.propierties`.
    ```
    cp /home/camilo/CMAQ-5.3.1/VERDI_2.0_beta/config.properties.TEMPLATE config.properties
    ```
7. Run VERDI:
    ```
    cd ..
    ./verdi.sh
    ```
---
## X. Install CMAQ adjoint
This installation is based on the msater branch of the adjoint.colorado.edu:8080 repository. To acsses the source code you must ask the creators for acsses permission.

1. Download the source code and untar it into the CMAQ_HOME directory:
    ```
    tar -xzvf /home/camilo/Downloads/cmaq_adj-master.tar.gz /home/camilo/CMAQ-5.3.1
    ```
2. Add the STENEX and PARIO libraries on the *lib* directory:
    ```
    cp -r /home/camilo/CMAQ-5.3.1/CMAQ_REPO/CCTM/src/STENEX /home/camilo/CMAQ-5.3.1/lib/x86_64/intel
    mkdir /home/camilo/CMAQ-5.3.1/lib/x86_64/intel/STENEX/se_noop
    cd /home/camilo/CMAQ-5.3.1/lib/x86_64/intel/STENEX/se
    cp  *.F ../se_noop
    cp  *.f ../se_noop
    cd ..
    cd /home/camilo/CMAQ-5.3.1/lib/x86_64/intel/STENEX/noop
    cp  *.f ../se_noop
    cp -r /home/camilo/CMAQ-5.3.1/CMAQ_REPO/CCTM/src/PARIO /home/camilo/CMAQ-5.3.1/lib/x86_64/intel
    ```
3. Enter the adjoint directory:
    ```
    cd cmaq_adj
    ```
4. Configure the config.cmaq script based on your system:
    ```
    vi config.cmaq
    ```
    -Set the model locations:
        ```
        setenv M3HOME  /home/camilo/CMAQ-5.3.1/cmaq_adj-master
        setenv M3MODEL /home/camilo/CMAQ-5.3.1/cmaq_adj-master/CCTM
        setenv M3DATA  /home/camilo/CMAQ-5.3.1/data
        ...
        setenv lib_basedir /home/camilo/CMAQ-5.3.1/lib
        ...
        setenv myFC mpifort
        setenv myCC icc
        setenv myLINK_FLAG "-qopenmp"
        setenv mpi "-lmpi"
        ```
5. Enter to the *BLDMAKE_git* folder and configure the Makefile:
    ```
    cd BLDMAKE_git
    vi Makefile
    ```
    - Set the routes of the compilers and the system FLAGS:
        ```
        FC = /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
        F_FLAGS = -O2 -fixed -extend_source -WB
         CC = /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
        ```
6. Run the Makefile and check that the `bldmake` was created:
    ```
    make |& tee make.bld.log
    ```
7. Enter the *scripts* drectory:
    ```
    cd ../scripts
    ```
8. Copy the forward sweep template whith the system specific name and edit to match your system requrements:
    ```
    cp bldit.adjoint.fwd.sample bldit.adjoint.fwd.intel
    vi bldit.adjoint.fwd.intel
    ```
    - Set the specified locations based on your installations:
        ```
        setenv M3MODEL /home/camilo/CMAQ-5.3.1/cmaq_adj-master
        setenv lib_basedir /home/camilo/CMAQ-5.3.1/lib
        setenv MPI_INC /home/camilo/CMAQ-5.3.1/LIBRARIES/OpenMPI/include
        ...
        # CHANGE: Set full path of Fortran 90 and c compilers
         set FC = /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/ifort
         set CC = /opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc
        ...
        # CHANGE: Set location of MPICH if using multiple processors
         set MPICH  =  " /home/camilo/CMAQ-5.3.1/LIBRARIES/OpenMPI/include -lmpi"
        ...
        # CHANGE: Set location for stenex library/include/and mod files
         set STENEX = $M3LIB/STENEX/se_noop
        ...
        # CHANGE: Set compiler flags
         set FSTD       = "-O3 -fno-alias -mp1 -fp-model source -ftz -simd -align all -xHost -vec-guard-write -unroll-aggressive"
         set F_FLAGS    = "${FSTD} -O2 -module ${MODLOC} -I."
         set CPP_FLAGS  = ""
         set C_FLAGS    = "-O2"
         set LINK_FLAGS = "-qopenmp"
         ...
         # CHANGE: Set location of libraries/include files
         set IOAPI = "${M3LIB}/ioapi/lib -lioapi"
         set ICL_IOAPI = ${M3LIB}/ioapi/include_files
         set NETCDF = "${M3LIB}/netcdf/lib -lnetcdf"
         set PARIO = "${M3LIB}/PARIO -lpario"
        ```
9. execute the build file:
    ```
    ./bldit.adjoint.fwd.intel |& tee bldit.fwd.log
    ```
7. Go to the new build directory and Make the forward sweep executable:
    ```
    cd ../BLD_fwd_noaero
    make |& tee make.fwd.log
    ```
[1]: https://github.com/USEPA/CMAQ/blob/master/DOCS/Users_Guide/Tutorials/CMAQ_UG_tutorial_benchmark.md
[2]: https://drive.google.com/drive/folders/10wFNch1MkI49ZjD2XD6wK2xzDWOav2zY
[3]: https://www.cmascenter.org/verdi/