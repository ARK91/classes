// display_7seg.v
// John F. Hubbard
//
// Various display modules, for a 4-digit, 7-segment display, on the Digilent
// BASYS3 board.
//
// Note: For the top level modules (that get instantiated on real hardware), one
// must use the exact names that are used in the constraints file. So,
// btnU, seq, an, led, clk, must all be exactly that.
//
module display_hex_top_module(clk, btnU, seg, an);
    parameter TO_DISPLAY = 'h8602;

    input clk, btnU;

    output [0:7-1] seg;
    output [4-1:0] an;

    wire [15:0] fourHexDigits;

    assign fourHexDigits = TO_DISPLAY;
    display_hex DISPLAY_HEX(fourHexDigits, clk, btnU, seg, an);
endmodule

module display_ascii_top_module(clk, btnU, seg, an);
    parameter TO_DISPLAY = 32'h4a46482d; // "JFH-"

    input clk, btnU;

    output [0:7-1] seg;
    output [4-1:0] an;

    wire [32-1:0] fourAsciiDigits;

    assign fourAsciiDigits = TO_DISPLAY;
    display_ascii DISPLAY_ASCII(fourAsciiDigits, clk, btnU, seg, an);
endmodule

// This module displays a 4-digit hex number, and toggles "done" after
// NUM_SEC seconds.
module display_packed_hex_for_n_seconds(clk, asyncReset, seg7digit, anode,
                                        fourHexDigits, done);
    parameter NUM_SEC = 1;
    parameter COUNTER_BITS = 35;
    parameter CRYSTAL = 100 * 1_000_000; // 100 MHZ
    parameter [COUNTER_BITS-1:0] CYCLE_LIMIT = (CRYSTAL * NUM_SEC)- 1;

    input clk, asyncReset;
    input [15:0] fourHexDigits;

    output [0:7-1] seg7digit;
    output [4-1:0] anode;
    output done;

    wire [COUNTER_BITS-1:0] clock;

    mod_counter #(COUNTER_BITS, CYCLE_LIMIT)
        DISPLAY_COUNTER(clk, asyncReset, clock, done);

    display_hex #(COUNTER_BITS) DISPLAY_HEX(fourHexDigits, clk, asyncReset,
                                            seg7digit, anode);
endmodule

// This module displays a 4-digit ASCII string, and toggles "done" after
// NUM_SEC seconds.
module display_ascii_string_for_n_seconds(clk, asyncReset, seg7digit, anode,
                                          asciiString, done);
    parameter NUM_SEC = 1;
    parameter COUNTER_BITS = 35;
    parameter CRYSTAL = 100 * 1_000_000; // 100 MHZ
    parameter [COUNTER_BITS-1:0] CYCLE_LIMIT = (CRYSTAL * NUM_SEC)- 1;

    parameter NDIGITS = 4;
    parameter ABITS = 8;    // ABITS means "number of bits per ASCII digit"
    parameter BUF_BITS = NDIGITS * ABITS;

    input clk, asyncReset;
    input [BUF_BITS-1:0] asciiString;

    output [0:7-1] seg7digit;
    output [4-1:0] anode;
    output done;

    wire [COUNTER_BITS-1:0] clock;

    mod_counter #(COUNTER_BITS, CYCLE_LIMIT)
        DISPLAY_COUNTER(clk, asyncReset, clock, done);

    display_ascii #(COUNTER_BITS) DISPLAY_ASCII(asciiString, clk, asyncReset,
                                                seg7digit, anode);
endmodule

module display_hex(fourHexDigits, clk, asyncReset, seg7digit, anode);
    parameter COUNTER_BITS = 21;
    parameter ANODE_FREQ = 20; //20 = 47 HZ; 19 is 95 HZ 95-47 = 48HZ

    input [15:0] fourHexDigits;
    input clk, asyncReset;

    output [0:7-1] seg7digit;
    output [4-1:0] anode;

    wire [COUNTER_BITS-1:0] anodeTick;
    wire [2-1:0] sel;
    wire [4-1:0] hexDigit;

    simple_counter #COUNTER_BITS ANODE_COUNTER(clk, asyncReset, anodeTick);
    assign sel[1] = anodeTick[ANODE_FREQ];
    assign sel[0] = anodeTick[ANODE_FREQ - 1];

    // Jag also recommends trying this, to see the effect on the display:
    // assign sel[1] = anodeTick[15]; 23 hz
    // assign sel[0] = anodeTick[20]; 762 hz

    packed_hex_to_hex_digit HEX_DIGIT_OUT(fourHexDigits, sel, anode, hexDigit);
    hex2_7seg HEX_TO_7SEG(hexDigit, seg7digit);
endmodule

module display_ascii(fourAsciiDigits, clk, asyncReset, seg7digit, anode);
    parameter COUNTER_BITS = 21;
    parameter ANODE_FREQ = 20; // 20 = 47 HZ, 19 is 95 HZ, 95-47 = 48HZ

    input [32-1:0] fourAsciiDigits;
    input clk, asyncReset;
    output [0:7-1] seg7digit;
    output [4-1:0] anode;

    wire [COUNTER_BITS-1:0] anodeTick;
    wire [2-1:0] sel;
    wire [8-1:0] asciiDigit;

    assign sel[1] = anodeTick[ANODE_FREQ];
    assign sel[0] = anodeTick[ANODE_FREQ-1];

    simple_counter #COUNTER_BITS ANODE_COUNTER(clk, asyncReset, anodeTick);
    packed_ascii_to_hex_digit STR2HEX(fourAsciiDigits, sel, anode, asciiDigit);
    ascii2_7seg HEX_TO_7SEG(asciiDigit, seg7digit);
endmodule


