`include "tasks.sv"

module testcase();

   initial begin
     fork 
       show(3,2);	
       show(5,8);	
       show(10,25);
       show(23,0);
       show(6,1);	
     join_none
     $display("time=%2t: Exiting fork-join...\n", $time);

     //disbale all in-flight threads
     disable fork;
     $display("time=%2t: All in-flight threads are disabled...\n", $time);

     show(5, 3);	

     #100 $finish;
   end

endmodule

/* Sample run:
<sc-xterm-23> lab1-fork_join_none_disablefork $ run-full-vcs testcase.sv
Job <240731328> is submitted to queue <o_pri_interactive>.
<<Waiting for dispatch ...>>
<<Starting on sc-sim-204-074>>
                         Chronologic VCS (TM)
         Version E-2011.03-SP1-2 -- Thu Jun 25 00:12:25 2015
               Copyright (c) 1991-2011 by Synopsys Inc.
                         ALL RIGHTS RESERVED

This program is proprietary and confidential information of Synopsys Inc.
and may be used and disclosed only as authorized in a license agreement
controlling such use and disclosure.

Parsing design file 'testcase.sv'
Parsing included file 'tasks.sv'.
Back to file 'testcase.sv'.
Top Level Modules:
       testcase
No TimeScale specified
Starting vcs inline pass...
2 modules and 0 UDP read.
recompiling module testcase
All of 3 modules done
if [ -x ../simv ]; then chmod -x ../simv; fi
g++  -o ../simv -melf_i386 -m32   -Wl,-whole-archive    -Wl,-no-whole-archive  _vcsobj_1_1.o  5NrI_d.o 5NrIB_d.o SIM_l.o     rmapats_mop.o rmapats.o      /home/tools/vcs/2011.03-SP1-2/linux/lib/libvirsim.so /home/tools/vcs/2011.03-SP1-2/linux/lib/librterrorinf.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libsnpsmalloc.so     /home/tools/vcs/2011.03-SP1-2/linux/lib/libvcsnew.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libuclinative.so         /home/tools/vcs/2011.03-SP1-2/linux/lib/vcs_save_restore_new.o /home/tools/vcs/2011.03-SP1-2/linux/lib/ctype-stubs_32.a -ldl -lm  -lc -lpthread -ldl
../simv up to date
Chronologic VCS simulator copyright 1991-2011
Contains Synopsys proprietary information.
Compiler version E-2011.03-SP1-2; Runtime version E-2011.03-SP1-2;  Jun 25 00:12 2015

time= 0: Exiting fork-join...

time= 0: All in-flight threads are disabled...

time= 5: Delay= 5 Count= 3. Medium Process Running...
$finish called from file "testcase.sv", line 21.
$finish at simulation time                  105
           V C S   S i m u l a t i o n   R e p o r t
Time: 105
CPU Time:      0.040 seconds;       Data structure size:   0.0Mb
Thu Jun 25 00:12:28 2015
CPU time: .131 seconds to compile + .070 seconds to elab + .151 seconds to link + .096 seconds in simulation

*/
