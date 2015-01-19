// File: gray2bin.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.4: Gray code to
// binary converter
//

// Structural Verilog version, as required by the problem statement:

module gray2bin(gray, bin);
    input [3:0]gray;
    output [3:0]bin;

    wire [12:0]x;
    wire [3:0]not_gray;

    not i0(not_gray[0], gray[0]);
    not i1(not_gray[1], gray[1]);
    not i2(not_gray[2], gray[2]);
    not i3(not_gray[3], gray[3]);

    // bit 0:
    and a0(x0,   not_gray[0], not_gray[1], not_gray[2], gray[3]);
    and a1(x1,   not_gray[0], not_gray[1], gray[2], not_gray[3]);
    and a2(x2,   not_gray[0], gray[1], not_gray[2], not_gray[3]);
    and a3(x3,   not_gray[0], gray[1], gray[2], gray[3]);

    and a4(x4,   gray[0], gray[1], not_gray[2], gray[3]);
    and a5(x5,   gray[0], gray[1], gray[2], not_gray[3]);
    and a6(x6,   gray[0], not_gray[1], not_gray[2], not_gray[3]);
    and a7(x7,   gray[0], not_gray[1], gray[2], gray[3]);
    or b0(bin[0], x0, x1, x2, x3, x4, x5, x6, x7);

    // bit 1:
    and a8(x8,   gray[1], not_gray[2], not_gray[3]);
    and a9(x9,   not_gray[1], gray[2], not_gray[3]);
    and a10(x10, gray[1], gray[2], gray[3]);
    and a11(x11, not_gray[1], not_gray[2], gray[3]);
    or b1(bin[1], x8, x9, x10, x11);

    // bit 2:
    and a12(x12, not_gray[3], gray[2]);
    and a13(x13, gray[3], not_gray[2]);
    or b2(bin[2], x12, x13);

    // bit 3:
    buf b3(bin[3], gray[3]);

 endmodule

