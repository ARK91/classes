// File: problem_2_5_7_counter_tb.v
// John Hubbard, 21 Nov 2014
// final_exam assignment

`timescale 1ns/1ns
module final_exam_counter_tb;
    parameter N = 3;
    reg clk, d, e, r, load, updown;
    reg [N-1:0]count;

    final_exam_counter DUT(clk, d, e, r, load, updown, count);

    always @(*)
        #1 $display("time %t ",$time,
                    "count: %b", count);

    initial
    begin
        r = 1;
        #10 r = 0; // start counting
    end

endmodule

/* Results:


*/
