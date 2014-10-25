// File: bin2gray_tb.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.5: Binary to Gray code
// converter.
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw5/e_bin2gray/modelsim
// vlib work
// vlog -sv ../bin2gray.v ../bin2gray_tb.v
// vsim work.bin2gray_tb
// run 400 ns
//

`timescale 1ns/1ns
module bin2gray_tb;
    reg [3:0]bin_tb;
    wire [3:0]gray_tb;
    integer count;

    bin2gray DUT(bin_tb, gray_tb);

    // This block prints whenever the inputs or outputs change:
    initial
    begin
        $monitor("Time %t: bin: %b%b%b%b gray: %b%b%b%b ",
                 $time, bin_tb[3], bin_tb[2], bin_tb[1], bin_tb[0],
                 gray_tb[3], gray_tb[2], gray_tb[1], gray_tb[0]);
    end

    // Test pattern: exhaustive inputs:
    initial
    begin
        for (count = 0; count < 16; count++)
        begin
            {bin_tb} = count[3:0];
            #10;
        end
    end
endmodule

/* Sample test run:
*/
