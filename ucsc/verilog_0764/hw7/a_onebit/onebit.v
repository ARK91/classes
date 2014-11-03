// File: onebit.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: Problem 4.4.6: detect when exactly
// one bit is set.
//

module tiny_onebit(a, b, all_ones, f);
    input a, b;
    output f, all_ones;

    assign f = a ^ b;
    assign all_ones = a & b;
endmodule

module onebit(number, result);
    parameter N = 4;
    input [N-1:0] number;
    output result;

    wire no_all_one_failures;
    wire [N-1:0] all_ones;
    wire [N-1:0] f;
    wire [2*N:0] tinyInput;
    wire pre_result;

    // Handle N == 1 specially:
    assign result = (N == 1 ? number[0] : pre_result);
    assign all_ones[N-1] = 0;

    assign no_all_one_failures = ~|all_ones[N-1:0]; // reduction nor
    and xResult(pre_result, no_all_one_failures, f[N-2]);

    genvar i;
    generate
        for (i = 0; i < N - 1; i = i + 1)
        begin: genOneBit

            assign tinyInput[i*2]   = (i == 0 ? number[i] : f[i-1]);
            assign tinyInput[i*2+1] = number[i+1];

            tiny_onebit genOneBit(tinyInput[i*2], tinyInput[i*2+1],
                                  all_ones[i], f[i]);
        end
    endgenerate

endmodule

