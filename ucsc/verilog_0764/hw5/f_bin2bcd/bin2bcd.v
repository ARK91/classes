// File: bin2bcd.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.7: Binary to BCD converter
//

// Structural Verilog version, as required by the problem statement:

module shift_add3(in, result);
    input [3:0] in;
    output [3:0] result;
    reg [3:0] result;

    always@(*)
        case (in)
            4'b0000: result = 4'b0000;
            4'b0001: result = 4'b0001;
            4'b0011: result = 4'b0011;
            4'b0100: result = 4'b0100;

            4'b0000: result = 4'b0000;
            4'b0101: result = 4'b1000;
            4'b0110: result = 4'b1001;
            4'b0000: result = 4'b0000;

            4'b0111: result = 4'b1010;
            4'b1000: result = 4'b1011;
            4'b1001: result = 4'b0000;
            default: result = 4'b0000;
        endcase
endmodule


module bin2bcd(bin, bcdHundreds, bcdTens, bcdOnes);
    input [3:0]bin;
    output [3:0]bcdHundreds;
    output [3:0]bcdTens;
    output [3:0]bcdOnes;

    wire x0, x1, x2, x3, x4, x5;
    wire [3:0]not_bin;

    not i0(not_bin[0], bin[0]);
    not i1(not_bin[1], bin[1]);
    not i2(not_bin[2], bin[2]);
    not i3(not_bin[3], bin[3]);

    // bit 0:
    and a0(x0,   bin[0], not_bin[1]);
    and a1(x1,   not_bin[0], bin[1]);
    or g0(bcdOnes[0], x0, x1);

    // bit 1:
    and a2(x2,   bin[1], not_bin[2]);
    and a3(x3,   not_bin[1], bin[2]);
    or g1(bcdOnes[1], x2, x3);

    // bit 2:
    and a4(x4,   bin[2], not_bin[3]);
    and a5(x5,   not_bin[2], bin[3]);
    or g2(bcdOnes[2], x4, x5);

    // bit 3:
    buf g3(bcdOnes[3], bin[3]);
endmodule

