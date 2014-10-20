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
    reg [4:0]atb;
    wire ftb, reftb;
    integer count;

    major DUT(atb, ftb);
    major_reference DUT_REFERENCE(atb, reftb);

    initial
    begin
        $monitor("Time %t, a: %b%b%b%b%b, f: %b, reftb: %b",
                 $time, atb[4], atb[3], atb[2], atb[1], atb[0], ftb, reftb);
    end

    always @(*)
    begin
        if (ftb ^ reftb)
            $display("FAILURE:                   a: %b%b%b%b%b, f: %b, reftb: %b",
                 atb[4], atb[3], atb[2], atb[1], atb[0], ftb, reftb);
    end

    initial
    begin
        for (count = 0; count < 32; count++)
        begin
            {atb} = count;
            #10;
        end
    end
endmodule

/* Sample test run:

*/
