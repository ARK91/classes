//Copyright: Jagadeesh Vasudevamurthy
//File seg7.v display_at_n_second.v

module mod_counter(clk, arst, q, done) ;
    parameter N = 7 ;
    parameter MAX = 127 ;
    input clk,arst;
    output [N-1:0] q ;
    output done ;

    reg [N-1:0] q ;
    reg done ;

    always @(posedge clk or posedge arst)
    begin
        if (arst == 1'b1)
        begin
            q <= 0 ;
            done <= 0 ;
        end
        else if (q == MAX)
        begin
            q <= 0 ;
            done <= 1 ;
        end
        else
        begin
            q <= q + 1 ;
            done <= 0 ;
        end
    end
endmodule

module display_at_n_second(clk, arst, seg, an, text, done) ;
    parameter NUM_SEC = 1 ;
    parameter C = 35; //27 for 1 sec
    parameter N = 7 ;
    parameter W = 4 ;
    parameter CRYSTAL = 100 ; // 100 MHZ
    parameter [C-1:0] STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1 ;

    input clk, arst ;
    input [15:0] text ;
    output [0:N-1] seg ;
    output [W-1:0] an ;
    output done ;
    wire [C-1:0] clock ;

    mod_counter #(C,STOPAT) U(clk, arst, clock, done) ;
    display #(C)T(text,clk,arst, seg, an) ;
endmodule
