// File: priority_circuit.v
// John Hubbard, 16 Feb 205
// For HW #4 assignment of FPGA class.

module priority(in, out);
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

    priority PRIORITY(.in(sw), .out(led));
endmodule

