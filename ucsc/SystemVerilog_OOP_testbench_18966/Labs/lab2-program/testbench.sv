`timescale 1ns/1ns

module testbench();
    parameter WIDTH = 32;
    logic clk, reset, enable, preload, mode, detect;
    logic   [WIDTH-1:0]  preload_data;
    logic   [WIDTH-1:0]  result;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    counter #(WIDTH) DUT(.*);

    //testcase_counter_sanity_check #(WIDTH) TEST_CASE_1(.*);

    testcase_counter_count2max #(WIDTH) TEST_CASE_1(.*);

endmodule

// Typical run:

//  <sc-xterm-23> lab2-program $ run-full-vcs counter.v testbench.sv testcase.sv
//  Job <253478445> is submitted to queue <o_pri_interactive>.
//  <<Waiting for dispatch ...>>
//  <<Starting on sc-sim-204-023>>
//                           Chronologic VCS (TM)
//           Version E-2011.03-SP1-2 -- Wed Jul  1 23:40:05 2015
//                 Copyright (c) 1991-2011 by Synopsys Inc.
//                           ALL RIGHTS RESERVED
//
//  This program is proprietary and confidential information of Synopsys Inc.
//  and may be used and disclosed only as authorized in a license agreement
//  controlling such use and disclosure.
//
//  Parsing design file 'counter.v'
//  Parsing design file 'testbench.sv'
//  Parsing design file 'testcase.sv'
//  Top Level Modules:
//         testbench
//  TimeScale is 1 ns / 1 ns
//  Starting vcs inline pass...
//  3 modules and 0 UDP read.
//  recompiling module testbench
//  recompiling module testcase
//  All of 3 modules done
//  if [ -x ../simv ]; then chmod -x ../simv; fi
//  g++  -o ../simv -melf_i386 -m32   -Wl,-whole-archive    -Wl,-no-whole-archive  _vcsobj_1_1.o  5NrI_d.o 5NrIB_d.o SIM_l.o     rmapats_mop.o rmapats.o      /home/tools/vcs/2011.03-SP1-2/linux/lib/libvirsim.so /home/tools/vcs/2011.03-SP1-2/linux/lib/librterrorinf.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libsnpsmalloc.so     /home/tools/vcs/2011.03-SP1-2/linux/lib/libvcsnew.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libuclinative.so         /home/tools/vcs/2011.03-SP1-2/linux/lib/vcs_save_restore_new.o /home/tools/vcs/2011.03-SP1-2/linux/lib/ctype-stubs_32.a -ldl -lm  -lc -lpthread -ldl
//  ../simv up to date
//  Chronologic VCS simulator copyright 1991-2011
//  Contains Synopsys proprietary information.
//  Compiler version E-2011.03-SP1-2; Runtime version E-2011.03-SP1-2;  Jul  1 23:40 2015
//
//  t=  0: result= 0, detect=0
//  t= 25: result= 1, detect=0
//  t= 35: result= 2, detect=0
//  t= 45: result= 3, detect=0
//  t= 55: result= 4, detect=0
//  t= 65: result= 5, detect=0
//  t= 75: result= 6, detect=0
//  t= 85: result= 7, detect=0
//  t= 95: result= 8, detect=0
//  t=105: result= 9, detect=0
//  t=115: result=10, detect=0
//  $finish called from file "testcase.sv", line 46.
//  $finish at simulation time                  125
//             V C S   S i m u l a t i o n   R e p o r t
//  Time: 125 ns
//  CPU Time:      0.040 seconds;       Data structure size:   0.0Mb
//  Wed Jul  1 23:40:08 2015
//  CPU time: .121 seconds to compile + .061 seconds to elab + .123 seconds to link + .108 seconds in simulation

