// File: onebit_tb.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: Problem 4.4.6: detect when exactly
// one bit is set.

`timescale 1ns/1ns
module onebit_tb;
    parameter N = 8;
    reg [N-1:0] number_tb;
    wire result_tb;

    onebit #(N) DUT(number_tb, result_tb);

    always @(*)
    begin
        $monitor("number: %b, result: %b", number_tb, result_tb);
    end

    // 2-bit test pattern:
    initial
    begin
//    number_tb     = 2'b00;
//    #10 number_tb = 2'b01;
//    #10 number_tb = 2'b10;
//    #10 number_tb = 2'b11;
    end

    // 3-bit test pattern:
    initial
    begin
//      number_tb     = 3'b000;
//      #10 number_tb = 3'b001;
//      #10 number_tb = 3'b010;
//      #10 number_tb = 3'b011;
//      #10 number_tb = 3'b100;
//      #10 number_tb = 3'b101;
//      #10 number_tb = 3'b110;
//      #10 number_tb = 3'b111;
    end

    // 8-bit test pattern:
    initial
    begin
        #10 $display("Succcess cases:");
        #10 number_tb = 8'b00000001;
        #10 number_tb = 8'b00000010;
        #10 number_tb = 8'b00000100;
        #10 number_tb = 8'b00001000;
        #10 number_tb = 8'b00010000;
        #10 number_tb = 8'b00100000;
        #10 number_tb = 8'b01000000;
        #10 number_tb = 8'b10000000;

        #10 $display("Failure cases:");
        #10 number_tb = 8'b00000000;
        #10 number_tb = 8'b00001001;
        #10 number_tb = 8'b00011001;
        #10 number_tb = 8'b10001001;
        #10 number_tb = 8'b10000001;
        #10 number_tb = 8'b11111111;
        #10 number_tb = 8'b11101111;
        #10 number_tb = 8'b01111111;
        #10 number_tb = 8'b11111110;
        #10 number_tb = 8'b01111110;
    end

endmodule

/* Sample test run:

vlog ../*.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module tiny_onebit
# -- Compiling module onebit
# -- Compiling module onebit_tb
#
# Top level modules:
#   onebit_tb
vsim work.onebit_tb
# vsim work.onebit_tb
# Loading work.onebit_tb
# Loading work.onebit
# Loading work.tiny_onebit
run 300ns
# Succcess cases:
# number: 00000001, result: 1
# number: 00000010, result: 1
# number: 00000100, result: 1
# number: 00001000, result: 1
# number: 00010000, result: 1
# number: 00100000, result: 1
# number: 01000000, result: 1
# number: 10000000, result: 1
# Failure cases:
# number: 00000000, result: 0
# number: 00001001, result: 0
# number: 00011001, result: 0
# number: 10001001, result: 0
# number: 10000001, result: 0
# number: 11111111, result: 0
# number: 11101111, result: 0
# number: 01111111, result: 0
# number: 11111110, result: 0
# number: 01111110, result: 0
*/
