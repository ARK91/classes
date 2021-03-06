// File: scrolling_display_tb.v
// John Hubbard, 20 Mar 2015
//
// hw6: test bench for scrolling_display.v
//

module numeric_scrolling_display_tb(clk, btnU, btnD, btnC, seg, an);
    parameter NUM_DIGITS = 10;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;
    parameter BITS_FOR_NUMBER_TO_DISPLAY = 40;

    parameter NUM_SEC = 7; // Allow time for the number to display and needToScroll
    parameter C = 35; //27 for 1 sec
    parameter N = 7;
    parameter W = 4;
    parameter CRYSTAL = 100; // 100 MHZ
    parameter [C-1:0] CYCLES_TO_DISPLAY = (CRYSTAL * 1_000_000 * NUM_SEC)- 1;

    input clk, btnU, btnD, btnC;
    output [0:7-1] seg;
    output [4-1:0] an;

    reg [BITS_FOR_NUMBER_TO_DISPLAY-1:0] numberToDisplay;
    wire displayTimeDone;
    wire [C-1:0]displayTickCount;

    // Any of these buttons will reset everything:
    assign reset = btnU || btnD || btnC;

    // Timer for how long to display each complete number:
    mod_counter #(C, CYCLES_TO_DISPLAY) DISPLAY_TIMER(clk, reset,
                                                      displayTickCount,
                                                      displayTimeDone);
    scrolling_numeric_display DUT(clk, reset,
                                  numberToDisplay,
                                  displayTimeDone,
                                  seg, an);
    always @(posedge clk) begin

        // Start from different numbers, depending on which button is pressed:
        if (btnU)
            numberToDisplay <= 'd0;
        else if (btnD)
            numberToDisplay <= 'd9001;
        else if (btnC)
            numberToDisplay <= 'd10002;
        else begin
            if (displayTimeDone) begin
                numberToDisplay = numberToDisplay + 'd2000;

                if (numberToDisplay > 'd9999_9999_99)
                    numberToDisplay <= 'd1;
            end
        end
    end
endmodule

// Problem statement that this module addresses:
// Instead of hex2_7seg.v write a routine called ascill_2_7seg.
// Try to display as many characters as possible on the board.
//
module scrolling_ascii_display_tb(clk, btnU, seg, an, sw);
    parameter NUM_DIGITS = 10;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    parameter [BUF_BITS-1:0] initialString =
        'h68656c6c6f2d4a464800; // "hello-JFH "

    input clk, btnU;
    output [0:7-1] seg;
    output [4-1:0] an;
    input [0:0] sw;
    reg [BUF_BITS-1:0] asciiStringToDisplay;

    // moveToNewDisplayBuffer is tied to switch zero, so you can freeze the
    // display:
    scrolling_ascii_display DUT(clk, btnU, seg, an, asciiStringToDisplay,
                                sw[0]);

    always @(posedge clk) begin
        if (btnU) begin
            asciiStringToDisplay = initialString;
        end
    end
endmodule


