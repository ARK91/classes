// File: nbit_xor_tb.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: N-bit XOR

`timescale 1ns/1ns
module nbit_xor_tb;
    parameter N = 8;
    reg [N-1:0] number_tb;
    wire bal_result_tb, unbal_result_tb, reference_result_tb;
    reg bal_match;
    reg unbal_match;

    nbit_xor_balanced   #(N) DUT_balanced(number_tb, bal_result_tb);
    nbit_xor_unbalanced #(N) DUT_unbalanced(number_tb, unbal_result_tb);
    xorn_rtl            #(N) DUT_REF(number_tb, reference_result_tb);


    initial
    begin
        $monitor("number: %b, bal_result_tb: %b, pass?: %b :::",
                 number_tb, bal_result_tb, bal_match,
                 "unbal_result_tb: %b, pass?: %b",
                 unbal_result_tb, unbal_match);
    end

    always @(*)
    begin
        // Formal equivalence checks:
        bal_match   = bal_result_tb ~^ reference_result_tb;
        unbal_match = unbal_result_tb ~^ reference_result_tb;
    end

    initial
    begin
    end

    // 2-bit test pattern:
    initial
    begin
//      number_tb     = 2'b00;
//      #10 number_tb = 2'b01;
//      #10 number_tb = 2'b10;
//      #10 number_tb = 2'b11;
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
        #10 $display("Test cases:");
        #10 number_tb = 8'b00000001;
        #10 number_tb = 8'b00000010;
        #10 number_tb = 8'b00000100;
        #10 number_tb = 8'b00001000;
        #10 number_tb = 8'b00010000;
        #10 number_tb = 8'b00100000;
        #10 number_tb = 8'b01000000;
        #10 number_tb = 8'b10000000;

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
# -- Compiling module XOR2
# -- Compiling module nbit_xor_balanced
# -- Compiling module nbit_xor_unbalanced
# -- Compiling module xorn_rtl
# -- Compiling module nbit_xor_tb
#
# Top level modules:
#   nbit_xor_tb
vsim nbit_xor_tb
# vsim nbit_xor_tb
# Loading work.nbit_xor_tb
# Loading work.nbit_xor_balanced
# Loading work.nbit_xor_unbalanced
# Loading work.xorn_rtl
# Loading work.XOR2
run 200 ns
# number: xxxxxxxx, bal_result_tb: x, pass?: x :::unbal_result_tb: x, pass?: x
# Test cases:
# number: 00000001, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 00000010, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 00000100, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 00001000, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 00010000, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 00100000, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 01000000, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 10000000, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 00000000, bal_result_tb: 0, pass?: 1 :::unbal_result_tb: 0, pass?: 1
# number: 00001001, bal_result_tb: 0, pass?: 1 :::unbal_result_tb: 0, pass?: 1
# number: 00011001, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 10001001, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 10000001, bal_result_tb: 0, pass?: 1 :::unbal_result_tb: 0, pass?: 1
# number: 11111111, bal_result_tb: 0, pass?: 1 :::unbal_result_tb: 0, pass?: 1
# number: 11101111, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 01111111, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 11111110, bal_result_tb: 1, pass?: 1 :::unbal_result_tb: 1, pass?: 1
# number: 01111110, bal_result_tb: 0, pass?: 1 :::unbal_result_tb: 0, pass?: 1



*/
