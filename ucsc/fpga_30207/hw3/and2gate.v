//file and2gate.v
module and2gate(a,b,f) ;
    input a,b ;
    output f ;
    assign f = a & b ;
endmodule

module a7_and2gate(sw,Led) ;
    input [7:6] sw;
    output [4:4] led ;
    and2gate U1(sw[7],sw[6],led[4]) ;
endmodule
