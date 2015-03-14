`timescale 1ns/1ns

module binary2bcd(number, text);
    parameter N = 16;
    parameter W = 4;
    input  [N-1:0] number;
    output [N-1:0] text;

    reg [N-1:0] workingNumber;
    reg [N-1:0] text;

    reg [3:0] digit;
    integer digitEnd;

    always @(number)
    begin
        text          = 16'h0000;
        workingNumber = number;
        digit         = workingNumber % 10;
        digitEnd      = 3;

        while(workingNumber > 0 && (digitEnd < N))
        begin
            text[digitEnd-:4] = digit;

            // Move to the next digit:
            workingNumber = workingNumber / 10;
            digit = workingNumber % 10;
            digitEnd = digitEnd + 4;
        end
    end
endmodule

module bcd_to_ascii(bcd, ascii);
    parameter NUM_DIGITS = 10;
    parameter BCD_BITS = NUM_DIGITS * 4;
    parameter BITS_PER_ASCII_DIGIT = 8;
    parameter BITS_PER_BCD_DIGIT = 4;
    parameter BUF_BITS = NUM_DIGITS * BITS_PER_ASCII_DIGIT;

    input [BCD_BITS-1:0] bcd;
    output reg [BUF_BITS-1:0] ascii;
    reg [NUM_DIGITS:0] digit;

    always @(bcd) begin
        digit = 'd0;
        while (digit < NUM_DIGITS) begin

            // 0x30 is an ASCII "0":
            ascii[(digit+BITS_PER_ASCII_DIGIT)-:BITS_PER_ASCII_DIGIT] =
                bcd[(digit+BITS_PER_BCD_DIGIT)-:BITS_PER_BCD_DIGIT] + 'h30;

            digit = digit + 'd1;
        end
    end
endmodule

