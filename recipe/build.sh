#!/bin/bash

# Ensure the timestamp dependencies do not cause us to need
# to run autoreconf-y stuff (which I tried but it is not in
# a working state at present with gawk 4.2.1).
chmod +x ./bootstrap.sh
./bootstrap.sh

./configure --prefix="${PREFIX}" \
            --with-readline="${PREFIX}"

make -j${NUM_CPUS} ${VERBOSE_AT}

# These tests fail under emulation, still run them but ignore their result
if [[ ${target_platform} == linux-aarch64 ]]; then
    make check -j${NUM_CPUS} || true
elif [[ ${target_platform} == linux-ppc64le ]]; then
    make check -j${NUM_CPUS} || true
else
    make check -j${NUM_CPUS}
fi

make install
