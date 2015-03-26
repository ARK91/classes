// five_to_one_mux.v
// John F. Hubbard, 22 Mar 2015
//
// For final homework in UCSC 30207: Digital Design with FPGA
//

`timescale 1ns/1ns

module five_to_one_mux_using_case(a, b, c, d, e, s, f);
    input a, b, c, d, e; // a is MSB (most significant bit)
    input [3-1:0] s; // select line

    output reg f;

    always @(*) begin
        case (s)
            0: f <= a;
            1: f <= b;
            2: f <= c;
            3: f <= d;
            4: f <= e;
            default: f <= 1'bx;
        endcase
    end
endmodule

module five_to_one_mux_using_if(a, b, c, d, e, s, f);
    input a, b, c, d, e; // a is MSB (most significant bit)
    input [3-1:0] s; // select line

    output reg f;

    always @(*) begin
        if (s == 3'h0)
            f <= a;
        else if (s == 3'h1)
            f <= b;
        else if (s == 3'h2)
            f <= c;
        else if (s == 3'h3)
            f <= d;
        else if (s == 3'h4)
            f <= e;
        else
            f <= 1'bx;
    end
endmodule

module five_to_one_mux_using_lut4(a, b, c, d, e, s, f);
    input a, b, c, d, e; // a is MSB (most significant bit)
    input [3-1:0] s; // select line

    output f;

    wire f0, f1, f2;

    LUT4 #(16'hCACA) DUT0(f0, a, b,   s[0], 1'bx);
    LUT4 #(16'hCACA) DUT1(f1, c,  d,  s[0], 1'bx);
    LUT4 #(16'hCACA) DUT2(f2, f0, f1, s[1], 1'bx);
    MUXF5 DUT3(f,  f2, e,  s[2]);

endmodule

module five_to_one_mux_using_lut4_one_level_logic(a, b, c, d, e, s, f);
    input a, b, c, d, e; // a is MSB (most significant bit)
    input [3-1:0] s; // select line

    output f;

    wire f0, f1, f2;

    LUT4 #(16'hCACA) DUT0(f0, a, b,   s[0], 1'bx);
    LUT4 #(16'hCACA) DUT1(f1, c,  d,  s[0], 1'bx);
    MUXF5            DUT2(f2, f0, f1, s[1]);
    MUXF6            DUT3(f,  f2, e,  s[2]);

endmodule


