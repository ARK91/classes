// File: priority_circuit.v
// John Hubbard, 16 Feb 205
// For HW #4 assignment of FPGA class.

//
// Answers to problem 3.9.4
//
// This is called a priority circuit. That is because higher priority inputs
// override lower priority inputs.

module priority_structural(in, out);
    input [7:0]in;
    output [7:0] out;

    wire f1, f2;

    buf B1(out[7], in[7]);
    LUT4 #(16'h00F0) L6(out[6], 'bx,   'bx,   in[6], in[7]);
    LUT4 #(16'h000C) L5(out[5], 'bx,   in[5], in[6], in[7]);
    LUT4 #(16'h0002) L4(out[4], in[4], in[5], in[6], in[7]);

    LUT4 #(16'h0001) F1(f1, in[4], in[5], in[6], in[7]);
    LUT4 #(16'h0100) F2(f2, in[1], in[2], in[3], f1);

    LUT4 #(16'hF000) L3(out[3], 'bx,   'bx,   in[3], f1);
    LUT4 #(16'h0C00) L2(out[2], 'bx,   in[2], in[3], f1);
    LUT4 #(16'h0200) L1(out[1], in[1], in[2], in[3], f1);

    LUT4 #(16'hF000) L0(out[0], 'bx, 'bx,     in[0], f2);

endmodule

module priority_behavioral(in, out);
    input [7:0]in;
    output [7:0] out;

    reg [7:0]out;

    always @(*)
    begin
        if (in >= (1 << 7))
            out = 8'b10000000;
        else if (in >= (1 << 6))
            out = 8'b01000000;
        else if (in >= (1 << 5))
            out = 8'b00100000;
        else if (in >= (1 << 4))
            out = 8'b00010000;
        else if (in >= (1 << 3))
            out = 8'b00001000;
        else if (in >= (1 << 2))
            out = 8'b00000100;
        else if (in >= (1 << 1))
            out = 8'b00000010;
        else if (in >= (1 << 0))
            out = 8'b00000001;
        else
            out = 8'b00000000;
    end
endmodule


module priority_top_module(sw, led);
    input  [7:0] sw; /* 76543210 */
    output [7:0] led; /* 76543210 */

//  priority_behavioral PRIORITY(.in(sw), .out(led));
    priority_structural PRIORITY(.in(sw), .out(led));
endmodule

