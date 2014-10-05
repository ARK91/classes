// File: problem_2_5_7_subtract_tb.v
// John Hubbard, 04 Oct 2014
// hw3 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw3/b/modelsim
// vlib work
// vlog -sv ../*.v
// vsim work.problem_2_5_7_subtract_tb
// add wave *
// run 20 ns
//

`timescale 1ns/1ns
module problem_2_5_7_subtract_tb;
    reg tm, tn, tbin, compare_td, compare_tbout;
    reg tm2, tn2, tbin2;
    wire td, tbout;
    wire td2, tbout2;
    reg [3:0] vec;

    problem_2_5_7_subtract_dataflow   DUT(tm, tn, tbin, td, tbout);
    problem_2_5_7_subtract_behavioral DUT2(tm2, tn2, tbin2, td2, tbout2);

    initial
    begin
        for (vec = 0; vec < 8; vec++)
        begin
            {tbin,  tm,  tn}  = vec ;
            {tbin2, tm2, tn2} = vec ;

            #1 compare_td    = td ^ td2;
            compare_tbout = tbout2 ^ tbout2;

            #1 $display("time %t ",$time,
                        "tbin, tm, tn: %b%b%b", tbin, tm, tn,
                        "::: td, tbout: %b%b", td, tbout,
                        " compare_td, compare_tbout: %b%b",
                        compare_td, compare_tbout);
        end
    end

endmodule

/* Results:

problem_2_5_7_subtract_tb test run:

vlog ../*.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module problem_2_5_7_subtract_dataflow
# -- Compiling module problem_2_5_7_subtract_behavioral
# -- Compiling module problem_2_5_7_subtract_tb
#
# Top level modules:
#   problem_2_5_7_subtract_tb
vsim work.problem_2_5_7_subtract_tb
# vsim work.problem_2_5_7_subtract_tb
# Loading sv_std.std
# Loading work.problem_2_5_7_subtract_tb
# Loading work.problem_2_5_7_subtract_dataflow
# Loading work.problem_2_5_7_subtract_behavioral
add wave *
run 20 ns
# time  2 tbin, tm, tn: 000::: td, tbout: 00 compare_td, compare_tbout: 00
# time  4 tbin, tm, tn: 001::: td, tbout: 11 compare_td, compare_tbout: 00
# time  6 tbin, tm, tn: 010::: td, tbout: 10 compare_td, compare_tbout: 00
# time  8 tbin, tm, tn: 011::: td, tbout: 00 compare_td, compare_tbout: 00
# time 10 tbin, tm, tn: 100::: td, tbout: 11 compare_td, compare_tbout: 00
# time 12 tbin, tm, tn: 101::: td, tbout: 01 compare_td, compare_tbout: 00
# time 14 tbin, tm, tn: 110::: td, tbout: 00 compare_td, compare_tbout: 00
# time 16 tbin, tm, tn: 111::: td, tbout: 11 compare_td, compare_tbout: 00


*/
