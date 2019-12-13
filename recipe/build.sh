#!/bin/bash

# only link libraries we actually use
export CFITSIO_LIBS="-L${PREFIX}/lib -lcfitsio"
export GSL_LIBS="-L${PREFIX}/lib -lgsl"

mkdir -p _build
pushd _build

# configure
${SRC_DIR}/configure \
	--prefix=${PREFIX} \
	--disable-gcc-flags \
	--enable-cfitsio \
	--enable-help2man \
;

# build
make -j ${CPU_COUNT}

# check
make -j ${CPU_COUNT} check

# install
make -j ${CPU_COUNT} install
