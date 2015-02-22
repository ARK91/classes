// File: counter.v
// Modified by John Hubbard, 31 Jan 2015

module counter_with_enable(clk, arst, en, q);
    parameter N = 7;
    input clk, arst, en;
    output reg [N-1:0] q;

    always @(posedge clk or posedge arst)
    if (arst == 1'b1)
        q <= 0;
    else if (en)
        q <= q + 1;
endmodule

module mod_counter(clk, arst, q, done);
    parameter N = 7;
    parameter MAX = 127;
    input clk, arst;
    output [N-1:0] q;
    output done;

    reg [N-1:0] q;
    reg done;

    always @(posedge clk or posedge arst)
    begin
        if (arst == 1'b1)
        begin
            q <= 0 ;
            done <= 0 ;
        end
        else if (q == MAX)
        begin
            q <= 0 ;
            done <= 1 ;
        end
        else
        begin
            q <= q + 1 ;
            done <= 0 ;
        end
    end
endmodule

