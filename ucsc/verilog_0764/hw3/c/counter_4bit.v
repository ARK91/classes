// File: counter_4bit.v
// John Hubbard, 04 Oct 2014
// hw3 assignment

`timescale 1ns/1ns
module d_flop(d, clk, q, qbar);
    input d, clk;
    output q, qbar;

    reg q, qbar;

    always @(posedge clk)
    begin
        q = d;
        qbar = !q;
    end
endmodule

module counter_4bit(clk, reset, d);
    input clk, reset;
    output d;

    wire clk, reset;
    reg [3:0] d;

    reg [3:0] priv_d;
    reg [3:0] priv_q;
    reg [3:0] priv_qbar;
    reg priv_clk;

    d_flop ff1(priv_d[0:0], priv_clk, priv_q[0:0], priv_qbar[0:0]);
    d_flop ff2(priv_d[1:1], priv_clk, priv_q[1:1], priv_qbar[1:1]);
    d_flop ff3(priv_d[2:2], priv_clk, priv_q[2:2], priv_qbar[2:2]);
    d_flop ff4(priv_d[3:3], priv_clk, priv_q[3:3], priv_qbar[3:3]);

    always @(posedge clk or reset)
    begin
        if (reset == 1)
        begin
            // asynch reset, no need to clock it in:
            priv_d = 0;

            // hold the clock low during reset:
            priv_clk = 1'b0;
        end
        else
        begin
            priv_d = priv_d + 4'h1;
            // clock in a new value:
            priv_clk = 1'b1;
            #5 priv_clk = 1'b0;
        end
    end

endmodule


