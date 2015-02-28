`timescale 1ns/1ns

module binary2bcdBehavioral(number,text) ;
    parameter N = 16 ;
    parameter W = 4 ;
    input [N-1:0] number ;
    output [N-1:0] text ;

    // WRITE CODE HERE
endmodule

module binary2bcdStructral(number,text) ;
    parameter N = 16 ;
    parameter W = 4 ;
    input [N-1:0] number ;
    output [N-1:0] text ;

    // WRITE CODE HERE
endmodule

module D(n,q,r);
    parameter K = 32 ;
    input [K-1:0] n ;
    output [K-1:0] q ;
    output [3:0] r ;

    // WRITE CODE HERE
endmodule


module binary2bcdDivision(number,text) ;
    parameter N = 16 ;
    parameter W = 4 ;
    input [N-1:0] number ;
    output [N-1:0] text ;

    reg [N-1 :0] workingNumber ;
    reg [N-1:0] text ;

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

module binary2bcd_tb();
    parameter N = 16 ;
    reg [N-1:0] vec ;
    wire [N-1:0] text ;
    wire [N-1:0] text1 ;
    wire [N-1:0] text2 ;
    wire [N-1:0] text3 ;

    binary2bcdDivision BCD(vec, text);
    binary2bcdDivision BCD2(vec, text1);

    initial
    begin
        for (vec = 0; vec < 102; vec = vec + 1)
        begin
            #1;
            if (text == text1)
                #1 $display("vec: %d, text: %h", vec, text);
            else
                $display("FAILURE: text: %d, text1: %d", text, text1);
        end
    end
endmodule

