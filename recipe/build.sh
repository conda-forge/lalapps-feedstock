#!/bin/bash

# use out-of-tree build
mkdir -p _build
pushd _build

# handle cross compiling
if [[ $build_platform != $target_platform ]]; then
	CONFIG_ARGS="${CONFIG_ARGS} --disable-help2man"
fi

# only link libraries we actually use
export CFITSIO_LIBS="-L${PREFIX}/lib -lcfitsio"
export GSL_LIBS="-L${PREFIX}/lib -lgsl"

# configure
${SRC_DIR}/configure \
	--disable-gcc-flags \
	--enable-cfitsio \
	--prefix=${PREFIX} \
	${CONFIG_ARGS} \
;

# build
make -j ${CPU_COUNT} V=1 VERBOSE=1

# check (only when not cross compiling)
if [[ $build_platform == $target_platform ]]; then
	make -j ${CPU_COUNT} V=1 VERBOSE=1 check
fi

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install
