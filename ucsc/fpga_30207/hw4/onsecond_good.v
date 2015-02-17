// File: onesecond_good.v
// Modified by John Hubbard, 31 Jan 2015

module onesecond_good(clk, btnU, seg, an, led) ;
    parameter C = 28; //27..0 counter
    parameter N7 = 7 ;
    parameter N4 = 4 ;
    parameter CRYSTAL = 100 ; // 100 MHZ
    parameter NUM_SEC = 1 ;
    parameter STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1 ;

    input clk, btnU;
    output [0:N7-1] seg ;
    output [N4-1:0] an ;
    output [N4-1:0] led ;
    wire [C-1:0] big_counter ;
    wire [N4-1:0] zero_to_f_counter ;
    wire one_second_clock ;

    assign an = 4'b0111 ; /* ON OFF OFF OFF */
    mod_counter #(C,STOPAT) U(clk, btnU, big_counter, one_second_clock) ;
    counter #(N4) S(clk,btnU,one_second_clock,zero_to_f_counter) ;
    hex2_7seg D(zero_to_f_counter,seg);
    assign led = zero_to_f_counter;
endmodule
