// File: major_tb.v
// John Hubbard, 18 Oct 2014
// hw5a assignment for Verilog 0764 class: Problem 4.4.1: Majority Circuit
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw5/modelsim
// vlib work
// vlog -sv ../major.v ../major_tb.v
// vsim work.major_tb
// run 100 ns
//

`timescale 1ns/1ns
module major_tb;
    reg a4tb, a3tb, a2tb, a1tb, a0tb;
    wire ftb;
    integer count;

    major DUT(a4tb, a3tb, a2tb, a1tb, a0tb, ftb);

    initial
    begin
        $monitor("Time %t, a4tb:a4tb:a4tb:a4tb:a4tb: f ::: ",
                 $time, a4tb, a3tb, a2tb, a1tb, a0tb, ftb);
    end

    initial
    begin
        for (count = 0; count < 32; count++)
        begin
            #10 (a4tb, a3tb, a2tb, a1tb, a0tb) = count;
        end
    end
endmodule

/* Sample test run:

*/
