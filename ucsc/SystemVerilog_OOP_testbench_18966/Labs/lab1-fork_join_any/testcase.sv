`include "./tasks.sv"

module testcase();

   initial begin
     fork 
       show (3,2);	
       show (5,8);	
       show(10,25);
       show(23,0);
       show (6,1);	
     join_any
     $display("time=%2t: Exiting fork-join...\n", $time);

     show (5, 3);	

     #100 $finish;
   end

endmodule

/* Sample run:
<sc-xterm-23> lab1-fork_join_any $ run-full-vcs testcase.sv
Job <240722145> is submitted to queue <o_pri_interactive>.
<<Waiting for dispatch ...>>
<<Starting on sc-sim-204-043>>
                         Chronologic VCS (TM)
         Version E-2011.03-SP1-2 -- Thu Jun 25 00:04:22 2015
               Copyright (c) 1991-2011 by Synopsys Inc.
                         ALL RIGHTS RESERVED

This program is proprietary and confidential information of Synopsys Inc.
and may be used and disclosed only as authorized in a license agreement
controlling such use and disclosure.

Parsing design file 'testcase.sv'
Parsing included file './tasks.sv'.
Back to file 'testcase.sv'.
Top Level Modules:
       testcase
No TimeScale specified
Starting vcs inline pass...
2 modules and 0 UDP read.
	However, due to incremental compilation, no re-compilation is necessary.
ld -r -m elf_i386 -o pre_vcsobj_0_1.o --whole-archive pre_vcsobj_0_1.a --no-whole-archive
if [ -x ../simv ]; then chmod -x ../simv; fi
g++  -o ../simv -melf_i386 -m32   -Wl,-whole-archive    -Wl,-no-whole-archive  _vcsobj_1_1.o  5NrI_d.o 5NrIB_d.o SIM_l.o    pre_vcsobj_0_1.o  rmapats_mop.o rmapats.o      /home/tools/vcs/2011.03-SP1-2/linux/lib/libvirsim.so /home/tools/vcs/2011.03-SP1-2/linux/lib/librterrorinf.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libsnpsmalloc.so     /home/tools/vcs/2011.03-SP1-2/linux/lib/libvcsnew.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libuclinative.so         /home/tools/vcs/2011.03-SP1-2/linux/lib/vcs_save_restore_new.o /home/tools/vcs/2011.03-SP1-2/linux/lib/ctype-stubs_32.a -ldl -lm  -lc -lpthread -ldl
../simv up to date
Chronologic VCS simulator copyright 1991-2011
Contains Synopsys proprietary information.
Compiler version E-2011.03-SP1-2; Runtime version E-2011.03-SP1-2;  Jun 25 00:04 2015

time= 3: Delay= 3 Count= 2. Short Process Running...
time= 3: Exiting fork-join...

time= 5: Delay= 5 Count= 8. Medium Process Running...
time= 6: Delay= 6 Count= 1. Medium Process Running...
time= 8: Delay= 5 Count= 3. Medium Process Running...
time=10: Delay=10 Count=25. Long Process Running...
time=23: Delay=23 Count= 0. Zombie Process Running...
$finish called from file "testcase.sv", line 17.
$finish at simulation time                  108
           V C S   S i m u l a t i o n   R e p o r t
Time: 108
CPU Time:      0.030 seconds;       Data structure size:   0.0Mb
Thu Jun 25 00:04:24 2015
CPU time: .095 seconds to compile + .014 seconds to elab + .096 seconds to link + .089 seconds in simulation

*/
