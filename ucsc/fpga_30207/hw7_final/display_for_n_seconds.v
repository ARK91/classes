// Copyright: Jagadeesh Vasudevamurthy
// File seg7.v display_for_n_seconds.v

// This module displays a 4-digit hex number, and toggles "done" after
// NUM_SEC seconds.
module display_packed_hex_for_n_seconds(clk, arst, seg, an, packedHex, done);
    parameter NUM_SEC = 1;
    parameter C = 35; //27 for 1 sec
    parameter N = 7;
    parameter W = 4;
    parameter CRYSTAL = 100; // 100 MHZ
    parameter [C-1:0] STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1;

    input clk, arst;
    input [15:0] packedHex;
    output [0:N-1] seg;
    output [W-1:0] an;
    output done;
    wire [C-1:0] clock;

    mod_counter #(C, STOPAT) U(clk, arst, clock, done);
    display_hex #(C)T(packedHex, clk, arst, seg, an);
endmodule

// This module displays a 4-digit ASCII string, and toggles "done" after
// NUM_SEC seconds.
module display_packed_ascii_for_n_seconds(clk, arst, seg, an, packedAscii, done);
    parameter NUM_SEC = 1;
    parameter C = 35; //27 for 1 sec
    parameter CRYSTAL = 100; // 100 MHZ
    parameter [C-1:0] CYCLE_LIMIT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1;
    parameter NUM_DIGITS = 4;
    parameter ABITS = 8;    // ABITS means "number of bits per ASCII digit"
    parameter BUF_BITS = NUM_DIGITS * ABITS;

    input clk, arst;
    input [BUF_BITS-1:0] packedAscii;
    output [0:7-1] seg;
    output [4-1:0] an;
    output done;
    wire [C-1:0] clock;

    mod_counter #(C, CYCLE_LIMIT) U(clk, arst, clock, done);
    display_ascii #(C) T(packedAscii, clk, arst, seg, an);
endmodule

