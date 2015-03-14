// File: scrolling_display.v
// John Hubbard, 08 Mar 2015
//
// hw6: Implement a scrolling display, that can display any number, up to
// 10-digits long.
//

`timescale 1ns/1ns

module scrolling_display(clk, reset, seg, an, fullPackedAsciiInput);
    parameter ASCII_DIGITS = 10;
    parameter BITS_PER_DIGIT = 8;
    parameter BUF_BITS = ASCII_DIGITS * BITS_PER_DIGIT;

    input clk, reset;
    input [BUF_BITS-1:0] fullPackedAsciiInput;
    output [0:7-1] seg;
    output [4-1:0] an;
    wire done;

    reg [BUF_BITS-1:0] sb; // scroll buffer

    always @(posedge clk) begin
        if (reset) begin
            sb[BUF_BITS-1:0] = fullPackedAsciiInput[BUF_BITS-1:0];
        end
        else if (done) begin
            // Shift (rotate) left by one ASCII digit:
            sb[(8-1)-:BITS_PER_DIGIT]  <= sb[(80-1)-:BITS_PER_DIGIT];
            sb[(16-1)-:BITS_PER_DIGIT]  <= sb[(8-1)-:BITS_PER_DIGIT];
            sb[(24-1)-:BITS_PER_DIGIT]  <= sb[(16-1)-:BITS_PER_DIGIT];
            sb[(32-1)-:BITS_PER_DIGIT]  <= sb[(24-1)-:BITS_PER_DIGIT];
            sb[(40-1)-:BITS_PER_DIGIT]  <= sb[(32-1)-:BITS_PER_DIGIT];
            sb[(48-1)-:BITS_PER_DIGIT]  <= sb[(40-1)-:BITS_PER_DIGIT];
            sb[(56-1)-:BITS_PER_DIGIT]  <= sb[(48-1)-:BITS_PER_DIGIT];
            sb[(64-1)-:BITS_PER_DIGIT]  <= sb[(56-1)-:BITS_PER_DIGIT];
            sb[(72-1)-:BITS_PER_DIGIT]  <= sb[(64-1)-:BITS_PER_DIGIT];
            sb[(80-1)-:BITS_PER_DIGIT]  <= sb[(72-1)-:BITS_PER_DIGIT];
        end
    end

    // Display the top 4 digits (32 bits) of the scroll buffer:
    display_packed_ascii_for_n_seconds #(1.0)
        DISPLAY(clk, reset, seg, an, sb[(80-1)-:32] , done);
endmodule

module scrolling_display_tb(clk, btnU, seg, an);
    parameter ASCII_DIGITS = 10;
    parameter BITS_PER_DIGIT = 8;
    parameter BUF_BITS = ASCII_DIGITS * BITS_PER_DIGIT;

    parameter [BUF_BITS-1:0] initialString =
        'h68656c6c6f2d4a464800; // "hello-JFH "

    input clk, btnU;
    output [0:7-1] seg;
    output [4-1:0] an;
    reg [BUF_BITS-1:0] fullPackedAsciiString;

    scrolling_display DUT(clk, btnU, seg, an, fullPackedAsciiString);

    always @(posedge clk) begin
        if (btnU) begin
            fullPackedAsciiString = initialString;
        end
    end
endmodule


