
export M3HOME=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO
export M3MODEL=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/models
export M3LIB=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/lib
export M3DATA=/hpcfs/home/ca.moreno12/.conda/envs/cmaq_env/CMAQ_4.7.1/CMAQ_REPO/data

 1) cd to $M3HOME and gunzip and untar the data tar file, M3DATA.tar.gz.
    This will produce the following subdirectories:

       data/
           bcon/   <<<<<<< empty, to be filled by the user
           cctm/   <<<<<<< empty, to be filled by the user
           emis/
              2001/
           icon/   <<<<<<< empty, to be filled by the user
           jproc/  <<<<<<< empty, to be filled by the user
           mcip3/
              M_36_2001/
           procan/
           raw/
              bcon/
              emis/
              icon/
              phot/

 2) Create (mkdir) the subdirectory $M3LIB and the following subdirectories
    under $M3LIB:

          build/
          ioapi_3/
          netCDF/
          pario/
          stenex/

  **Concerning netCDF:  The scripts assume that netCDF resides in the
    $M3LIB path as $M3LIB/netCDF.  If netCDF is installed elsewhere on your
    system, create a symbolic link in $M3LIB/netCDF to the existing netCDF
    (see CVS_NETCDF).

    Example for Linux cluster:

       mkdir -p $M3LIB/netCDF/Linux
       cd $M3LIB/netCDF/Linux
       ln -s /home/wdx/lib/x86/pgf/netcdf-4.0/lib/libnetcdf.a .

  **Concerning ioapi_3:  We recommend that you download IOAPI version 3.0
    from the CMAS/EMC web site and compile the libraries that you need.
    This is done by editing the appropriate Makeinclude file(s) for the
    compiler flags, if necessary, and setting the "BIN" environment variable
    appropriately - see the IOAPI readme file included with this release.

 5) In $M3HOME gunzip and untar the models archive tar file, MODELS.tar.gz.
    This will produce the following subdirectories:

       models/
              BCON/
              BUILD/
              CCTM/
              ICON/
              JPROC/
              PARIO/
              PROCAN/
              STENEX/
              TOOLS/
              include/

 6) Make a working directory (NOT in either the $M3MODEL, $M3LIB or $M3DATA
    trees), cd there and gunzip and untar SCRIPTS.tar.gz. This will produce
    the following subdirectories, which contain "bldit" and "run" C-shell
    scripts and a GRIDDESC file (see item 17(b). under "other details"
    below):

       scripts/
              GRIDDESC1
              bcon/
              build/
              cctm/
              icon/
              jproc/
              pario/
              procan/
              stenex/

    Not necessary, but for the sake of further discussion create an
    environment variable for the "scripts" working directory, $WORK.

 7) First, create the IOAPI library required for the models.  See the
    IOAPI readme file included with this release.

       mkdir $M3LIB/ioapi_3   <<<<<<< install here

 8) Next create the stencil exchange library required for parallel
    processing (se_snl) and serial processing (sef90_noop):

       cd $WORK/stenex
       Execute (type) bldit.se.pgf
       Execute (type) bldit.se_noop.pgf

 9) For parallel CCTM operation create the parallel I/O library (pario):

       cd $WORK/pario
       Execute (type) bldit.pario.pgf


