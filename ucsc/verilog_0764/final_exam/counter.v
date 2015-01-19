// File: problem_2_5_7_counter.v
// John Hubbard, 21 Nov 2014
// final_exam assignment

module final_exam_counter(clk, d, e, r, load, updown, count);
    parameter N = 3;
    input clk, e, r, load, updown;
    input [N-1:0] d;
    output wire [N-1:0]count;

    reg [N-1:0]ic; // "internal count"

    assign count = ic;

    always @(posedge clk or posedge r)
    begin
        if (r == 1)
            ic = 0;
        else if (load == 1)
            ic = d;
        else if (e == 1)
            ic = (updown == 0 ? (ic + 1) : (ic - 1));
    end
endmodule

module final_exam_odd_parity(clk, arst, x, f);
    parameter N = 3;
    input clk, arst;
    input wire [N-1:0]x;
    output f;

    reg f;

    always @(posedge clk or posedge arst)
    begin
        if (arst == 1)
            f = 0;
        else
            f = (x % 2 == 1);
    end
endmodule
