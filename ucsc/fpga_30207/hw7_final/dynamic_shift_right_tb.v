// File: dynamic_shift_right_tb.v
//
// John F. Hubbard, 26 Mar 2015
//

`timescale 1ns/1ns

module shift_right_tb(sw, led);
    parameter K = 3;
    parameter N = 1 << K;

    wire [N-1:0] a;
    input [15:0] sw;
    output[15:0] led;

    wire [N-1:0] result;
    wire [2:0] k;

    shift_right #(K) DUT(a, k, result);

    assign led = result;
    assign a = sw[N-1:0];

    // Use the upper 3 switches to control the shift:
    assign k = sw[15-:3];
endmodule

