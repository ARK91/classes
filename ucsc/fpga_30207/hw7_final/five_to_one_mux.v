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

module mux_tb();
    parameter MAX_VEC = 32;
    integer vec;
    reg a, b, c, d, e;
    reg [3-1:0] s;
    reg [3-1:0] sLoop;
    wire f;

    five_to_one_mux_using_case DUT(a, b, c, d, e, s, f);

    initial begin

        for (sLoop = 0; sLoop < 9; sLoop = sLoop + 1) begin
            s = sLoop[3:0];
            #1;
            $display("----- sLoop: %b -----------", sLoop);

            for (vec = 0; vec < MAX_VEC; vec = vec + 1) begin
                {e,d,c,b,a} = vec;

                #1;
                $display("{e,d,c,b,a}: %b, s: %b, f: %b", vec[5-1:0], s, f);
            end
        end
    end

endmodule

