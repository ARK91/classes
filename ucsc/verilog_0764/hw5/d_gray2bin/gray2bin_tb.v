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
                 $time, gray_tb[3], gray_tb[2], gray_tb[1], gray_tb[0],
                 bin_tb[3], bin_tb[2], bin_tb[1], bin_tb[0]);
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
vlog ../*.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module gray2bin
# -- Compiling module gray2bin_tb
#
# Top level modules:
#   gray2bin_tb
vsim work.gray2bin_tb
# vsim work.gray2bin_tb
# Loading sv_std.std
# Loading work.gray2bin_tb
# Loading work.gray2bin
run 400 ns
# Time                    0: gray: 0000 bin: 0000
# Time                   10: gray: 0001 bin: 0001
# Time                   20: gray: 0010 bin: 0011
# Time                   30: gray: 0011 bin: 0010
# Time                   40: gray: 0100 bin: 0111
# Time                   50: gray: 0101 bin: 0110
# Time                   60: gray: 0110 bin: 0100
# Time                   70: gray: 0111 bin: 0101
# Time                   80: gray: 1000 bin: 1111
# Time                   90: gray: 1001 bin: 1110
# Time                  100: gray: 1010 bin: 1100
# Time                  110: gray: 1011 bin: 1101
# Time                  120: gray: 1100 bin: 1000
# Time                  130: gray: 1101 bin: 1001
# Time                  140: gray: 1110 bin: 1011
# Time                  150: gray: 1111 bin: 1010

*/
