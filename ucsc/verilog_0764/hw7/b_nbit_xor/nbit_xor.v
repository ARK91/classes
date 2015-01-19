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

module nbit_xor_balanced(number, result);
    parameter N = 7;
    input [N-1:0] number;
    output result;

    wire [N:1] a;
    wire [N:1] b;
    wire [N:1] f;

    assign result = f[1];

    genvar i;
    generate
        // The N%2 term adds an extra gate for odd numbered N.
        for (i = 1; i < N + (N%2); i = i + 1)
        begin: genBalanced
            XOR2 theXOR2(a[i], b[i], f[i]);

            assign a[i] = (i >= (N+1)/2 ? number[(i - (N+1)/2)*2]  : f[i*2]);

            // wire any extra inputs to zero, which causes the XOR to pass
            // through the other input (acts as a buffer):
            assign b[i] = (i >= N? 0 :
                           (i >= (N+1)/2 ? number[(i - (N+1)/2)*2+1]: f[i*2+1]));
        end
    endgenerate
endmodule



module nbit_xor_unbalanced(number, result);
    parameter N = 4; // N must be at least 2
    input [N-1:0] number;
    output result;

    wire [N-1:0] f;
    wire [2*N:0] localInput;

    assign result = f[N-2];

    genvar i;
    generate
        for (i = 0; i < N - 1; i = i + 1)
        begin: genUnbalanced

            assign localInput[i*2]   = (i == 0 ? number[i] : f[i-1]);
            assign localInput[i*2+1] = number[i+1];

            XOR2 theXOR2(localInput[i*2], localInput[i*2+1], f[i]);
        end
    endgenerate

endmodule

module xorn_rtl(a, f);
    parameter N = 3; // N must be at least 2
    input [N-1:0] a;
    output f;

    assign f = ^a; // reduction xor
endmodule
