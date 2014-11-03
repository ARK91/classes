// File: nbit_xor_tb.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: N-bit XOR

`timescale 1ns/1ns
module nbit_xor_tb;
    parameter N = 2;
    reg [N-1:0] number_tb;
    wire result_tb;

    nbit_xor #(N) DUT(number_tb, result_tb);

    always @(*)
    begin
        $monitor("number: %b, result: %b", number_tb, result_tb);
    end

    // 2-bit test pattern:
    initial
    begin
        number_tb     = 2'b00;
        #10 number_tb = 2'b01;
        #10 number_tb = 2'b10;
        #10 number_tb = 2'b11;
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
//      #10 $display("Test cases:");
//      #10 number_tb = 8'b00000001;
//      #10 number_tb = 8'b00000010;
//      #10 number_tb = 8'b00000100;
//      #10 number_tb = 8'b00001000;
//      #10 number_tb = 8'b00010000;
//      #10 number_tb = 8'b00100000;
//      #10 number_tb = 8'b01000000;
//      #10 number_tb = 8'b10000000;
//
//      #10 number_tb = 8'b00000000;
//      #10 number_tb = 8'b00001001;
//      #10 number_tb = 8'b00011001;
//      #10 number_tb = 8'b10001001;
//      #10 number_tb = 8'b10000001;
//      #10 number_tb = 8'b11111111;
//      #10 number_tb = 8'b11101111;
//      #10 number_tb = 8'b01111111;
//      #10 number_tb = 8'b11111110;
//      #10 number_tb = 8'b01111110;
    end

endmodule

/* Sample test run:


*/
