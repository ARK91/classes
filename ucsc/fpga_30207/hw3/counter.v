// File counter.v
// Also uses: hex2_7seg.v basys3.xdc
// Modified (and fixed) by John Hubbard, 06 Feb 2015
//
// Used integer and 34-bit wire variables, to hold the large counter values.
// When counting up to 60 seconds, using a 100 MHz clock, you need to count
// up to 60*100*1,000,000 = 6 billion, which requires at least 33 bits.
//
// The original code used "parameter" to hold this, but the parameter keyword
// is only necessary when a value needs to be changed at instantiation time.
// It appears that only 32 bits wide parameters are supported, which led to a
// bug that was invisible for a one-second (100 * 1,000,000 : 27 bits) counter,
// but overflowed a 32-bit counter.
//
// The fix, again, is simply to use wire and integer types of large enough bit
// width.
//
// --John Hubbard, 06 Feb 2015
//
// For HW #3 assignment of FPGA class.

module counter(clk, arst, q) ;
     parameter N = 7 ;
     input clk,arst ;
     output [N-1:0] q ;
     reg [N-1:0] q ;

    always @(posedge clk or posedge arst)
        if (arst == 1'b1)
            q <= 0 ;
        else
            q <= q + 1 ;
endmodule

module oneminute_bad(clk, btnU, seg, an, led) ;
    parameter C = 34 ; // 36 bits is ample to count up 60 * 100 MHz.
    parameter N7 = 7 ;
    parameter N4 = 4 ;

    integer CRYSTAL = 100 ; // 100 MHZ
    wire  [C-1:0]STOPAT_ONE_MIN = (CRYSTAL * 1_000_000 * 60)- 1;

    input clk, btnU;
    output [0:N7-1] seg ;
    output [N4-1:0] an ;
    output [N4-1:0] led ;
    wire [C-1:0] sec_counter ;
    wire [N4-1:0] zero_to_f_counter ;
    wire one_minute_clock ;

    assign an = 4'b0010 ; /* ON ON OFF ON */
    assign one_minute_clock = (sec_counter == STOPAT_ONE_MIN) ? 1: 0 ;

    counter #C MINUTE_COUNTER(clk, (btnU || one_minute_clock), sec_counter) ;
    counter #N4 HEX_COUNTER(one_minute_clock, btnU, zero_to_f_counter) ;

    hex2_7seg D(zero_to_f_counter,seg);

    assign led = zero_to_f_counter;
endmodule
