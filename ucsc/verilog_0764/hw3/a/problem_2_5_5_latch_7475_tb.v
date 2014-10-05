// File: problem_2_5_5_latch_7475_tb.v
// John Hubbard, 04 Oct 2014
// hw3 assignment
// Steps to run in ModelSim:
//
// cd D:/git_wa/classes/ucsc/verilog_0764/hw3/a/modelsim
// vlib work
// vlog -sv ../*.v
// vsim work.problem_2_5_5_latch_7475_tb
// add wave *
// run 20 ns
//

`timescale 1ns/1ns
module problem_2_5_5_latch_7475_tb;
    reg td1, td2, td3, td4, tc12, tc34;
    wire tq1, tq2, tq3, tq4;
    reg [3:0] vec12;
    reg [3:0] vec34;

    problem_2_5_5_latch_7475 DUT(td1, td2, td3, td4, tc12, tc34,
                                 tq1, tq2, tq3, tq4);

    // Testing approach: provide coverage for each pair of latches. These
    // tests run in parallel and don't depend on each other.
    //
    // If we wanted very thorough coverage, to ensure that the latch pairs
    // are independent of each other, then we'd want to go through the entire
    // set of all possible input combinations. But in this case, we can tell
    // by inspection of the module code that c12 and c34 latch pairs are
    // completely independent, so this testing approach will suffice.
    //
    initial
    begin
        for (vec12 = 0; vec12 < 8; vec12++)
        begin
            {tc12,td1,td2} = vec12 ;
            #1 $display("time %t ",$time,
                        "tc12, td1, td2: %b%b%b", tc12, td1, td2,
                        "::: tq1, tq2: %b%b", tq1, tq2);
        end
    end

    initial

    begin
        for (vec34 = 0; vec34 < 8; vec34++)
        begin
            {tc34,td3,td4} = vec34 ;
            #1 $display("time %t ",$time,
                        "tc34, td3, td4: %b%b%b", tc34, td3, td4,
                        "::: tq3, tq4: %b%b", tq3, tq4);
        end
    end

endmodule

/* Results:

problem_2_5_2_basic_gates_tb test run:

vlog ../*.v  -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module problem_2_5_5_latch_7475
# -- Compiling module problem_2_5_5_latch_7475_tb
#
# Top level modules:
#   problem_2_5_5_latch_7475_tb
vsim work.problem_2_5_5_latch_7475_tb
# vsim work.problem_2_5_5_latch_7475_tb
# Loading sv_std.std
# Loading work.problem_2_5_5_latch_7475_tb
# Loading work.problem_2_5_5_latch_7475
add wave *
run 20 ns
# time                    1 tc12, td1, td2: 000::: tq1, tq2: xx
# time                    1 tc34, td3, td4: 000::: tq3, tq4: xx
# time                    2 tc12, td1, td2: 001::: tq1, tq2: xx
# time                    2 tc34, td3, td4: 001::: tq3, tq4: xx
# time                    3 tc12, td1, td2: 010::: tq1, tq2: xx
# time                    3 tc34, td3, td4: 010::: tq3, tq4: xx
# time                    4 tc12, td1, td2: 011::: tq1, tq2: xx
# time                    4 tc34, td3, td4: 011::: tq3, tq4: xx
# time                    5 tc12, td1, td2: 100::: tq1, tq2: 00
# time                    5 tc34, td3, td4: 100::: tq3, tq4: 00
# time                    6 tc12, td1, td2: 101::: tq1, tq2: 01
# time                    6 tc34, td3, td4: 101::: tq3, tq4: 01
# time                    7 tc12, td1, td2: 110::: tq1, tq2: 10
# time                    7 tc34, td3, td4: 110::: tq3, tq4: 10
# time                    8 tc12, td1, td2: 111::: tq1, tq2: 11
# time                    8 tc34, td3, td4: 111::: tq3, tq4: 11

*/
