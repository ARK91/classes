// bcd.v
// John F. Hubbard, 22 Mar 2015
//
// This file contains general BCD (binary-coded decimal) support,  including
// binary to BCD, and BCD to ASCII.
//

`timescale 1ns/1ns

module binary2bcd(number, bcd);
    parameter N = 16;
    parameter NBCD = 16;
    input  [N-1:0] number;
    output [NBCD-1:0] bcd;

    integer workingNumber;
    reg [NBCD-1:0] bcd;

    reg [3:0] digit;
    integer digitEnd;

    always @(number)
    begin
        bcd          = 16'h0000;
        workingNumber = number;
        digit         = workingNumber % 10;
        digitEnd      = 3;

        while(workingNumber > 0 && (digitEnd < N))
        begin
            bcd[digitEnd-:4] = digit;

            // Move to the next digit:
            workingNumber = workingNumber / 10;
            digit = workingNumber % 10;
            digitEnd = digitEnd + 4;
        end
    end
endmodule

module bcd_to_ascii(bcd, ascii);
    parameter NDIGITS = 10;
    parameter BCD_BITS = NDIGITS * 4;
    parameter ABITS = 8;    // ABITS means "number of bits per ASCII digit"
    parameter BBITS = 4;    // BBITS means "Number of bits per BCD digit"
    parameter BUF_BITS = NDIGITS * ABITS;

    input [BCD_BITS-1:0] bcd;
    output reg [BUF_BITS-1:0] ascii;
    integer digit;
    reg firstNonZero;

    always @(bcd) begin
        digit = 0;
        firstNonZero = 1'b0;

        for (digit = 0; digit < NDIGITS; digit = digit + 1) begin

            // 0x30 is anode ASCII "0":
            ascii[(digit*ABITS + ABITS - 1)-:ABITS] =
                bcd[(digit*BBITS + BBITS   - 1)-:BBITS] + 'h30;
        end

        // Turn leading zeros into underscores, but only if the number is not
        // actually just zero:
        if (bcd > 0) begin
            for (digit = NDIGITS - 1; digit >=0; digit = digit  - 1) begin
                if ((ascii[(digit*ABITS + ABITS - 1)-:ABITS] == 'h30) &&
                     !firstNonZero)

                    ascii[(digit*ABITS + ABITS - 1)-:ABITS] = 'h5f;
                else
                    firstNonZero = 1'b1;
            end
        end
    end
endmodule

module bcd_to_ascii_tb();
    parameter NDIGITS = 10;
    parameter BCD_BITS = NDIGITS * 4;
    parameter ABITS = 8;
    parameter BUF_BITS = NDIGITS * ABITS;

    reg [BCD_BITS-1:0] number;
    reg [BCD_BITS-1:0] bcd;
    wire [BUF_BITS-1:0] ascii;
    integer digit, count;

    //binary2bcd #(BUF_BITS) BCD_TB(number, bcd);
    bcd_to_ascii #(NDIGITS) B(bcd, ascii);

    initial begin
        bcd = 'h0;
        number = bcd;
        #1;
        $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);

        bcd = 'h1;
        #1;
        $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);

        bcd = 'h2000;
        number = bcd;
        #1;
        $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);

        for (count = 0; count < 25; count = count + 1) begin
            #1;
            $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);
            bcd = bcd + 1;
            number = bcd;
        end

        bcd = 'h10;
        number = bcd;
        for (count = 0; count < 10; count = count + 1) begin
            #1;
            $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);
            bcd = bcd + 1;
            number = bcd;
        end

        bcd = 'h1000;
        number = bcd;
        for (count = 0; count < 10; count = count + 1) begin
            #1;
            $display("number: %d, bcd: %h, ascii: %h", number, bcd, ascii);
            bcd = bcd + 1;
            number = bcd;
        end
    end
endmodule

