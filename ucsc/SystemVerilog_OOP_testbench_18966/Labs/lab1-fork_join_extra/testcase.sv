module testcase();

   task automatic print(input int   delay, 
                        input [7:0] count
                       );

       #(delay) $display("time=%2t: Delay=%2d Count=%2d", $time, delay, count);
   endtask

   initial begin
     fork 
       print(3,2);	//process_a
       print(5,8);	//process_b
       print(6,1);	//process_c
     join_none

     #10;

     fork 
       print(2,5);	//process_c
       print(4,7);	//process_d
       print(9,8);	//process_e
     join_any
     
     $display("time=%2t: Exiting fork-join...\n", $time);

     //Wait until all in-flight threads complete
     wait fork;
     $display("time=%2t: All in-flight threads completed\n", $time);

     print(5, 3);	//process_f

     #100 $finish;
   end

     final begin
           //$display("time=%2t: Right before finishing...\n", $time);
           end

     final begin
           $display("Inside the final block. Executing the print() task...\n");
           print(5, 8);
     end

endmodule

/* Sample runs, before and after uncommenting the final block above:

<sc-xterm-23> lab1-fork_join_extra $ run-full-vcs testcase.sv
Job <240737235> is submitted to queue <o_pri_interactive>.
<<Waiting for dispatch ...>>
<<Starting on sc-sim-204-059>>
                         Chronologic VCS (TM)
         Version E-2011.03-SP1-2 -- Thu Jun 25 00:18:27 2015
               Copyright (c) 1991-2011 by Synopsys Inc.
                         ALL RIGHTS RESERVED

This program is proprietary and confidential information of Synopsys Inc.
and may be used and disclosed only as authorized in a license agreement
controlling such use and disclosure.

Parsing design file 'testcase.sv'
Top Level Modules:
       testcase
No TimeScale specified
Starting vcs inline pass...
2 modules and 0 UDP read.
	However, due to incremental compilation, only 1 module needs to be compiled.
recompiling module testcase because:
	This module or some inlined child module(s) has/have been modified.
ld -r -m elf_i386 -o pre_vcsobj_0_1.o --whole-archive pre_vcsobj_0_1.a --no-whole-archive
if [ -x ../simv ]; then chmod -x ../simv; fi
g++  -o ../simv -melf_i386 -m32   -Wl,-whole-archive    -Wl,-no-whole-archive  _vcsobj_1_1.o  5NrI_d.o 5NrIB_d.o SIM_l.o    pre_vcsobj_0_1.o  rmapats_mop.o rmapats.o      /home/tools/vcs/2011.03-SP1-2/linux/lib/libvirsim.so /home/tools/vcs/2011.03-SP1-2/linux/lib/librterrorinf.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libsnpsmalloc.so     /home/tools/vcs/2011.03-SP1-2/linux/lib/libvcsnew.so /home/tools/vcs/2011.03-SP1-2/linux/lib/libuclinative.so         /home/tools/vcs/2011.03-SP1-2/linux/lib/vcs_save_restore_new.o /home/tools/vcs/2011.03-SP1-2/linux/lib/ctype-stubs_32.a -ldl -lm  -lc -lpthread -ldl 
../simv up to date
Chronologic VCS simulator copyright 1991-2011
Contains Synopsys proprietary information.
Compiler version E-2011.03-SP1-2; Runtime version E-2011.03-SP1-2;  Jun 25 00:18 2015

time= 3: Delay= 3 Count= 2
time= 5: Delay= 5 Count= 8
time= 6: Delay= 6 Count= 1
time=12: Delay= 2 Count= 5
time=12: Exiting fork-join...

time=14: Delay= 4 Count= 7
time=19: Delay= 9 Count= 8
time=19: All in-flight threads completed

time=24: Delay= 5 Count= 3
$finish called from file "testcase.sv", line 33.
$finish at simulation time                  124
           V C S   S i m u l a t i o n   R e p o r t 
Time: 124
CPU Time:      0.060 seconds;       Data structure size:   0.0Mb
Thu Jun 25 00:18:29 2015
CPU time: .131 seconds to compile + .022 seconds to elab + .178 seconds to link + .141 seconds in simulation
<sc-xterm-23> lab1-fork_join_extra $ vi testcase.sv 
<sc-xterm-23> lab1-fork_join_extra $ run-full-vcs testcase.sv
Job <240739364> is submitted to queue <o_pri_interactive>.
<<Waiting for dispatch ...>>
<<Starting on sc-sim-204-019>>
                         Chronologic VCS (TM)
         Version E-2011.03-SP1-2 -- Thu Jun 25 00:20:28 2015
               Copyright (c) 1991-2011 by Synopsys Inc.
                         ALL RIGHTS RESERVED

This program is proprietary and confidential information of Synopsys Inc.
and may be used and disclosed only as authorized in a license agreement
controlling such use and disclosure.

Parsing design file 'testcase.sv'
Top Level Modules:
       testcase
No TimeScale specified

Error-[DIFB] Delay in final block
testcase.sv, 42
  Final block has delays, event controls, non blocking assigns, waits or calls
  to tasks with delays in its declaration.

1 error
CPU time: .082 seconds to compile
*/
