//  File: binary2bcd.v
// John Hubbard

`timescale 1ns/1ns

module binary2bcd(number, text);
    parameter N = 16 ;
    parameter W = 4 ;
    input [N-1:0] number ;
    reg [N-1:0] workingNumber ;
    output reg [N-1:0] text ;

    reg [3:0] digit;
    integer digitEnd;

    always @(number)
    begin
        text          = 16'h0000;
        workingNumber = number;
        digit         = workingNumber % 10;
        digitEnd      = 3;

        while(workingNumber > 0)
        begin
            text[digitEnd-:4] = digit;

            // Move to the next digit:
            workingNumber = workingNumber / 10;
            digit = workingNumber % 10;
            digitEnd = digitEnd + 4;
        end
    end
endmodule

module binary2bcd_tb();
    parameter N = 16 ;
    reg [N-1:0] vec ;
    wire [N-1:0] text ;

    binary2bcd BCD(vec, text);

    initial
    begin
        for (vec = 0; vec < 102; vec = vec + 1)
        begin
            #1 $display("vec: %d, text: %h", vec, text);
        end
    end

endmodule

