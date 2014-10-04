// File: problem_2_5_4_mux_74151.v
// John Hubbard, 03 Oct 2014
// hw2 assignment

module mux(f, a, b, select);
    input a, b, select;
    output f;
    assign f = (select & a) | ((~select) & b);
endmodule


module problem_2_5_4_mux_74151_structural(a, b, c, s, y, w,
                                          d0, d1, d2, d3, d4, d5, d6, d7);
    input a, b, c, s, d0, d1, d2, d3, d4, d5, d6, d7;
    output y, w;
    wire notA, notB, notC, notS;
    wire f[8];

    not h1(notA, a);
    not h2(notB, b);
    not h3(notC, c);
    not h4(notS, s);

    and f0(f[0], notS, d0, notC, notB, notA);
    and f1(f[1], notS, d1, notC, notB, a);
    and f2(f[2], notS, d2, notC, b, notA);
    and f3(f[3], notS, d3, notC, b, a);
    and f4(f[4], notS, d4, c, notB, notA);
    and f5(f[5], notS, d5, c, notB, a);
    and f6(f[6], notS, d6, c, b, notA);
    and f7(f[7], notS, d7, c, b, a);

    or y_out(y, f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7]);
    not w_out(w, y);

endmodule

module problem_2_5_4_mux_74151_dataflow(a, b, c, s, y, w,
                                          d0, d1, d2, d3, d4, d5, d6, d7);
    input a, b, c, s, d0, d1, d2, d3, d4, d5, d6, d7;
    output y, w;

    wire f[8];

    assign y = f[0] | f[1] | f[2] | f[3] | f[4] | f[5] | f[6] | f[7];
    assign w = ~y;
    assign f[0] = ~s & d0 & ~c & ~b & ~a;
    assign f[1] = ~s & d1 & ~c & ~b & a;
    assign f[2] = ~s & d2 & ~c & b & ~a;
    assign f[3] = ~s & d3 & ~c & b & a;
    assign f[4] = ~s & d4 & c & ~b & ~a;
    assign f[5] = ~s & d5 & c & ~b & a;
    assign f[6] = ~s & d6 & c & b & ~a;
    assign f[7] = ~s & d7 & c & b & a;
endmodule

