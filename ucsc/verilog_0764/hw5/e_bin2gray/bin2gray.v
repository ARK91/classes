// File: bin2gray.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.3: Liquid dispenser MUX
//

// Structural Verilog version, as required by the problem statement:

module bin2gray(bin, gray);
    input [3:0]bin;
    output [3:0]gray;

    wire [5:0]x;
    wire [3:0]not_bin;

    not i0(not_bin[0], bin[0]);
    not i1(not_bin[1], bin[1]);
    not i2(not_bin[2], bin[2]);
    not i3(not_bin[3], bin[3]);

    // bit 0:
    and a0(x0,   bin[0], not_bin[1]);
    and a1(x1,   not_bin[0], bin[1]);
    or g0(gray[0], x0, x1);

    // bit 1:
    and a2(x2,   bin[1], not_bin[2]);
    and a3(x3,   not_bin[1], bin[2]);
    or g1(gray[1], x2, x3);

    // bit 2:
    and a4(x4,   bin[2], not_bin[3]);
    and a5(x5,   not_bin[2], bin[3]);
    or g2(gray[2], x4, x5);

    // bit 3:
    buf g3(gray[3], bin[3]);
endmodule

