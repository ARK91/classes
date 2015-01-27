// File: lutmask8000_tb.v
// John Hubbard, 26 Jan 2015
// hw2 assignment for UCSC 30207: Digital Design with FPGA
//
// Part 1: show that lutmask 8000 implements a 4-input AND gate.

// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/fpga_30207/hw2/a
// vlib work
// vlog *.v
// vsim work.lutmask_test
// add wave *
// run 100 ns
//

`timescale 1ns/1ns

module lutmask_test();
    reg a, b, c, d;
    reg [4:0] vec;
    wire lutmask_result, myAnd4_result, f_compare;

    lutmask8000 X(lutmask_result, a, b, c, d);
    myAnd4      Y(myAnd4_result, a, b, c, d);
    comparison  Z(f_compare, a, b, c, d);

    initial
    begin
        {a,b,c,d} = 4'b0;
        $display("abcd | lut4 | and4 | comparison");

        for (vec = 0; vec < 16; vec = vec + 1)
        begin
            #1 {a,b,c,d} = vec;

            #1 $display("%b%b%b%b | %b    | %b   |    %b", a, b, c, d,
                        lutmask_result, myAnd4_result, f_compare);

            if (f_compare)
                $display("Error: miscompare between lutmask8000 and myAnd4!");
        end
    end

endmodule

/* Sample run:

# run 1000ns
abcd | lut4 | and4 | comparison
0000 | 0    | 0   |    0
0001 | 0    | 0   |    0
0010 | 0    | 0   |    0
0011 | 0    | 0   |    0
0100 | 0    | 0   |    0
0101 | 0    | 0   |    0
0110 | 0    | 0   |    0
0111 | 0    | 0   |    0
1000 | 0    | 0   |    0
1001 | 0    | 0   |    0
1010 | 0    | 0   |    0
1011 | 0    | 0   |    0
1100 | 0    | 0   |    0
1101 | 0    | 0   |    0
1110 | 0    | 0   |    0
1111 | 1    | 1   |    0

*/
