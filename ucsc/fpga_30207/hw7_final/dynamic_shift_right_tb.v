// File: dynamic_shift_right_tb.v
//
// John F. Hubbard, 26 Mar 2015
//

`timescale 1ns/1ns

// BASYS3 board testing:
module shift_right_test_on_board(sw, led);
    parameter K = 3;
    parameter N = 1 << K;

    wire [N-1:0] a;
    input [15:0] sw;
    output[15:0] led;

    wire [N-1:0] result;
    wire [2:0] k;

    shift_right_behavior #(K) DUT(a, k, result);

    assign led = result;
    assign a = sw[N-1:0];

    // Use the upper 3 switches to control the shift:
    assign k = sw[15-:3];
endmodule

// Modelsim testing:
module shift_right_tb();
    parameter K = 3;
    parameter N = 1 << K;

    // DUT inputs:
    reg [N-1:0] a;
    reg [K-1:0] k;

    // DUT output:
    wire [N-1:0] result;

    shift_right_artix7_structural #(K) DUT(a, k, result);

    initial begin
        for (k = 0; k < 4; k = k + 1) begin
            for (a = 0; a < 20; a = a + 1) begin
                #1;
                $display("k (amount to shift): %d, a (input):  %h, result: %h",
                         k, a, result);
            end
        end
    end
endmodule

