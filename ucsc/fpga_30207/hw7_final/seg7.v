// File: seg7.v
// John Hubbard, 22 Mar 2015
//
// This contains all routines that are deal with the 7-segment display;
// specifically, for the Digilent BASYS3 board. Both hex and ASCII input
// can be translated here, to 7-segment output.
//

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
                anode <= 4'b1000;
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

module hex2_7seg(in,out);
    input [3:0] in; /*3210 */
    output [6:0] out; /* abcdefg */
    reg [6:0] out;

    always @(*)
    begin
        case (in)
             /*3210*/ /*abcdefg */
             0:  out = 7'b0000001;
             1:  out = 7'b1001111;
             2:  out = 7'b0010010;
             3:  out = 7'b0000110;
             4:  out = 7'b1001100;
             5:  out = 7'b0100100;
             6:  out = 7'b0100000;
             7:  out = 7'b0001111;
             8:  out = 7'b0000000;
             9:  out = 7'b0000100;
             10: out = 7'b0001000;
             11: out = 7'b1100000;
             12: out = 7'b0110001;
             13: out = 7'b1000010;
             14: out = 7'b0110000;
             15: out = 7'b0111000;
             default: out = 7'bx;
         endcase
     end
endmodule

module ascii2_7seg(asciiIn, seg);
    parameter N = 8; // 8-bit ascii makes it easier to specify string arrays
    input  [N-1:0] asciiIn;    //3210
    output reg [6:0] seg; // abcdefg

    always @(*)
    begin
        case (asciiIn)
            39: seg = 7'b1011111; // '
            45: seg = 7'b1111110; // -

            48: seg = 7'b0000001; // 0
            49: seg = 7'b1001111; // 1
            50: seg = 7'b0010010; // 2
            51: seg = 7'b0000110; // 3
            52: seg = 7'b1001100; // 4
            53: seg = 7'b0100100; // 5
            54: seg = 7'b0100000; // 6
            55: seg = 7'b0001111; // 7
            56: seg = 7'b0000000; // 8
            57: seg = 7'b0000100; // 9

            61: seg = 7'b1110110; // =

                                  // Desired  Actual
                                  // -----    ------
            65: seg = 7'b0001000; //   A        A
            66: seg = 7'b1100000; //   B        b
            67: seg = 7'b0110001; //   C        C
            68: seg = 7'b1000010; //   D        d
            69: seg = 7'b0110000; //   E        E
            70: seg = 7'b0111000; //   F        F
            71: seg = 7'b0000100; //   G        9
            72: seg = 7'b1001000; //   H        H
            73: seg = 7'b1001111; //   I        l
            74: seg = 7'b1000011; //   J        J
            75: seg = 7'b1111111; //   K        blank/off
            76: seg = 7'b1110001; //   L        L
            77: seg = 7'b1111111; //   M        blank/off
            78: seg = 7'b1111111; //   N        blank/off
            79: seg = 7'b0000001; //   O        0
            80: seg = 7'b0011000; //   P        P
            81: seg = 7'b1111111; //   Q        blank/off
            82: seg = 7'b1111111; //   R        blank/off
            83: seg = 7'b0100100; //   S        S
            84: seg = 7'b1111111; //   T        blank/off
            85: seg = 7'b1100011; //   U        u
            86: seg = 7'b1111111; //   V        blank/off
            87: seg = 7'b1111111; //   W        blank/off
            88: seg = 7'b1111111; //   X        blank/off
            89: seg = 7'b1111111; //   Y        blank/off
            90: seg = 7'b1111111; //   Z        blank/off

            95: seg = 7'b1110111; //   _        _

             97: seg = 7'b0001000; //  a        A
             98: seg = 7'b1100000; //  b        b
             99: seg = 7'b1110010; //  c        c
            100: seg = 7'b1000010; //  d        d
            101: seg = 7'b0110000; //  e        E
            102: seg = 7'b0111000; //  f        F
            103: seg = 7'b0000100; //  g        9
            104: seg = 7'b1101000; //  h        h
            105: seg = 7'b1001111; //  i        l
            106: seg = 7'b1000011; //  j        J
            107: seg = 7'b1111111; //  k        blank/off
            108: seg = 7'b1001111; //  l        l
            109: seg = 7'b1111111; //  m        blank/off
            110: seg = 7'b1111111; //  n        blank/off
            111: seg = 7'b1100010; //  o        o
            112: seg = 7'b0011000; //  p        P
            113: seg = 7'b1111111; //  q        blank/off
            114: seg = 7'b1111111; //  r        blank/off
            115: seg = 7'b0100100; //  s        S
            116: seg = 7'b1111111; //  t        blank/off
            117: seg = 7'b1100011; //  u        u
            118: seg = 7'b1111111; //  v        blank/off
            119: seg = 7'b1111111; //  w        blank/off
            120: seg = 7'b1111111; //  x        blank/off
            121: seg = 7'b1111111; //  y        blank/off
            122: seg = 7'b1111111; //  z        blank/off

            default: seg = 7'b1111111; // Default: blank/off
         endcase
     end
endmodule

module bcd_digit_to_ascii(bcdIn, asciiOut);
    parameter N = 4; // 4-bit BCD
    input  [N-1:0] bcdIn;
    output reg [7:0] asciiOut;

    always @(*)
    begin
        case (bcdIn)
             0: asciiOut = 48;
             1: asciiOut = 49;
             2: asciiOut = 50;
             3: asciiOut = 51;
             4: asciiOut = 52;
             5: asciiOut = 53;
             6: asciiOut = 54;
             7: asciiOut = 55;
             8: asciiOut = 56;
             9: asciiOut = 57;
            default: asciiOut = 8'b00000000; // Make any bugs less random
         endcase
     end
endmodule

