// File: problem_2_5_2_basic_gates_tb.v
// John Hubbard, 03 Oct 2014
// hw2 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw2
// vlib work
// vlog -sv *.v
// vsim work.problem_2_5_2_basic_gates_tb
// add wave *
// run 20 ns
//

`timescale 1ns/1ns
module problem_2_5_2_basic_gates_tb;
    reg ta, tb;
    wire tf0, tf1, tf2, tf3, tf4, tf5;
    reg [2:0] vec;

    //problem_2_5_2_basic_gates_bdd DUT(ta, tb, tf0, tf1, tf2, tf3, tf4, tf5);
    problem_2_5_2_basic_gates_aig DUT(ta, tb, tf0, tf1, tf2, tf3, tf4, tf5);

    initial
    begin
        for (vec = 0; vec < 4; vec = vec +1)
        begin
            {ta, tb} = vec ;
            #1 $display("time %t ",$time,
                        "ta, tb %b%b", ta, tb,
                        ":::tf0(and): %b, tf1(or): %b, tf2(xor): %b, ",
                        tf0, tf1, tf2,
                        "tf3(nand): %b, tf4(nor): %b, tf5(xnor): %b",
                         tf3, tf4, tf5);
        end
    end
endmodule

/* Results:

problem_2_5_2_basic_gates test run:

vlog *.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module mux
# -- Compiling module problem_2_5_2_basic_gates
# -- Compiling module problem_2_5_2_basic_gates_tb
#
# Top level modules:
#   problem_2_5_2_basic_gates_tb
vsim work.problem_2_5_2_basic_gates_tb
# vsim work.problem_2_5_2_basic_gates_tb
# Loading work.problem_2_5_2_basic_gates_tb
# Loading work.problem_2_5_2_basic_gates
# Loading work.mux
add wave *
run 10ns
# time 1 ta, tb 00:::tf0(and): 0, tf1(or): 0, tf2(xor): 0, tf3(nand): 1, tf4(nor): 1, tf5(xnor): 1
# time 2 ta, tb 01:::tf0(and): 0, tf1(or): 1, tf2(xor): 1, tf3(nand): 1, tf4(nor): 0, tf5(xnor): 0
# time 3 ta, tb 10:::tf0(and): 0, tf1(or): 1, tf2(xor): 1, tf3(nand): 1, tf4(nor): 0, tf5(xnor): 0
# time 4 ta, tb 11:::tf0(and): 1, tf1(or): 1, tf2(xor): 0, tf3(nand): 0, tf4(nor): 0, tf5(xnor): 1

problem_2_5_2_basic_gates_aig test run:

vlog *.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module mux
# -- Compiling module problem_2_5_2_basic_gates_bdd
# -- Compiling module problem_2_5_2_basic_gates_aig
# -- Compiling module problem_2_5_2_basic_gates_tb
#
# Top level modules:
#   problem_2_5_2_basic_gates_bdd
#   problem_2_5_2_basic_gates_tb
vsim work.problem_2_5_2_basic_gates_tb
# vsim work.problem_2_5_2_basic_gates_tb
# Loading work.problem_2_5_2_basic_gates_tb
# Loading work.problem_2_5_2_basic_gates_aig
add wave *
run 10ns
# time 1 ta, tb 00:::tf0(and): 0, tf1(or): 0, tf2(xor): 0, tf3(nand): 1, tf4(nor): 1, tf5(xnor): 1
# time 2 ta, tb 01:::tf0(and): 0, tf1(or): 1, tf2(xor): 1, tf3(nand): 1, tf4(nor): 0, tf5(xnor): 0
# time 3 ta, tb 10:::tf0(and): 0, tf1(or): 1, tf2(xor): 1, tf3(nand): 1, tf4(nor): 0, tf5(xnor): 0
# time 4 ta, tb 11:::tf0(and): 1, tf1(or): 1, tf2(xor): 0, tf3(nand): 0, tf4(nor): 0, tf5(xnor): 1
*/
