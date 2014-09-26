// File: two_2_1_mux.v
// John Hubbard, 25 Sep 2014
// hw1 assignment

module two_2_1_mux(a,b,select,f);
    input a, b, select;
    output f;
    assign f = (select & a) | ((~select) & b);
endmodule
