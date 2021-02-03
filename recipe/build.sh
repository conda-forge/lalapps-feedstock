#!/bin/bash

# only link libraries we actually use
export CFITSIO_LIBS="-L${PREFIX}/lib -lcfitsio"
export GSL_LIBS="-L${PREFIX}/lib -lgsl"

mkdir -p _build
pushd _build

# configure
${SRC_DIR}/configure \
	--disable-gcc-flags \
	--enable-cfitsio \
	--enable-help2man \
	--prefix=${PREFIX} \
;

# build
make -j ${CPU_COUNT} V=1 VERBOSE=1

# check
make -j ${CPU_COUNT} V=1 VERBOSE=1 check

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install
