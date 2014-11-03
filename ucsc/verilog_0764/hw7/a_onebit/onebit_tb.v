// File: onebit_tb.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: Problem 4.4.6: detect when exactly
// one bit is set.

`timescale 1ns/1ns
module onebit_tb;
    parameter N = 2;
    reg [N-1:0] number_tb;
    wire result_tb;

    onebit #(N) DUT(number_tb, result_tb);

    always @(*)
    begin
        $monitor("number: 0x%x, result: %b", number_tb, result_tb);
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
//      number_tb = 8'b0;
//      #10 number_tb = 8'b00000001;
//      #10 number_tb = 8'b00001001;
//      #10 number_tb = 8'b00011001;
//      #10 number_tb = 8'b00010000;
//      #10 number_tb = 8'b10001001;
//      #10 number_tb = 8'b10000001;
//      #10 number_tb = 8'b10000000;
    end

    // 17-bit test pattern:
    initial
    begin
//      number_tb     = 17'b0;
//      #10 number_tb = 17'b00000001;
//      #10 number_tb = 17'b00001001;
//      #10 number_tb = 17'b00011001;
//      #10 number_tb = 17'b00010000;
//      #10 number_tb = 17'b10001001;
//      #10 number_tb = 17'b10000001;
//      #10 number_tb = 17'b10000000;
    end
endmodule

/* Sample test run:

*/
