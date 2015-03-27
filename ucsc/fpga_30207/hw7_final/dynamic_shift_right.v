// File: dynamic_shift_right.v
//
// John F. Hubbard, 26 Mar 2015
//

`timescale 1ns/1ns

module shift_right(a, k, out);
    parameter K = 3;
    parameter N = 1 << K;
    input [N-1:0] a;
    input [K-1:0] k;
    output [N-1:0] out;

    assign out = a >>> k;
endmodule
