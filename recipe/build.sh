#!/bin/bash

set -ex

if [[ "${mpi}" == "nompi" ]]; then
    MPI_ARGS="--disable-mpi"
else
    MPI_ARGS="--enable-mpi MPICC=${PREFIX}/bin/mpicc MPICXX=${PREFIX}/bin/mpicxx MPIFC=${PREFIX}/bin/mpifc"
fi

./configure \
	--prefix=${PREFIX} \
	--disable-gcc-flags \
	--enable-cfitsio \
	--enable-openmp \
	${MPI_ARGS}

make -j ${CPU_COUNT}
make -j ${CPU_COUNT} check
make -j ${CPU_COUNT} install
