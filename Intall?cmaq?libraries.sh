#!/bin/bash

# Install system libraries
apt-get -y update
apt-get -y install git
apt-get -y m4
apt install csh
apt-get -y install build-essential
apt-get -y install gfortran

# Set the home CMAQ directory
mkdir CMAQ-5.3.1
cd CMAQ-5.3.1
mkdir LIBRARIES
export CMAQ_HOME=${PWD}
export CMAQ_LIBRARIES = ${CMAQ_HOME}/LIBRARIES
cd ${CMAQ_LIBRARIES}

# INtall OpenMPI




