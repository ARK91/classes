// File: problem_2_5_5_latch_7475.v
// John Hubbard, 04 Oct 2014
// hw3 assignment

module problem_2_5_5_latch_7475(d1, d2, d3, d4, c12, c34,
                                q1, q2, q3, q4);
    input d1, d2, d3, d4, c12, c34;
    output q1, q2, q3, q4;

    wire d1, d2, d3, d4, c12, c34;
    reg q1, q2, q3, q4;

    always @(d1, d2, c12)
    begin
        if (c12 == 1)
        begin
            q1 = d1;
            q2 = d2;
        end
    end

    always @(d3, d4, c34)
    begin
        if (c34 == 1)
        begin
            q3 = d3;
            q4 = d4;
        end
    end
endmodule


