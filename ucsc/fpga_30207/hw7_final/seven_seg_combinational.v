// File: seven_seg_combinational.v
// John Hubbard, 22 Mar 2015
//
// This contains all routines that are deal with the 7-segment display;
// specifically, for the Digilent BASYS3 board. Both hex and ASCII input
// can be translated here, to 7-segment output.
//

module packed_hex_to_hex_digit(fourHexDigits, select, anode, hexDigitOut);
    input [15:0] fourHexDigits;
    input [1:0] select;
    output reg [3:0] anode;
    output reg [3:0] hexDigitOut;

    always @(*)
    begin
        case (select)
            0: begin
                anode <= 4'b1110;
                hexDigitOut <= fourHexDigits[3:0];
            end
            1: begin
                anode <= 4'b1101;
                hexDigitOut <= fourHexDigits[7:4];
            end
            2: begin
                anode <= 4'b1011;
                hexDigitOut <= fourHexDigits[11:8];
            end
            3: begin
                anode <= 4'b0111;
                hexDigitOut <= fourHexDigits[15:12];
            end
            default:begin
                anode <= 4'b0111;
                hexDigitOut <= 8'h3d; // "=", for easier debugging
            end
        endcase
    end
endmodule

module packed_ascii_to_hex_digit(fourAsciiDigits, select, anode, asciiDigitOut);
    input [32-1:0] fourAsciiDigits;
    input [1:0] select;
    output reg [3:0] anode;
    output reg [8-1:0] asciiDigitOut;

    always @(*)
    begin
        case (select)
            0: begin
                anode <= 4'b1110;
                asciiDigitOut <= fourAsciiDigits[7:0];
            end
            1: begin
                anode <= 4'b1101;
                asciiDigitOut <= fourAsciiDigits[15:8];
            end
            2: begin
                anode <= 4'b1011;
                asciiDigitOut <= fourAsciiDigits[23:16];
            end
            3: begin
                anode <= 4'b0111;
                asciiDigitOut <= fourAsciiDigits[31:24];
            end
            default:begin
                anode <= 4'b1011;
                asciiDigitOut <= 8'h3d; // "=", for easier debugging
            end
        endcase
    end
endmodule

module hex2_7seg(in,out);
    input [3:0] in;     // 3210
    output [6:0] out;   // abcdefg
    reg [6:0] out;

    always @(*)
    begin
        case (in)
             // 3210     abcdefg
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

module ascii2_7seg(asciiIn, seg7digit);
    parameter N = 8; // 8-bit ascii makes it easier to specify string arrays
    input  [N-1:0] asciiIn;     // 3210
    output reg [6:0] seg7digit; // abcdefg

    always @(*)
    begin
        case (asciiIn)
            39: seg7digit = 7'b1011111; // '
            45: seg7digit = 7'b1111110; // -

            48: seg7digit = 7'b0000001; // 0
            49: seg7digit = 7'b1001111; // 1
            50: seg7digit = 7'b0010010; // 2
            51: seg7digit = 7'b0000110; // 3
            52: seg7digit = 7'b1001100; // 4
            53: seg7digit = 7'b0100100; // 5
            54: seg7digit = 7'b0100000; // 6
            55: seg7digit = 7'b0001111; // 7
            56: seg7digit = 7'b0000000; // 8
            57: seg7digit = 7'b0000100; // 9

            61: seg7digit = 7'b1110110; // =

                                  // Desired  Actual
                                  // -----    ------
            65: seg7digit = 7'b0001000; //   A        A
            66: seg7digit = 7'b1100000; //   B        b
            67: seg7digit = 7'b0110001; //   COUNTER_BITS        COUNTER_BITS
            68: seg7digit = 7'b1000010; //   D        d
            69: seg7digit = 7'b0110000; //   E        E
            70: seg7digit = 7'b0111000; //   F        F
            71: seg7digit = 7'b0000100; //   G        9
            72: seg7digit = 7'b1001000; //   H        H
            73: seg7digit = 7'b1001111; //   I        l
            74: seg7digit = 7'b1000011; //   J        J
            75: seg7digit = 7'b1111111; //   K        blank/off
            76: seg7digit = 7'b1110001; //   L        L
            77: seg7digit = 7'b1111111; //   M        blank/off
            78: seg7digit = 7'b1111111; //   N        blank/off
            79: seg7digit = 7'b0000001; //   O        0
            80: seg7digit = 7'b0011000; //   P        P
            81: seg7digit = 7'b1111111; //   Q        blank/off
            82: seg7digit = 7'b1111111; //   R        blank/off
            83: seg7digit = 7'b0100100; //   S        S
            84: seg7digit = 7'b1111111; //   T        blank/off
            85: seg7digit = 7'b1100011; //   U        u
            86: seg7digit = 7'b1111111; //   V        blank/off
            87: seg7digit = 7'b1111111; //   W        blank/off
            88: seg7digit = 7'b1111111; //   X        blank/off
            89: seg7digit = 7'b1111111; //   Y        blank/off
            90: seg7digit = 7'b1111111; //   Z        blank/off

            95: seg7digit = 7'b1110111; //   _        _

             97: seg7digit = 7'b0001000; //  a        A
             98: seg7digit = 7'b1100000; //  b        b
             99: seg7digit = 7'b1110010; //  c        c
            100: seg7digit = 7'b1000010; //  d        d
            101: seg7digit = 7'b0110000; //  e        E
            102: seg7digit = 7'b0111000; //  f        F
            103: seg7digit = 7'b0000100; //  g        9
            104: seg7digit = 7'b1101000; //  h        h
            105: seg7digit = 7'b1001111; //  i        l
            106: seg7digit = 7'b1000011; //  j        J
            107: seg7digit = 7'b1111111; //  k        blank/off
            108: seg7digit = 7'b1001111; //  l        l
            109: seg7digit = 7'b1111111; //  m        blank/off
            110: seg7digit = 7'b1111111; //  n        blank/off
            111: seg7digit = 7'b1100010; //  o        o
            112: seg7digit = 7'b0011000; //  p        P
            113: seg7digit = 7'b1111111; //  q        blank/off
            114: seg7digit = 7'b1111111; //  r        blank/off
            115: seg7digit = 7'b0100100; //  s        S
            116: seg7digit = 7'b1111111; //  t        blank/off
            117: seg7digit = 7'b1100011; //  u        u
            118: seg7digit = 7'b1111111; //  v        blank/off
            119: seg7digit = 7'b1111111; //  w        blank/off
            120: seg7digit = 7'b1111111; //  x        blank/off
            121: seg7digit = 7'b1111111; //  y        blank/off
            122: seg7digit = 7'b1111111; //  z        blank/off

            default: seg7digit = 7'b1111111; // Default: blank/off
         endcase
     end
endmodule

