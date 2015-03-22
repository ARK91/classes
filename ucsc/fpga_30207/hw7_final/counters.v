// counters.v
// John F. Hubbard, 22 Mar 2015
//
// Various counters that are used everywhere.
//

module simple_counter(clk, asyncReset, q);
    parameter N = 7;

    input clk,asyncReset;
    output reg [N-1:0] q;

    always @(posedge clk or posedge asyncReset)
        if (asyncReset == 1'b1)
            q <= 0;
        else
            q <= q + 1;
endmodule

module mod_counter(clk, asyncReset, q, done);
    parameter N = 7;
    parameter MAX = 127;

    input clk, asyncReset;
    output [N-1:0] q;
    output done;

    reg [N-1:0] q;
    reg done;

    always @(posedge clk or posedge asyncReset)
    begin
        if (asyncReset == 1'b1)
        begin
            q <= 0;
            done <= 0;
        end
        else if (q == MAX)
        begin
            q <= 0;
            done <= 1;
        end
        else
        begin
            q <= q + 1;
            done <= 0;
        end
    end
endmodule

