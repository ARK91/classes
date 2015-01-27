// File: lutmask8000.v
// John Hubbard, 26 Jan 2015
// hw2 assignment for UCSC 30207: Digital Design with FPGA
//
// Part 1: show that lutmask 8000 implements a 4-input AND gate.

`timescale 1ns/1ns

module comparison(f, a, b, c, d);
    input a, b, c, d;
    output f;
    wire a, b, c, d, x, y, f;

    lutmask8000 U_lut(x, a, b, c, d);
    myAnd4      V_and(y, a, b, c, d);

    // This should have caused Vivado to remove the entire circuit, but it
    // did not. I don't understand why not. Both the elaborated design and the
    // schematic for the synthesized design showed that the AND4 and LUT4 were
    // still there.
    // --John Hubbard

    assign f = x ^ y;
endmodule

module lutmask8000(f, a, b, c, d);
    input a, b, c, d;
    output f;

    LUT4 #(16'h8000) U(f, a, b, c, d);
endmodule

module myAnd4(f, a, b, c, d);
    input a, b, c, d;
    output f;

    assign f = a & b & c & d;
endmodule

