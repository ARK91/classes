#!/bin/bash

for f in ../testcases/*; do
    pushd $f;
    ./runsim
    popd
done
