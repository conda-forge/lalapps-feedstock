#!/bin/bash

_make="make -j ${CPU_COUNT} V=1 VERBOSE=1"

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
${_make}

# check (only when not cross compiling)
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
	${_make} check
fi

# install
${_make} install
