// File: problem_2_5_7_subtract.v
// John Hubbard, 04 Oct 2014
// hw3 assignment

module problem_2_5_7_subtract(m, n, bin, d, bout);
    input m, n, bin;
    output d, bout;

    wire d, bout;

    assign d = (!bin & !m &  n) |
               (!bin &  m & !n) |
               ( bin & !m & !n) |
               ( bin &  m &  n);

    assign bout = (!bin & !m &  n) |
                  ( bin & !m & !n) |
                  ( bin & !m &  n) |
                  ( bin &  m &  n);
endmodule


