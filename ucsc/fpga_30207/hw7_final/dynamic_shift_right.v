// File: dynamic_shift_right.v
//
// John F. Hubbard, 26 Mar 2015
//

`timescale 1ns/1ns

module shift_right_behavior(a, k, out);
    parameter K = 3;
    parameter N = 1 << K;
    input [N-1:0] a;
    input [K-1:0] k;
    output [N-1:0] out;

    assign out = a >>> k;
endmodule

module shift_right_artix7_structural(a, k, out);
    parameter K = 3;
    parameter N = 1 << K;

    input [N-1:0] a;
    input [K-1:0] k;

    output [N-1:0] out;

    wire data, clk, enable, q, q31;

    // If high bit is set, then shift in ones on the left end, otherwise
    // shift in zeroes:
    assign data = a[N-1];

    // TODO: implement this using this primitive:
    SRLC32E SHIFTER(.D(data), .CLK(clk), .CE(enable), .Q(q), .Q31(q31), .A(a));

endmodule
