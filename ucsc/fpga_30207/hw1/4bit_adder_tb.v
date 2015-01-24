// File: 4bit_adder_tb.v
// John Hubbard, 23 Jan 2015
// hw1 assignment for UCSC 30207: Digital Design with FPGA

// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/fpga_30207/hw1
// vlib work
// vlog -sv 4bit*.v
// vsim work.add4_tb.v
// add wave *
// run 10 ns
//

`timescale 1ns/1ns

module add4_tb();
    reg [3:0]a;
    reg [3:0]b;
    wire [4:0]sum;

    reg [3:0]a2;
    reg [3:0]b2;
    wire [4:0]sum2;

    reg [4:0]testSum;

    add4        X(a,  b,  sum);
    add4_struct Y(a2, b2, sum2);

    initial
    begin
        testSum = 0;
        a = 0;
        b = 0;

        for (a = 0; a < 16; a = a + 1)
            for (b = 0; b < 16; b = b + 1)
            begin
                #1 testSum = a + b;

                if (sum != testSum)
                    $display("ERROR: sum: %d != testSum: %d",
                             sum, testSum);
                if (sum2 != testSum)
                    $display("ERROR: sum2: %d != testSum: %d",
                             sum2, testSum);
            end
    end
endmodule

/*
Sample run:

vlog 4bit*.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module add4
# -- Compiling module add4_struct
# -- Compiling module add4_tb
#
# Top level modules:
#   add4_tb
vsim work.add4_tb
# vsim work.add4_tb
# Loading work.add4_tb
# Loading work.add4
# Loading work.add4_struct
run 300 ns

*/

