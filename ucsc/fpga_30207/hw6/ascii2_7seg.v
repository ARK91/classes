// file ascii2_7seg.v
// John Hubbard, 08 Mar 2015

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
