// File: onebit.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: Problem 4.4.6: detect when exactly
// one bit is set.
//

`timescale 1ns/1ns
module onebit(number, result);
    parameter N = 2;
    input [N-1:0] number;
    output  result;

    assign result = 1;

    always @(*)
    begin
        //x
    end

endmodule

