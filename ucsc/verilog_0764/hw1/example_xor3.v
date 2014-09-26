// File: xor3.v
// John Hubbard, 25 Sep 2014
// Book example to get ModelSim up and running

module xor3(a,b,c,f);
    input a,b,c ;
    output f ;
    assign f = a ^ b ^ c ;
endmodule
