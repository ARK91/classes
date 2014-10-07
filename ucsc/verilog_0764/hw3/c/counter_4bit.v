// File: counter_4bit.v
// John Hubbard, 04 Oct 2014
// hw3 assignment

`timescale 1ns/1ns
module d_flop(d, clk, q, qbar);
    input d, clk;
    output q, qbar;

    reg q, qbar;
    wire d, clk;

    always @(posedge clk)
    begin
        q = d;
        qbar = !q;
    end
endmodule

module counter_4bit(clk, reset, count);
    input clk, reset;
    output [3:0] count;

    wire [3:0] d_in;
    wire [3:0] d_in_and_not_reset;
    wire [3:0] count;
    wire [3:0] count_qbar;
    wire d2_d1bar;
    wire d2_d0bar;
    wire d2bar_d1_d0;
    wire d3_d2bar;
    wire d3_d1bar;
    wire d3_d0bar;
    wire d3bar_d2_d1_d0;
    wire not_reset;

    d_flop d0(d_in_and_not_reset[0], clk, count[0], count_qbar[0]);
    d_flop d1(d_in_and_not_reset[1], clk, count[1], count_qbar[1]);
    d_flop d2(d_in_and_not_reset[2], clk, count[2], count_qbar[2]);
    d_flop d3(d_in_and_not_reset[3], clk, count[3], count_qbar[3]);

    xor bit1_next(d_in[1], count[0], count[1]);

    and bit2_and0(d2_d1bar, count[2], count_qbar[1]);
    and bit2_and1(d2_d0bar, count[2], count_qbar[0]);
    and bit2_and2(d2bar_d1_d0, count_qbar[2], count[1], count[0]);
    or  bit2_or1(d_in[2], d2_d1bar, d2_d0bar, d2bar_d1_d0);

    and bit3_and0(d3_d2bar, count[3], count_qbar[2]);
    and bit3_and1(d3_d1bar, count[3], count_qbar[1]);
    and bit3_and2(d3_d0bar, count[3], count_qbar[0]);
    and bit3_and4(d3bar_d2_d1_d0, count_qbar[3], count[2], count[1], count[0]);
    or bit3_or1(d_in[3], d3_d2bar, d3_d1bar, d3_d0bar, d3bar_d2_d1_d0);

    not reset_inv(not_reset, reset);
    and f0(d_in_and_not_reset[0], not_reset, count_qbar[0]);
    and f1(d_in_and_not_reset[1], not_reset, d_in[1]);
    and f2(d_in_and_not_reset[2], not_reset, d_in[2]);
    and f3(d_in_and_not_reset[3], not_reset, d_in[3]);
endmodule


