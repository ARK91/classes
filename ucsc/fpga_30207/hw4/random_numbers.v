// File: random_numbers.v
// John Hubbard, 16 Feb 205
// For HW #4 assignment of FPGA class.

//
// Random numbers display: problem 4.7.2
//

module rom(in,out) ;
    parameter N = 3 ;
    parameter O = 14 ; //9999
    input [N-1:0] in ;
    output reg [O-1:0] out ;

    always @(in)
    begin
        case (in)
            0: out = 1;
            1: out = 17 ;
            2: out = 23 ;
            3: out = 57 ;
            4: out = 234 ;
            5: out = 9 ;
            6: out = 4878 ;
            7: out = 9999 ;
        default: out = 9998 ;
        endcase
    end
endmodule

module heartbreat_top_module(clk, btnU, seg, an);
    parameter C = 28; //27..0 counter
    parameter N7 = 7 ;
    parameter N4 = 4 ;
    parameter CRYSTAL = 100 ; // 100 MHZ
    parameter NUM_SEC = 1 ;
    parameter STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1 ;

    output [13:0] number;

    input clk, btnU;
    output [0:6] seg; // abcdefg
    wire   [2:0] zero_to_8_counter;
    output [3:0] an;
    wire [C-1:0] big_counter;
    wire one_second_clock;

    mod_counter #(C,STOPAT) MOD_COUNTER(clk, btnU, big_counter, one_second_clock);
    counter #(3) COUNTER(clk, btnU, one_second_clock, zero_to_8_counter);

    rom THE_ROM(zero_to_8_counter, number);

    // TODO: this needs to handle four digit display
    hex2_7seg DISPLAY(number, seg);

endmodule


