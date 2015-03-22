// bcd.v
// John F. Hubbard, 22 Mar 2015
//
// This file contains general BCD (binary-coded decimal) support,  including
// binary to BCD, and BCD to ASCII.
//

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
    parameter ABITS = 8;    // ABITS means "number of bits per ASCII digit"
    parameter BBITS = 4;    // BBITS means "Number of bits per BCD digit"
    parameter BUF_BITS = NUM_DIGITS * ABITS;

    input [BCD_BITS-1:0] bcd;
    output reg [BUF_BITS-1:0] ascii;
    integer digit;
    reg firstNonZero;

    always @(bcd) begin
        digit = 0;
        firstNonZero = 1'b0;

        for (digit = 0; digit < NUM_DIGITS; digit = digit + 1) begin

            // 0x30 is an ASCII "0":
            ascii[(digit*ABITS + ABITS - 1)-:ABITS] =
                bcd[(digit*BBITS + BBITS   - 1)-:BBITS] + 'h30;
        end

        // Turn leading zeros into underscores, but only if the number is not
        // actually just zero:
        if (bcd > 0) begin
            for (digit = NUM_DIGITS - 1; digit >=0; digit = digit  - 1) begin
                if ((ascii[(digit*ABITS + ABITS - 1)-:ABITS] == 'h30) && !firstNonZero)
                    ascii[(digit*ABITS + ABITS - 1)-:ABITS] = 'h5f;
                else
                    firstNonZero = 1'b1;
            end
        end
    end
endmodule

module bcd_to_ascii_tb();
    parameter NUM_DIGITS = 10;
    parameter BCD_BITS = NUM_DIGITS * 'd4;
    parameter ABITS = 8;
    parameter BUF_BITS = NUM_DIGITS * ABITS;

    reg [BCD_BITS-1:0] number;
    reg [BCD_BITS-1:0] bcd;
    wire [BUF_BITS-1:0] ascii;
    integer digit, count;

    //binary2bcd #(BUF_BITS) BCD_TB(number, bcd);
    bcd_to_ascii #(NUM_DIGITS) B(bcd, ascii);

    initial begin
        bcd = 'h0;
        #1;
        $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);

        bcd = 'h1;
        #1;
        $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);

        bcd = 'h2000;
        #1;
        $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);

        for (count = 0; count < 10; count = count + 1) begin
            #1;
            $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);
            bcd = bcd + 1;
        end

        bcd = 'h10;
        for (count = 0; count < 10; count = count + 1) begin
            #1;
            $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);
            bcd = bcd + 1;
        end

        bcd = 'h1000;
        for (count = 0; count < 10; count = count + 1) begin
            #1;
            $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);
            bcd = bcd + 1;
        end

    end
endmodule

