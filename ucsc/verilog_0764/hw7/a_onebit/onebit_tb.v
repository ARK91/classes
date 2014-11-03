// File: onebit_tb.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: Problem 4.4.6: detect when exactly
// one bit is set.

`timescale 1ns/1ns
module onebit_tb;
    parameter N = 8;
    reg [N-1:0] number;
    wire result_tb;

    onebit (#8) DUT(number_tb, result_tb);

    always @(*)
    begin
        // xxx
    end

    always @(*)
    begin
        $monitor("number: 0x%x, result: %b", number_tb, result_tb);
    end

    // Test pattern:
    initial
    begin
        begin
            #10 number_tb = N'b0;
            #10 number_tb = N'b00000001;
            #10 number_tb = N'b00001001;
            #10 number_tb = N'b00001001;
            #10 number_tb = N'b10001001;
            #10 number_tb = N'b10000001;
            #10 number_tb = N'b10000000;
        end
    end
endmodule

/* Sample test run:

*/
