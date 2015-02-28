`timescale 1ns/1ns

module binary2bcdBehavioral(number,text) ;
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

module add3(a, sum);
    input [3:0]a;
    output [3:0]sum;

    LUT4 #(16'h03E0) (sum[3], a[0], a[1], a[2], a[3]);
    LUT4 #(16'h0210) (sum[2], a[0], a[1], a[2], a[3]);
    LUT4 #(16'h018C) (sum[1], a[0], a[1], a[2], a[3]);
    LUT4 #(16'h014A) (sum[0], a[0], a[1], a[2], a[3]);
endmodule

module add3_tb();
    reg [16:0] vec;
    wire [16:0] sum;

    add3 ADD3(vec, sum);

    initial
    begin
        for (vec = 0; vec < 16; vec = vec + 1)
        begin
            #1;
            $display("vec: %d, sum: %h", vec, sum);
        end
    end
endmodule

module binary2bcdStructral(n,text) ;
    parameter N = 16 ;
    parameter W = 4 ;
    input [N-1:0] n ;
    output [N-1:0] text ;

    wire [0:3] c1_out, c2_out, c3_out, c4_out, c5_out;

    buf BUF0(text[0], n[0]);
    buf BUF1(text[10], 0);
    buf BUF2(text[11], 0);

    add3 C1(n[5], n[6], n[7], 0, c1_out);
    add3 C2(n[4], c1_out[0:2], c2_out);
    add3 C3(n[3], c2_out[0:2], c3_out);
    add3 C4(c3_out[3], c2_out[3], c1_out[3], 0, c4_out[0:2], text[9]);
    add3 C5(n[2], c3_out[0:2], c5_out);
    add3 C6(c5_out[0], c4_out[0:2], text[5], text[6], text[7], text[8]);
    add3 C7(n[1], c5_out[0:2], text[1], text[2], text[3], text[4]);
endmodule

module d10(n,q,r);
    parameter K = 32 ;
    input [K-1:0] n ;
    output [K-1:0] q ;
    output [3:0] r ;

    assign q = n / 10;
    assign r = n % 10;
endmodule

module binary2bcdDivision(number,text) ;
    parameter N = 16 ;
    parameter W = 4 ;
    input [N-1:0] number ;
    output [N-1:0] text ;
    wire [N-1:0] q1, q2, q3, q4;
    wire [3:0]   r1, r2, r3, r4;

    d10 #(N) U1(number, q1, r1);
    d10 #(N) U2(q1, q2, r2);
    d10 #(N) U3(q2, q3, r3);
    d10 #(N) U4(q3, q4, r4);
    assign text = {r4, r3, r2, r1};
endmodule

module binary2bcd_tb();
    parameter N = 16 ;
    reg [N-1:0] vec ;
    wire [N-1:0] text ;
    wire [N-1:0] text1 ;
    wire [N-1:0] text2 ;
    wire [N-1:0] text3 ;

    binary2bcdDivision DIVISION_BY_10(vec, text);
    binary2bcdBehavioral BEHAVIORAL(vec, text1);
    binary2bcdStructral STRUCTURAL(vec, text2);

    initial
    begin
        for (vec = 0; vec < 102; vec = vec + 1)
        begin
            #1;
            if (text == text1)
                #1 $display("vec: %d, text: %h", vec, text);
            else
                $display("FAILURE: text: %d, text1: %d", text, text1);

            if (text != text2)
                $display("FAILURE: text: %d, text2: %d", text, text1);

        end
    end
endmodule

