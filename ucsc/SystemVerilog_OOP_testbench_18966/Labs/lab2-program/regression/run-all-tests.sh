#!/bin/bash

for f in ../scenarios/*; do
    pushd $f;
    ./runsim
    popd
done
