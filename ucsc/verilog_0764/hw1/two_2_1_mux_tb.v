// File: two_2_1_mux_tb.v
// John Hubbard, 25 Sep 2014
// hw1 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw1
// vlib work
// vlog two_2_1_mux.v two_2_1_mux_tb.v
// vsim work.two_2_1_mux_tb
// add wave *
// run 10 ns
//

`timescale 1ns/1ns
module two_2_1_mux_tb;
    reg ta, tb, tselect;
    wire tf;
    reg [3:0] vec;

    two_2_1_mux DUT(ta, tb, tselect, tf);

    initial
    begin
        for (vec = 0; vec < 8; vec = vec +1)
        begin
            {ta, tb, tselect} = vec ;
            #1 $display("time %t ",$time,
                        "ta, tb, tselect %b%b%b", ta, tb, tselect,
                        ":::tf %b", tf) ;
        end
    end
endmodule

/* Results:

vlog two*.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module two_2_1_mux
# -- Compiling module two_2_1_mux_tb
#
# Top level modules:
#   two_2_1_mux_tb
vsim work.two_2_1_mux_tb
# vsim work.two_2_1_mux_tb
# Loading work.two_2_1_mux_tb
# Loading work.two_2_1_mux
add wave *
run 10 ns
# time                    1 ta, tb, tselect 000:::tf 0
# time                    2 ta, tb, tselect 001:::tf 0
# time                    3 ta, tb, tselect 010:::tf 1
# time                    4 ta, tb, tselect 011:::tf 0
# time                    5 ta, tb, tselect 100:::tf 0
# time                    6 ta, tb, tselect 101:::tf 1
# time                    7 ta, tb, tselect 110:::tf 1
# time                    8 ta, tb, tselect 111:::tf 1

*/
