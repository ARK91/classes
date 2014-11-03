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
    parameter N = 2;
    input [N-1:0] number;
    output result;

    wire no_all_one_failures;
    wire [N-1:0] all_ones;
    wire [N-1:0] f;

    assign no_all_one_failures = ~|all_ones[N-1:0]; // reduction nor
    and xResult(result, no_all_one_failures, f[N-1]);

    tiny_onebit ONEBIT(number[0], number[1], all_ones[0], f[0]);

    genvar i;
    generate
        for (i = 1; i < N; i = i + 1)
        begin: genOneBit
            tiny_onebit genOneBit(f[i-1], number[i+1], all_ones[i], f[i]);
        end
    endgenerate

endmodule

