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

module mux_tb();
    parameter MAX_VEC = 32;
    integer vec;
    reg a, b, c, d, e;
    reg [3-1:0] s;
    reg [4-1:0] sLoop;
    wire f1, f2;

    five_to_one_mux_using_case DUT1(a, b, c, d, e, s, f1);
    five_to_one_mux_using_if   DUT2(a, b, c, d, e, s, f2);

    initial begin

        for (sLoop = 0; sLoop < 8; sLoop = sLoop + 1) begin
            s = sLoop[3:0];
            #1;

            $display("----- select (s): %b -----------", sLoop);

            for (vec = 0; vec < MAX_VEC; vec = vec + 1) begin
                {e,d,c,b,a} = vec;

                #1;
                if (f1 != f2) begin
                    $display("ERROR: f1 != f2 *******************************");
                    $display("ERROR case: ",
                             "{e,d,c,b,a}: %b, s: %b, f1: %b, f2: %b",
                             vec[5-1:0], s, f1, f2);
                end
//              else
//                  $display("{e,d,c,b,a}: %b, s: %b, f1: %b, f2: %b",
//                           vec[5-1:0], s, f1, f2);
            end
        end
    end

endmodule
