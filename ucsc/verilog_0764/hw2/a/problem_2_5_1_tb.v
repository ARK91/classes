// File: problem_2_5_1_tb.v
// John Hubbard, 03 Oct 2014
// hw2 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw2
// vlib work
// vlog -sv *.v
// vsim work.problem_2_5_1_tb
// add wave *
// run 10 ns
//

`timescale 1ns/1ns
module problem_2_5_1_tb;
    reg ta, tb, tc, td;
    wire tf;
    reg [5:0] vec;

    //funny_module_structural DUT(ta, tb, tc, td, tf);
    //funny_module_dataflow DUT(ta, tb, tc, td, tf);
    //funny_module_simplified_structural DUT(ta, tb, tc, td, tf);
    funny_module_simplified_dataflow DUT(ta, tb, tc, td, tf);

    initial
    begin
        for (vec = 0; vec < 16; vec = vec +1)
        begin
            {ta, tb, tc, td} = vec ;
            #1 $display("time %t ",$time,
                        "ta, tb, tc, td %b%b%b%b", ta, tb, tc, td,
                        ":::tf %b", tf) ;
        end
    end
endmodule

/* Results:

funny_module_structural test run:

vsim work.problem_2_5_1_tb
# vsim work.problem_2_5_1_tb
# Loading sv_std.std
# Loading work.problem_2_5_1_tb
# Loading work.funny_module_structural
add wave *
run 20 ns
# time                    1 ta, tb, tc, td 0000:::tf 1
# time                    2 ta, tb, tc, td 0001:::tf 1
# time                    3 ta, tb, tc, td 0010:::tf 1
# time                    4 ta, tb, tc, td 0011:::tf 1
# time                    5 ta, tb, tc, td 0100:::tf 1
# time                    6 ta, tb, tc, td 0101:::tf 1
# time                    7 ta, tb, tc, td 0110:::tf 1
# time                    8 ta, tb, tc, td 0111:::tf 1
# time                    9 ta, tb, tc, td 1000:::tf 1
# time                   10 ta, tb, tc, td 1001:::tf 1
# time                   11 ta, tb, tc, td 1010:::tf 1
# time                   12 ta, tb, tc, td 1011:::tf 1
# time                   13 ta, tb, tc, td 1100:::tf 1
# time                   14 ta, tb, tc, td 1101:::tf 1
# time                   15 ta, tb, tc, td 1110:::tf 1
# time                   16 ta, tb, tc, td 1111:::tf 1

funny_module_dataflow test run:
vlog *.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module funny_module_structural
# -- Compiling module funny_module_dataflow
# -- Compiling module problem_2_5_1_tb
#
# Top level modules:
#   funny_module_structural
#   problem_2_5_1_tb
vsim work.problem_2_5_1_tb
# vsim work.problem_2_5_1_tb
# Loading sv_std.std
# Loading work.problem_2_5_1_tb
# Loading work.funny_module_dataflow
add wave *
run 20 ns
# time                    1 ta, tb, tc, td 0000:::tf 1
# time                    2 ta, tb, tc, td 0001:::tf 1
# time                    3 ta, tb, tc, td 0010:::tf 1
# time                    4 ta, tb, tc, td 0011:::tf 1
# time                    5 ta, tb, tc, td 0100:::tf 1
# time                    6 ta, tb, tc, td 0101:::tf 1
# time                    7 ta, tb, tc, td 0110:::tf 1
# time                    8 ta, tb, tc, td 0111:::tf 1
# time                    9 ta, tb, tc, td 1000:::tf 1
# time                   10 ta, tb, tc, td 1001:::tf 1
# time                   11 ta, tb, tc, td 1010:::tf 1
# time                   12 ta, tb, tc, td 1011:::tf 1
# time                   13 ta, tb, tc, td 1100:::tf 1
# time                   14 ta, tb, tc, td 1101:::tf 1
# time                   15 ta, tb, tc, td 1110:::tf 1
# time                   16 ta, tb, tc, td 1111:::tf 1

funny_module_simplified_structural test run:

vlog *.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module funny_module_structural
# -- Compiling module funny_module_dataflow
# -- Compiling module funny_module_simplified_structural
# -- Compiling module funny_module_simplified_dataflow
# -- Compiling module problem_2_5_1_tb
#
# Top level modules:
#   funny_module_structural
#   funny_module_dataflow
#   funny_module_simplified_dataflow
#   problem_2_5_1_tb
vsim work.problem_2_5_1_tb
# vsim work.problem_2_5_1_tb
# Loading sv_std.std
# Loading work.problem_2_5_1_tb
# Loading work.funny_module_simplified_structural
add wave *
run 20ns
# time                    1 ta, tb, tc, td 0000:::tf 1
# time                    2 ta, tb, tc, td 0001:::tf 1
# time                    3 ta, tb, tc, td 0010:::tf 1
# time                    4 ta, tb, tc, td 0011:::tf 1
# time                    5 ta, tb, tc, td 0100:::tf 1
# time                    6 ta, tb, tc, td 0101:::tf 1
# time                    7 ta, tb, tc, td 0110:::tf 1
# time                    8 ta, tb, tc, td 0111:::tf 1
# time                    9 ta, tb, tc, td 1000:::tf 1
# time                   10 ta, tb, tc, td 1001:::tf 1
# time                   11 ta, tb, tc, td 1010:::tf 1
# time                   12 ta, tb, tc, td 1011:::tf 1
# time                   13 ta, tb, tc, td 1100:::tf 1
# time                   14 ta, tb, tc, td 1101:::tf 1
# time                   15 ta, tb, tc, td 1110:::tf 1
# time                   16 ta, tb, tc, td 1111:::tf 1

funny_module_simplified_dataflow test run:

vlog *.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module funny_module_structural
# -- Compiling module funny_module_dataflow
# -- Compiling module funny_module_simplified_structural
# -- Compiling module funny_module_simplified_dataflow
# -- Compiling module problem_2_5_1_tb
#
# Top level modules:
#   funny_module_structural
#   funny_module_dataflow
#   funny_module_simplified_structural
#   problem_2_5_1_tb
vsim work.problem_2_5_1_tb
# vsim work.problem_2_5_1_tb
# Loading sv_std.std
# Loading work.problem_2_5_1_tb
# Loading work.funny_module_simplified_dataflow
add wave *
run 20ns
# time                    1 ta, tb, tc, td 0000:::tf 1
# time                    2 ta, tb, tc, td 0001:::tf 1
# time                    3 ta, tb, tc, td 0010:::tf 1
# time                    4 ta, tb, tc, td 0011:::tf 1
# time                    5 ta, tb, tc, td 0100:::tf 1
# time                    6 ta, tb, tc, td 0101:::tf 1
# time                    7 ta, tb, tc, td 0110:::tf 1
# time                    8 ta, tb, tc, td 0111:::tf 1
# time                    9 ta, tb, tc, td 1000:::tf 1
# time                   10 ta, tb, tc, td 1001:::tf 1
# time                   11 ta, tb, tc, td 1010:::tf 1
# time                   12 ta, tb, tc, td 1011:::tf 1
# time                   13 ta, tb, tc, td 1100:::tf 1
# time                   14 ta, tb, tc, td 1101:::tf 1
# time                   15 ta, tb, tc, td 1110:::tf 1
# time                   16 ta, tb, tc, td 1111:::tf 1
*/
