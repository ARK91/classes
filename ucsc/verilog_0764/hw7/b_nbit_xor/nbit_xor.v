// File: nbit_xor.v
// John Hubbard, 02 Nov Oct 2014
// hw7 assignment for Verilog 0764 class: N-bit XOR: build an N-bit XOR module,
// using only XOR2
//

module XOR2(a, b, f);
    input a, b;
    output f;
    assign f = a ^ b;
endmodule

module nbit_xor_unbalanced(number, result);
    parameter N = 3; // N must be at least 2
    input [N-1:0] number;
    output result;

    wire [N-1:0] f;
    wire [2*N:0] tinyInput;

    assign result = f[N-2];

    genvar i;
    generate
        for (i = 0; i < N - 1; i = i + 1)
        begin: genOneBit

            assign tinyInput[i*2]   = (i == 0 ? number[i] : f[i-1]);
            assign tinyInput[i*2+1] = number[i+1];

            XOR2 theXOR2(tinyInput[i*2], tinyInput[i*2+1], f[i]);
        end
    endgenerate

endmodule

module xorn_rtl(a, f);
    parameter N = 3; // N must be at least 2
    input [N-1:0] a;
    output f;

    assign f = ^a; // reduction xor
endmodule
