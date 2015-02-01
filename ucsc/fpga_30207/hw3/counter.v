 //File onesecond_bad.v
 //hex2_7seg.v onesecond_bad.v basys3.xdc
// Modified by John Hubbard, 31 Jan 2015
// Added an intermediate clock, so that there is one for seconds, and that
// clock cascades into the per-minute clock. This avoids overflowing the
// parameter (which appears to be a 32-bit value).
//
// For HW #3 assignment of FPGA class.

module counter(clk,arst,q) ;
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

module onesecond_bad(clk, btnU, seg, an, led) ;
    parameter C = 28 ; //28-1 = 27. Note counter is also N-1
    parameter N7 = 7 ;
    parameter N4 = 4 ;
    parameter CRYSTAL = 100 ; // 100 MHZ

    parameter STOPAT_SEC_PER_MIN = 60;
    parameter STOPAT_ONE_SEC = (CRYSTAL * 1_000_000 * 1)- 1;

    input clk, btnU;
    output [0:N7-1] seg ;
    output [N4-1:0] an ;
    output [N4-1:0] led ;
    wire [C-1:0] min_counter ;
    wire [C-1:0] sec_counter ;
    wire [N4-1:0] zero_to_f_counter ;
    wire one_second_clock ;
    wire one_minute_clock ;

    assign an = 4'b0010 ; /* ON ON OFF ON */
    assign one_second_clock = (sec_counter == STOPAT_ONE_SEC) ? 1: 0 ;
    assign one_minute_clock = (min_counter == STOPAT_SEC_PER_MIN) ? 1: 0 ;

    counter #C FINAL_CLOCK(one_second_clock,(btnU|| one_minute_clock),min_counter) ;
    counter #C MEDIUM_CLOCK(clk,(btnU|| one_second_clock),sec_counter) ;
    counter #N4 S(one_minute_clock,btnU,zero_to_f_counter) ;

    hex2_7seg D(zero_to_f_counter,seg);

    assign led = zero_to_f_counter;
endmodule
