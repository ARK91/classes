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
    reg tm, tn, tbin;
    wire td, tbout;
    reg [3:0] vec;

    problem_2_5_7_subtract DUT(tm, tn, tbin, td, tbout);

    initial
    begin
        for (vec = 0; vec < 8; vec++)
        begin
            {tc12,td1,td2} = vec ;
            #1 $display("time %t ",$time,
                        "tm, tn, tbin: %b%b%b", tm, tn, tbin,
                        "::: td, tbout: %b%b", td, tbout);
        end
    end

endmodule

/* Results:

problem_2_5_7_subtract_tb test run:


*/
