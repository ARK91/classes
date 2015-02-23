//  File: binary2bcd.v
// John Hubbard

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

//WRITE CODE HERE
endmodule

// YOU CANNOT CHANGE ANYTHING BELOW
module binary2bcdTest(clk, btnU, seg, an,led) ;
parameter N = 7 ;
parameter W = 4 ;

input clk, btnU ;
output [0:N-1] seg ;
output [W-1:0] an ;
output[15:0] led ;

wire done ;
reg[15:0] number ;
wire[15:0] text1,text2,text3,text ;

always @(posedge clk or posedge btnU)
begin
if (btnU)
number = 0;
else if (done)
number = number + 1 ;
end
binary2bcdBehavioral U1(number,text1) ;
binary2bcdStructral U2(number,text2) ;
binary2bcdDivision U3(number,text3) ;
assign equal = ((text1 == text2) && (text1 == text3) && (text2 == text3))?1'b1:1'b0 ;
assign text = {15'b0,equal} ;
display_at_n_second #(0.5) D (clk, btnU, seg, an, text,done) ;
assign led = text1 ;
endmodule



//module binary2bcd(number, text);
//    parameter N = 16 ;
//    parameter W = 4 ;
//    input [N-1:0] number ;
//    reg [N-1 :0] workingNumber ;
//    output reg [N-1:0] text ;
//
//    reg [3:0] digit;
//    integer digitEnd;
//
//    always @(number)
//    begin
//        text          = 16'h0000;
//        workingNumber = number;
//        digit         = workingNumber % 10;
//        digitEnd      = 3;
//
//        while(workingNumber > 0 && (digitEnd < N))
//        begin
//            text[digitEnd-:4] = digit;
//
//            // Move to the next digit:
//            workingNumber = workingNumber / 10;
//            digit = workingNumber % 10;
//            digitEnd = digitEnd + 4;
//        end
//    end
//endmodule
//
//module binary2bcd_tb();
//    parameter N = 16 ;
//    reg [N-1:0] vec ;
//    wire [N-1:0] text ;
//
//    binary2bcd BCD(vec, text);
//
//    initial
//    begin
//        for (vec = 0; vec < 102; vec = vec + 1)
//        begin
//            #1 $display("vec: %d, text: %h", vec, text);
//        end
//    end
//
//endmodule

