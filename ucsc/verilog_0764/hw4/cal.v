// File: cal.v
// John Hubbard, 17 Oct 2014
// hw4 assignment for Verilog 0764 class
//
// Steps to run in ModelSim (Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw4/modelsim
// vlib work
// vlog -sv ../cal.v
// vsim work.cal_tb
// add wave *
// run 100 ns
//

`timescale 1ns/1ns
module cal_tb;
    parameter DEPTH = 279; // 2033 - 1755 + 1
    parameter WIDTH = 20;
    integer year;
    reg [WIDTH - 1:0] entry;
    reg [WIDTH - 1:0] yearTable[DEPTH - 1:0];

    initial
    begin
        $readmemh("../year_table_transformed.txt", yearTable);
        #10 $display("year_table_transformed.txt:\n");

        for (year = 0; year < DEPTH; year++)
        begin
            entry = yearTable[year];
            $display("year: %d, key: %h\n",
                     entry[19:4], entry[3:0]);
        end

    end
endmodule
