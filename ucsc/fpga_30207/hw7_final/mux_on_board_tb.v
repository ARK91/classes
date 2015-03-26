// File: test_mux_on_board.v
//
// John F. Hubbard, 26 Mar 2015
//
// MODULE: test_mux_on_board
//
//     This module tests different MUX modules, using the BASYS3 board as the
//     test bench, as recommended in Jag's (instructor's) course outline for
//     UCSC 30207: Digital Design with FPGA.
//
// MODULE: mux_tb
//
//     This module tests different MUX modules, using Modelsim simulation.
//

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


