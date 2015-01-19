// File: bin2gray_tb.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.5: Binary to Gray code
// converter.
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw5/e_bin2gray/modelsim
// vlib work
// vlog -sv ../bin2gray.v ../bin2gray_tb.v
// vsim work.bin2gray_tb
// run 400 ns
//

`timescale 1ns/1ns
module bin2gray_tb;
    reg [3:0]bin_tb;
    wire [3:0]gray_tb;
    integer count;

    bin2gray DUT(bin_tb, gray_tb);

    // This block prints whenever the inputs or outputs change:
    initial
    begin
        $monitor("Time %t: bin: %b%b%b%b gray: %b%b%b%b ",
                 $time, bin_tb[3], bin_tb[2], bin_tb[1], bin_tb[0],
                 gray_tb[3], gray_tb[2], gray_tb[1], gray_tb[0]);
    end

    // Test pattern: exhaustive inputs:
    initial
    begin
        for (count = 0; count < 16; count++)
        begin
            {bin_tb} = count[3:0];
            #10;
        end
    end
endmodule

/* Sample test run:
vlog ../*.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module bin2gray
# -- Compiling module bin2gray_tb
#
# Top level modules:
#   bin2gray_tb
vsim work.bin2gray_tb
# vsim work.bin2gray_tb
# Loading sv_std.std
# Loading work.bin2gray_tb
# Loading work.bin2gray
run 300 ns
# Time                    0: bin: 0000 gray: 0000
# Time                   10: bin: 0001 gray: 0001
# Time                   20: bin: 0010 gray: 0011
# Time                   30: bin: 0011 gray: 0010
# Time                   40: bin: 0100 gray: 0110
# Time                   50: bin: 0101 gray: 0111
# Time                   60: bin: 0110 gray: 0101
# Time                   70: bin: 0111 gray: 0100
# Time                   80: bin: 1000 gray: 1100
# Time                   90: bin: 1001 gray: 1101
# Time                  100: bin: 1010 gray: 1111
# Time                  110: bin: 1011 gray: 1110
# Time                  120: bin: 1100 gray: 1010
# Time                  130: bin: 1101 gray: 1011
# Time                  140: bin: 1110 gray: 1001
# Time                  150: bin: 1111 gray: 1000
*/
