#!/bin/bash
#
# Chooses NVIDIA's VCS, or UCSC Extension's VCS, or a fake version for
# testing the scripts themselves. All of this is based on hostname.
#
# Source this file into your leaf scripts and invoke run-vcs() from there.
#
# John Hubbard, 08 July 2015
#

run-nvidia-vcs ()
{
    echo "run-nvidia-vcs: $@"
    qsub -I -q o_pri_interactive_vcs_.4G $VCS/bin/vcs \
         -R -l vlog.log \
         -debug_pp \
         -sverilog \
         $@
}

run-ucsc-vcs ()
{
    echo "run-ucsc-vcs: $@"
    vcs -full64 +vcs+lic+wait +v2k \
         -R -l vlog.log \
         -debug_pp \
         -sverilog \
         $@
}

run-fake-vcs ()
{
    echo "run-fake-vcs: $@"
    echo "Listing files to be sure they're real:"
    ls -l $@
}

run-vcs()
{
    if [ `hostname` == "sc-xterm-23" ];then
        run-nvidia-vcs $@;
    elif [ `hostname` == "sandstorm" -o `hostname` == "blueforge" ];then
        run-fake-vcs $@;
    else
        run-ucsc-vcs $@;
    fi
}
