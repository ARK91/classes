// file ascii2_7seg.v
// John Hubbard, 08 Mar 2015

module hex2_7seg(asciiIn, segmentsOut);
    parameter N = 7; // 7-bit (printable) ascii, rather than the extended 8-bit
    input  [N-1:0] asciiIn;    //3210
    output reg [6:0] segmentsOut; // abcdefg

    always @(*)
    begin
        case (asciiIn)
             0:  segmentsOut = 7'b0000001;
             1:  segmentsOut = 7'b1001111;
             2:  segmentsOut = 7'b0010010;
             3:  segmentsOut = 7'b0000110;
             4:  segmentsOut = 7'b1001100;
             5:  segmentsOut = 7'b0100100;
             6:  segmentsOut = 7'b0100000;
             7:  segmentsOut = 7'b0001111;
             8:  segmentsOut = 7'b0000000;
             9:  segmentsOut = 7'b0000100;
             10: segmentsOut = 7'b0001000;
             11: segmentsOut = 7'b1100000;
             12: segmentsOut = 7'b0110001;
             13: segmentsOut = 7'b1000010;
             14: segmentsOut = 7'b0110000;
             15: segmentsOut = 7'b0111000;
             'h2d: segmentsOut = 7'b1111110;
             default: segmentsOut = 7'bx;
         endcase
     end
endmodule

