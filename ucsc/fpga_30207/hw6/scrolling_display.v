// File: scrolling_display.v
// John Hubbard, 08 Mar 2015
//
// hw6: Implement a scrolling display, that can display any number, up to
// 10-digits long.
//

`timescale 1ns/1ns

module scrolling_ascii_display(clk, reset, seg, an, fullPackedAsciiInput, scroll);
    parameter NUM_DIGITS = 10;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    input clk, reset, scroll;
    input [BUF_BITS-1:0] fullPackedAsciiInput;
    output [0:7-1] seg;
    output [4-1:0] an;
    wire done;

    reg [BUF_BITS-1:0] sb; // scroll buffer

    always @(posedge clk) begin
        if (reset) begin
            sb[BUF_BITS-1:0] = fullPackedAsciiInput[BUF_BITS-1:0];
        end
        else if (done && scroll) begin
            // Shift (rotate) left by one ASCII digit:
            sb[(8-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(80-1)-:BITS_PER_ASCII_DIGIT];
            sb[(16-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(8-1)-:BITS_PER_ASCII_DIGIT];
            sb[(24-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(16-1)-:BITS_PER_ASCII_DIGIT];
            sb[(32-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(24-1)-:BITS_PER_ASCII_DIGIT];
            sb[(40-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(32-1)-:BITS_PER_ASCII_DIGIT];
            sb[(48-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(40-1)-:BITS_PER_ASCII_DIGIT];
            sb[(56-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(48-1)-:BITS_PER_ASCII_DIGIT];
            sb[(64-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(56-1)-:BITS_PER_ASCII_DIGIT];
            sb[(72-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(64-1)-:BITS_PER_ASCII_DIGIT];
            sb[(80-1)-:BITS_PER_ASCII_DIGIT]  <= sb[(72-1)-:BITS_PER_ASCII_DIGIT];
        end
    end

    // Display the top 4 digits (32 bits) of the scroll buffer:
    display_packed_ascii_for_n_seconds #(0.3)
        DISPLAY(clk, reset, seg, an, sb[(80-1)-:32] , done);
endmodule

// Problem statement that this module addresses:
// Instead of hex2_7seg.v write a routine called ascill_2_7seg.
// Try to display as many characters as possible on the board.
//
module scrolling_ascii_display_tb(clk, btnU, seg, an);
    parameter NUM_DIGITS = 10;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    parameter [BUF_BITS-1:0] initialString =
        'h68656c6c6f2d4a464800; // "hello-JFH "

    input clk, btnU;
    output [0:7-1] seg;
    output [4-1:0] an;
    reg [BUF_BITS-1:0] fullPackedAsciiString;

    scrolling_ascii_display DUT(clk, btnU, seg, an, fullPackedAsciiString, 1'b1);

    always @(posedge clk) begin
        if (btnU) begin
            fullPackedAsciiString = initialString;
        end
    end
endmodule

// Problem statement that this module addresses:
// Implement a module that displays  numbers up to 9999_9999_99
// Test the module by displaying number at a distance of 2000 for a every sec
// The display should start scrolling after 9999.
//
module scrolling_numeric_display(clk, reset, seg, an, numericInput, scrollingDone);
    parameter NUM_DIGITS = 10;
    parameter BCD_BITS = NUM_DIGITS * 'd4;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    parameter NUM_SEC = 5; // Allow time for the number to display and scroll
    parameter C = 35; //27 for 1 sec
    parameter N = 7;
    parameter W = 4;
    parameter CRYSTAL = 100; // 100 MHZ
    parameter [C-1:0] STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1;

    input clk, reset, scrollingDone;
    input [BUF_BITS-1:0] numericInput;
    output [0:7-1] seg;
    output [4-1:0] an;

    wire [BCD_BITS-1:0] fullPackedBcdString;
    wire [BUF_BITS-1:0] fullPackedAsciiString;
    wire scroll;

    assign scroll = numericInput <= 'd9999 ? 1'b0 : 1'b1;
    mod_counter #(C, STOPAT) SCROLL_COUNTER(clk, arst, clock, scrollingDone);
    binary2bcd #(BUF_BITS) BCD(numberToDisplay, fullPackedBcdString);
    bcd_to_ascii #(BUF_BITS) BCD_TO_ASCII(fullPackedBcdString, fullPackedAsciiString);

    scrolling_ascii_display DUT(clk, btnU, seg, an, fullPackedAsciiString, scroll);
endmodule

module numeric_scrolling_display_tb(clk, btnU, seg, an);
    parameter NUM_DIGITS = 10;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    input clk, btnU;
    output [0:7-1] seg;
    output [4-1:0] an;

    reg [BUF_BITS-1:0] numberToDisplay;
    wire done;

    numeric_scrolling_display DUT(clk, btnU, seg, an, numberToDisplay, done);

    always @(posedge clk) begin
        if (btnU) begin
            numberToDisplay = 'd1;
        end
        else begin
            if (done) begin
               numberToDisplay = numberToDisplay * 'd2000;

               if (numberToDisplay > 'd9999_9999_99) begin
                    numberToDisplay = 'd1;
               end
            end
        end
    end
endmodule






