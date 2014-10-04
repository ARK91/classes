// File: problem_2_5_4_mux_74151_tb.v
// John Hubbard, 03 Oct 2014
// hw2 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw2b
// vlib work
// vlog -sv *.v
// vsim work.problem_2_5_4_mux_74151_tb
// add wave *
// run 20 ns
//

`timescale 1ns/1ns
module problem_2_5_4_mux_74151_tb;
    reg ta, tb, tc, ts, td0, td1, td2, td3, td4, td5, td6, td7;
    wire ty, tw;
    reg [11:0] vec;

    problem_2_5_4_mux_74151_structural DUT(ta, tb, tc, ts, ty, tw,
                                        td0, td1, td2, td3, td4, td5, td6, td7);

    //problem_2_5_4_mux_74151_structural DUT(ta, tb, tc, ts, ty, tw,
    //                                  td0, td1, td2, td3, td4, td5, td6, td7);

    initial
    begin
        for (vec = 0; vec < 4096; vec = vec +1)
        begin
            {ts, tc, tb, ta, td0, td1, td2, td3, td4, td5, td6, td7} = vec ;

            if ((ts & ty) || (ts & ~tw))
                #1 $display("time %t ",$time,
                    "Stobe HIGH failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                    ":::ty, tw %b %b", ty, tw);

        end
    end

    #1 $display("time %t DONE", $time);
endmodule

/* Results:

problem_2_5_4_mux_74151_structural test run:

problem_2_5_4_mux_74151_dataflow test run:

*/
