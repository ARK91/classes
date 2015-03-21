// File: scrolling_display.v
// John Hubbard, 08 Mar 2015
//
// hw6: Implement a scrolling display, that can display any number, up to
// 10-digits long.
//

`timescale 1ns/1ns

module scrolling_ascii_display(clk, reset,
                               asciiStringToDisplay,
                               needToScroll,
                               latchNewString,
                               seg, an);
    parameter NUM_DIGITS = 10;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    input clk, reset;
    input [BUF_BITS-1:0] asciiStringToDisplay;
    input needToScroll, latchNewString;
    output [0:7-1] seg;
    output [4-1:0] an;

    wire doneWithDigit;
    reg waitingForStart;

    reg [BUF_BITS-1:0] sb; // scroll buffer
    reg [4:0] numShifts;
    reg savedNeedToScroll;

    always @(posedge clk) begin
        if (reset || latchNewString) begin
            // Do nothing until the next clock cycle:
            waitingForStart = 1'b1;
        end
        else if (waitingForStart) begin
            // Latch in everything
            savedNeedToScroll = needToScroll;

            if (savedNeedToScroll)
                sb[BUF_BITS-1:0] = asciiStringToDisplay[BUF_BITS-1:0];
            else begin
                // Non-scrolling case:
                // Just shift the bottom 4 digits to the top 4 position:
                sb[(80-1)-:32] = asciiStringToDisplay[(32-1)-:32];
            end

            waitingForStart = 1'b0;
            numShifts = 5'h0;
        end
        else if (doneWithDigit && savedNeedToScroll && (numShifts < 20)) begin
            // Shift (rotate) left by one ASCII digit:
            // TODO: this can be done in just a couple lines, no need to do it
            // 8 bits at a time.
            sb[(8-1)-:BITS_PER_ASCII_DIGIT]  <= 8'h00;
            sb[(16-1)-:BITS_PER_ASCII_DIGIT] <= sb[(8-1)-:BITS_PER_ASCII_DIGIT];
            sb[(24-1)-:BITS_PER_ASCII_DIGIT] <= sb[(16-1)-:BITS_PER_ASCII_DIGIT];
            sb[(32-1)-:BITS_PER_ASCII_DIGIT] <= sb[(24-1)-:BITS_PER_ASCII_DIGIT];
            sb[(40-1)-:BITS_PER_ASCII_DIGIT] <= sb[(32-1)-:BITS_PER_ASCII_DIGIT];
            sb[(48-1)-:BITS_PER_ASCII_DIGIT] <= sb[(40-1)-:BITS_PER_ASCII_DIGIT];
            sb[(56-1)-:BITS_PER_ASCII_DIGIT] <= sb[(48-1)-:BITS_PER_ASCII_DIGIT];
            sb[(64-1)-:BITS_PER_ASCII_DIGIT] <= sb[(56-1)-:BITS_PER_ASCII_DIGIT];
            sb[(72-1)-:BITS_PER_ASCII_DIGIT] <= sb[(64-1)-:BITS_PER_ASCII_DIGIT];
            sb[(80-1)-:BITS_PER_ASCII_DIGIT] <= sb[(72-1)-:BITS_PER_ASCII_DIGIT];

            numShifts = numShifts + 1;
        end
    end

    // Display the top 4 digits (32 bits) of the needToScroll buffer:
    display_packed_ascii_for_n_seconds #(0.5)
        DISPLAY(clk, reset, seg, an, sb[(80-1)-:32], doneWithDigit);
endmodule

// Problem statement that this module addresses:
// Implement a module that displays  numbers up to 9999_9999_99
// Test the module by displaying number at a distance of 2000 for a every sec
// The display should start scrolling after 9999.
//
module scrolling_numeric_display(clk, reset,
                                 numberToDisplay,
                                 latchNewNumber,
                                 seg, an);
    parameter NUM_DIGITS = 10;
    parameter BCD_BITS = NUM_DIGITS * 'd4;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;
    parameter BITS_FOR_NUMBER_TO_DISPLAY = 40;

    input clk, reset;
    input [BITS_FOR_NUMBER_TO_DISPLAY-1:0] numberToDisplay;
    output [0:7-1] seg;
    output [4-1:0] an;
    input latchNewNumber;

    wire [BCD_BITS-1:0] numberInBcdFormat;
    wire [BUF_BITS-1:0] asciiStringToDisplay;
    wire needToScroll;
    wire digitsDone;

    assign needToScroll = (numberToDisplay > 'd9999) ? 1'b1 : 1'b0;

    binary2bcd #(BCD_BITS) BCD(numberToDisplay, numberInBcdFormat);

    bcd_to_ascii #(NUM_DIGITS) BCD_TO_ASCII(numberInBcdFormat,
                                            asciiStringToDisplay);

    scrolling_ascii_display DUT(clk, reset,
                                asciiStringToDisplay,
                                needToScroll,
                                latchNewNumber,
                                seg, an);
endmodule

