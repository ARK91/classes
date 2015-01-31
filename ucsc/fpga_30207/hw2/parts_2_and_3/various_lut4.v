// File: various_lut4.v
// John Hubbard, 26 Jan 2015
// hw2 assignment for UCSC 30207: Digital Design with FPGA
//
// Problem 2.6.1, part 2: implement a 4-input XOR gate using a LUT4.
// Problem 2.6.1, part 3: Implement the function below using a LUT4:

`timescale 1ns/1ns

module comparison(f, a, b, c, d);
    input a, b, c, d;
    output f;
    wire a, b, c, d, x, y, f;

    xor_via_lut U_lut(x, a, b, c, d);
    myXor4      V_xor(y, a, b, c, d);

    assign f = x ^ y; // compare the results
endmodule

module xor_via_lut(f, a, b, c, d);
    input a, b, c, d;
    output f;

    // Problem 2.6.1, part 2: implement a 4-input XOR gate using a LUT4.
    //
    // Please see my paper notes for how the 0x6996 was derived:
    LUT4 #(16'h6996) U(f, a, b, c, d);
endmodule

module special_function_via_lut(f, a, b, c, d);
    input a, b, c, d;
    output f;

    // Problem 2.6.1, part 3: Implement the function below using a LUT4:
    //
    // f = a.b.c.d + a'.b'.c'.d' + a. d' + a'.b.c' +
    //     b'.d + a'.b.c' + a.b.c'.d + b.c.d + a'.c.d'

    // Please see my paper notes for how the 0xffff was derived:
    LUT4 #(16'hffff) U(f, a, b, c, d);
endmodule

module myXor4(f, a, b, c, d);
    input a, b, c, d;
    output f;

    assign f = a ^ b ^ c ^ d;
endmodule

