// File: two_2_1_mux.v
// John Hubbard, 25 Sep 2014
//
// This change is for Kelly.
// hw1 assignment

module two_2_1_mux(a,b,cselect,f);
    input a, b, c, select;
    output f;

    // New c variable for kelly
    assign f = (select & a) | ((~select) & b) | c;
endmodule
