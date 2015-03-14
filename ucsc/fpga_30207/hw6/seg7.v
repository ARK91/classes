// File: display.v
// John Hubbard, 16 Feb 2015

module simple_counter(clk, arst,q);
    parameter N = 7;
    input clk,arst;
    output reg [N-1:0] q;

    always @(posedge clk or posedge arst)
        if (arst == 1'b1)
            q <= 0;
        else
            q <= q + 1;
endmodule

module packed_hex_to_hex_digit(packedHex, select, anode, hexDigitOut);
    input [15:0] packedHex;
    input [1:0] select;
    output reg [3:0] anode;
    output reg [3:0] hexDigitOut;

    always @(*)
    begin
        case (select)
            0: begin
                anode <= 4'b1110;
                hexDigitOut <= packedHex[3:0];
            end
            1: begin
                anode <= 4'b1101;
                hexDigitOut <= packedHex[7:4];
            end
            2: begin
                anode <= 4'b1011;
                hexDigitOut <= packedHex[11:8];
            end
            3: begin
                anode <= 4'b0111;
                hexDigitOut <= packedHex[15:12];
            end
            default:begin
                anode <= 4'bx;
                hexDigitOut <= 4'bx;
            end
        endcase
    end
endmodule

module packed_ascii_to_hex_digit(packedAscii, select, anode, asciiDigitOut);
    input [32-1:0] packedAscii;
    input [1:0] select;
    output reg [3:0] anode;
    output reg [8-1:0] asciiDigitOut;

    always @(*)
    begin
        case (select)
            0: begin
                anode <= 4'b1110;
                asciiDigitOut <= packedAscii[7:0];
            end
            1: begin
                anode <= 4'b1101;
                asciiDigitOut <= packedAscii[15:8];
            end
            2: begin
                anode <= 4'b1011;
                asciiDigitOut <= packedAscii[23:16];
            end
            3: begin
                anode <= 4'b0111;
                asciiDigitOut <= packedAscii[31:24];
            end
            default:begin
                anode <= 4'bx;
                asciiDigitOut <= 8'h3d; // "=", for easier debugging
            end
        endcase
    end
endmodule

module display_hex(text, clk, arst, seg, an);
    parameter C = 21;
    parameter N7 = 7;
    parameter N4 = 4;
    parameter N2 = 2;
    parameter ANODE_FREQ = 20; //20 = 47 HZ; 19 is 95 HZ 95-47 = 48HZ
    input [15:0] text;
    input clk, arst;
    output [0:N7-1] seg;
    output [N4-1:0] an;

    wire [C-1:0] q;
    wire [N2-1:0] sel;
    wire [N4-1:0] zero_to_f_counter;

    assign sel[1] = q[ANODE_FREQ];
    assign sel[0] = q[ANODE_FREQ-1];

    //assign sel[1] = q[15]; 23 hz
    //assign sel[0] = q[20]; 762 hz
    //Run with above number and see display
    simple_counter #C U(clk, arst, q);
    packed_hex_to_hex_digit D(text, sel, an, zero_to_f_counter);
    hex2_7seg H(zero_to_f_counter, seg);
endmodule

module display_hex_tb(clk, btnU, seg, an);
    parameter D = 'h8602;
    parameter N7 = 7;
    parameter N4 = 4;
    input clk, btnU;
    output [0:N7-1] seg;
    output [N4-1:0] an;

    wire [15:0] packedHex;
    assign packedHex = D;
    display_hex T(packedHex, clk, btnU, seg, an);
endmodule

module display_ascii(packedAscii, clk, arst, seg, an);
    parameter C = 21;
    parameter N7 = 7;
    parameter N4 = 4;
    parameter N2 = 2;
    parameter ANODE_FREQ = 20; //20 = 47 HZ; 19 is 95 HZ 95-47 = 48HZ
    input [32-1:0] packedAscii;
    input clk, arst;
    output [0:N7-1] seg;
    output [N4-1:0] an;

    wire [C-1:0] q;
    wire [N2-1:0] sel;
    wire [8-1:0] zero_to_127_counter; // only 0-127, even though 8-bit ascii

    assign sel[1] = q[ANODE_FREQ];
    assign sel[0] = q[ANODE_FREQ-1];

    //assign sel[1] = q[15]; 23 hz
    //assign sel[0] = q[20]; 762 hz
    //Run with above number and see display
    simple_counter #C U(clk, arst, q);
    packed_ascii_to_hex_digit D(packedAscii, sel, an, zero_to_127_counter);
    ascii2_7seg H(zero_to_127_counter, seg);
endmodule

module display_ascii_tb(clk, btnU, seg, an);
    parameter TO_DISPLAY = 32'h4a46482d; // "JFH-"
    parameter N7 = 7;
    parameter N4 = 4;
    input clk, btnU;
    output [0:N7-1] seg;
    output [N4-1:0] an;

    wire [32-1:0] packedAscii;
    assign packedAscii = TO_DISPLAY;
    display_ascii T(packedAscii, clk, btnU, seg, an);
endmodule

