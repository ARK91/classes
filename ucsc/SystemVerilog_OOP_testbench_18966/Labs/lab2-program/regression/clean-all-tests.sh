#!/bin/bash
#
# CLEANS all test scenario directories

for f in ../scenarios/*; do
    pushd $f;
    ./CLEAN
    popd
done
