#!/bin/bash
#
# CLEANS all test scenario directories

for f in ../testcases/*; do
    pushd $f;
    ./CLEAN
    popd
done
