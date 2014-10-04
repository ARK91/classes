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
    reg [16:0] vec;

    //problem_2_5_4_mux_74151_structural DUT(ta, tb, tc, ts, ty, tw,
    //                                  td0, td1, td2, td3, td4, td5, td6, td7);

    problem_2_5_4_mux_74151_dataflow DUT(ta, tb, tc, ts, ty, tw,
                                      td0, td1, td2, td3, td4, td5, td6, td7);

    initial
    begin
        for (vec = 0; vec < 4096; vec++)
        begin
            {ts, tc, tb, ta, td0, td1, td2, td3, td4, td5, td6, td7} = vec ;

            // Test that strobe drives y to 0:
            if (ts & ty)
                #1 $display("time %t ",$time,
                    "Stobe HIGH failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                            " :::td0-td8: %b%b%b%b%b%b%b%b",
                            td0, td1, td2, td3, td4, td5, td6, td7);

            // Test that ty is always ~tw:
            if (ty != ~tw)
                #1 $display("time %t ",$time,
                    "(ty == ~tw) failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            // Test that td0 is sent to ty, when strobe is low and cba == 000:
            if((~ts & ~tc & ~tb & ~ta) && (ty != td0))
                #1 $display("time %t ",$time,
                    "d0 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & ~tc & ~tb & ta) && (ty != td1))
                #1 $display("time %t ",$time,
                    "d1 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & ~tc & tb & ~ta) && (ty != td2))
                #1 $display("time %t ",$time,
                    "d2 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & ~tc & tb & ta) && (ty != td3))
                #1 $display("time %t ",$time,
                    "d3 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & tc & ~tb & ~ta) && (ty != td4))
                #1 $display("time %t ",$time,
                    "d4 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & tc & ~tb & ta) && (ty != td5))
                #1 $display("time %t ",$time,
                    "d5 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & tc & tb & ~ta) && (ty != td6))
                #1 $display("time %t ",$time,
                    "d6 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

            if((~ts & tc & tb & ta) && (ty != td7))
                #1 $display("time %t ",$time,
                    "d7 selection failed: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                            " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);

        end // for loop
        #1 $display("****DONE: ts, tc, tb, ta %b%b%b%b", ts, tc, tb, ta,
                    " :::ty,tw %b%b", ty, tw,
                    " :::td0-td8: %b%b%b%b%b%b%b%b",
                    td0, td1, td2, td3, td4, td5, td6, td7);
    end // initial
endmodule

/* Results:

problem_2_5_4_mux_74151_structural test run:

vlog -sv *.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module mux
# -- Compiling module problem_2_5_4_mux_74151_structural
# -- Compiling module problem_2_5_4_mux_74151_dataflow
# -- Compiling module problem_2_5_4_mux_74151_tb
#
# Top level modules:
#   mux
#   problem_2_5_4_mux_74151_dataflow
#   problem_2_5_4_mux_74151_tb
vsim work.problem_2_5_4_mux_74151_tb
# vsim work.problem_2_5_4_mux_74151_tb
# Loading sv_std.std
# Loading work.problem_2_5_4_mux_74151_tb
# Loading work.problem_2_5_4_mux_74151_structural
add wave *
run 4097
# ****DONE: ts, tc, tb, ta 1111 :::ty,tw 01 :::td0-td8: 11111111

problem_2_5_4_mux_74151_dataflow test run:

vlog -sv *.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module mux
# -- Compiling module problem_2_5_4_mux_74151_structural
# -- Compiling module problem_2_5_4_mux_74151_dataflow
# -- Compiling module problem_2_5_4_mux_74151_tb
#
# Top level modules:
#   mux
#   problem_2_5_4_mux_74151_structural
#   problem_2_5_4_mux_74151_tb
vsim work.problem_2_5_4_mux_74151_tb
# vsim work.problem_2_5_4_mux_74151_tb
# Loading sv_std.std
# Loading work.problem_2_5_4_mux_74151_tb
# Loading work.problem_2_5_4_mux_74151_dataflow
add wave *
run 4097
# ****DONE: ts, tc, tb, ta 1111 :::ty,tw 01 :::td0-td8: 11111111

*/
