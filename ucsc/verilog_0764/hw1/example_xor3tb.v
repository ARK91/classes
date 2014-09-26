// File: example_xor3tb.v
// John Hubbard, 25 Sep 2014
// Book example to get ModelSim up and running

`timescale 1ns/1ns
module xor3tb;
    reg ta,tb,tc ;
    wire tf ;
    reg [3:0] vec ;

    xor3 U(ta,tb,tc,tf) ;

    initial
    begin
        for (vec = 0; vec < 8; vec = vec +1)
        begin
            {ta,tb,tc} = vec ;
            #1 $display("time %t ",$time,
                        "ta, tb, tc %b%b%b", ta,tb,tc,
                        ":::tf %b",tf) ;
        end
    end
endmodule
