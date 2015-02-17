// File: all_patterns.v
// John Hubbard, 16 Feb 205
// For HW #4 assignment of FPGA class.

//
// Answers to problem 3.9.7
//
// There are 2**7, or 128 possible patterns for a 7-seqment LED. It will take
// 128 seconds, or 2 minutes and 8 seconds, to display them all.

module all_patterns_top_module(clk, btnU, seg, an);
    parameter C = 28; //27..0 counter
    parameter N7 = 7 ;
    parameter N4 = 4 ;
    parameter CRYSTAL = 100 ; // 100 MHZ
    parameter NUM_SEC = 1 ;
    parameter STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1 ;

    input clk, btnU;
    output [N7-1:0] seg; // These are backwards, to match the zero_to_127_counter
    wire   [N7-1:0] zero_to_127_counter;
    output [N4-1:0] an;
    wire [C-1:0] big_counter;
    wire one_second_clock;

    assign an = 4'b0111; // ON off off off
    mod_counter #(C,STOPAT) MOD_COUNTER(clk, btnU, big_counter, one_second_clock);
    counter #(N7) COUNTER(clk, btnU, one_second_clock, zero_to_127_counter);
    assign seg = zero_to_127_counter;
endmodule


