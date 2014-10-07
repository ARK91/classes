// File: problem_2_5_7_subtract.v
// John Hubbard, 04 Oct 2014
// hw3 assignment

module problem_2_5_7_subtract_dataflow(m, n, bin, d, bout);
    input m, n, bin;
    output d, bout;

    wire m, n, bin;
    reg d, bout;

    assign d = (!bin & !m &  n) |
               (!bin &  m & !n) |
               ( bin & !m & !n) |
               ( bin &  m &  n);

    assign bout = (!bin & !m &  n) |
                  ( bin & !m & !n) |
                  ( bin & !m &  n) |
                  ( bin &  m &  n);
endmodule

module problem_2_5_7_subtract_behavioral(m, n, bin, d, bout);
    input m, n, bin;
    output d, bout;

    wire m, n, bin;
    reg d, bout;

    always @(m or n or bin)
    begin
        d = (!bin & !m &  n) |
            (!bin &  m & !n) |
            ( bin & !m & !n) |
            ( bin &  m &  n);

        bout = (!bin & !m &  n) |
               ( bin & !m & !n) |
               ( bin & !m &  n) |
               ( bin &  m &  n);
    end
endmodule

