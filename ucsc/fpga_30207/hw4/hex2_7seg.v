// file hex2_7seg.v
// Modified by John Hubbard, 31 Jan 2015
// For HW #4 assignment of FPGA class.

module hex2_7seg(in,out) ;
    input [3:0] in ; /*3210 */
    output [6:0] out ; /* abcdefg */
    reg [6:0] out ;

    always @(*)
    begin
        case (in)
             /*3210*/ /*abcdefg */
             0:  out = 7'b0000001 ;
             1:  out = 7'b1001111 ;
             2:  out = 7'b0010010 ;
             3:  out = 7'b0000110 ;
             4:  out = 7'b1001100 ;
             5:  out = 7'b0100100 ;
             6:  out = 7'b0100000 ;
             7:  out = 7'b0001111 ;
             8:  out = 7'b0000000 ;
             9:  out = 7'b0000100 ;
             10: out = 7'b0001000 ;
             11: out = 7'b1100000 ;
             12: out = 7'b0110001 ;
             13: out = 7'b1000010 ;
             14: out = 7'b0110000 ;
             15: out = 7'b0111000 ;
             default: out = 7'bx ;
         endcase
     end
endmodule

module a7_hex2_7seg(sw,seg,an) ;
    input [3:0] sw ; /* 3210 */
    output [0:6] seg; /* abcdefg */
    output [3:0] an ; /* 3210 */

    assign an = 4'b0010 ; /* ON ON OFF ON */
    hex2_7seg U(.in(sw),.out(seg) );
endmodule

