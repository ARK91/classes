 //File onesecond_bad.v
 //hex2_7seg.v onesecond_bad.v basys3.xdc
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
    parameter NUM_SEC = 1 ; //1 Sec
    parameter STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1;

    input clk, btnU;
    output [0:N7-1] seg ;
    output [N4-1:0] an ;
    output [N4-1:0] led ;
    wire [C-1:0] big_counter ;
    wire [N4-1:0] zero_to_f_counter ;
    wire one_second_clock ;

    assign an = 4'b0010 ; /* ON ON OFF ON */
    assign one_second_clock = (big_counter == STOPAT) ? 1: 0 ;

    counter #C U(clk,(btnU|| one_second_clock),big_counter) ;
    counter #N4 S(one_second_clock,btnU,zero_to_f_counter) ;
    hex2_7seg D(zero_to_f_counter,seg);

    assign led = zero_to_f_counter;
endmodule
