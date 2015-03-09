// File: collatz.v
// John Hubbard, 08 Mar 2015
//
// hw6: Problem 4.7.3: Implement the Collatz conjecture, for n = 27.
//

`timescale 1ns/1ns

module collatz(clk, reset, enableNext, startingN, f);
    input clk, enableNext, reset;
    output reg [31:0]f;
    input [31:0]startingN;

    always @(posedge clk)
    begin
        if (reset)
            f = startingN;
        else if (enableNext && f > 1)
        begin
            if (0 == (f % 2))
                f = f / 2;
            else
                f = 3*f + 1;
        end
    end

endmodule

module quick_test(clk, btnU, seg, an);
    wire [31:0]startingN;
    wire [31:0]f;
    wire [15:0]text;
    input clk, btnU;
    output [0:7-1] seg ;
    output [4-1:0] an ;
    wire [15:0] text;

    assign startingN = 'd27;

    collatz DUT(clk, btnU, done, startingN, f);
    binary2bcd BCD(f, text) ;

    display_at_n_second #(1.0) D (clk, btnU, seg, an, text, done);

endmodule
