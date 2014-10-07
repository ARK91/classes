// File: counter_4bit_tb.v
// John Hubbard, 04 Oct 2014
// hw3 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw3/c/modelsim
// vlib work
// vlog -sv ../*.v
// vsim work.counter_4bit_tb
// add wave *
// run 20 ns
//

`timescale 1ns/1ns
module counter_4bit_tb;
    reg tclk, treset;
    wire [3:0] tcount;

    counter_4bit DUT(tclk, treset, tcount);

    initial
    begin
        #1 $monitor ("time %t ", $time, "tclk, treset: %b %b, tcount: %b%b%b%b",
                     tclk, treset,
                     tcount[3],
                     tcount[2],
                     tcount[1],
                     tcount[0]
                     );

        // Reset the counter:
        treset = 1'b1;
        tclk = 0'b0;

        // Allow counting to run with the clock:
        #10 treset = 1'b0;

    end

    // Start up a clock:
    always
    begin
        #5 tclk = !tclk;
    end

endmodule

/* Results:

counter_4bit test run:

*/
