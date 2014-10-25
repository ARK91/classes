// File: gray2bin_tb.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.4: Gray code to
// binary converter
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw5/d_gray2bin/modelsim
// vlib work
// vlog -sv ../gray2bin.v ../gray2bin_tb.v
// vsim work.gray2bin_tb
// run 400 ns
//

`timescale 1ns/1ns
module gray2bin_tb;
    reg [3:0]gray_tb;
    wire [3:0]bin_tb;
    integer count, bev;

    gray2bin DUT(gray_tb, bin_tb);

    // This block prints whenever the inputs or outputs change:
    initial
    begin
        $monitor("Time %t: gray: %b%b%b%b bin: %b%b%b%b",
                 gray_tb[3:0], bin_tb[3:0]);
    end

    // Test pattern: exhaustive inputs:
    initial
    begin
        for (count = 0; count < 16; count++)
        begin
            {gray_tb} = count[3:0];
            #10;
        end
    end
endmodule

/* Sample test run:
*/
