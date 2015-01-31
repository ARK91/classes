// File: various_lut4_tb.v
// John Hubbard, 26 Jan 2015
// hw2 assignment for UCSC 30207: Digital Design with FPGA
//
// Problem 2.6.1, part 2: implement a 4-input XOR gate using a LUT4.
// Problem 2.6.1, part 3: Implement the function below using a LUT4:
//

`timescale 1ns/1ns

module various_luttests();
    reg a, b, c, d;
    reg [4:0] vec;
    wire xor_via_lut_result, myXor4_result, f_compare, special_result;

    xor_via_lut X(xor_via_lut_result, a, b, c, d);
    myXor4      Y(myXor4_result, a, b, c, d);
    comparison  Z(f_compare, a, b, c, d);
    special_function_via_lut  AA(special_result, a, b, c, d);

    initial
    begin
        {a,b,c,d} = 4'b0;
        $display("abcd | lut4 | xor4 | comparison | special_result");

        for (vec = 0; vec < 16; vec = vec + 1)
        begin
            #1 {a,b,c,d} = vec;

            #1 $display("%b%b%b%b | %b    | %b   |    %b | %b", a, b, c, d,
                        xor_via_lut_result, myXor4_result, f_compare, special_result);

            if (f_compare)
                $display("Error: miscompare between xor_via_lut and myXor4!");
        end
    end

endmodule

/* Sample run in Vivado's simulator (ModelSim cannot support LUT4):

# run 1000ns
abcd | lut4 | xor4 | comparison | special_result
0000 | 0    | 0   |    0 | 1
0001 | 1    | 1   |    0 | 1
0010 | 1    | 1   |    0 | 1
0011 | 0    | 0   |    0 | 1
0100 | 1    | 1   |    0 | 1
0101 | 0    | 0   |    0 | 1
0110 | 0    | 0   |    0 | 1
0111 | 1    | 1   |    0 | 1
1000 | 1    | 1   |    0 | 1
1001 | 0    | 0   |    0 | 1
1010 | 0    | 0   |    0 | 1
1011 | 1    | 1   |    0 | 1
1100 | 0    | 0   |    0 | 1
1101 | 1    | 1   |    0 | 1
1110 | 1    | 1   |    0 | 1
1111 | 0    | 0   |    0 | 1
*/
