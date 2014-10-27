// File: coconuts_tb.v
// John Hubbard, 26 Oct 2014
// hw6 assignment for Verilog 0764 class: Problem 6.8.7. Coconut and Monkey Puzzle
//

`timescale 1ns/1ns
module coconuts_tb;
    integer coconuts_tb;
    integer man_tb[5];
    integer big_pile_tb[5];
    wire [2:0]monkey_tb;
    wire valid_tb;
    integer total_tb;

    coconut_allocator DUT(coconuts_tb,
                          man_tb[0], man_tb[1], man_tb[2], man_tb[3], man_tb[4],
                          big_pile_tb[0], big_pile_tb[1], big_pile_tb[2], big_pile_tb[3], big_pile_tb[4],
                          monkey_tb, valid_tb);

    always @(*)
    begin
        total_tb = man_tb[0] + man_tb[1] + man_tb[2] + man_tb[3] + man_tb[4] +
                    monkey_tb + (big_pile_tb[4] - 1);
    end

    always @(*)
    begin
        if (valid_tb)
        begin
            $display(
                "Num coconuts to start with: %d\n", coconuts_tb,
                "Num coconuts after man 1 stole + 1 to monkey: %d\n", big_pile_tb[0],
                "Num coconuts after man 2 stole + 1 to monkey: %d\n", big_pile_tb[1],
                "Num coconuts after man 3 stole + 1 to monkey: %d\n", big_pile_tb[2],
                "Num coconuts after man 4 stole + 1 to monkey: %d\n", big_pile_tb[3],
                "Num coconuts after man 5 stole + 1 to monkey: %d\n", big_pile_tb[4],
                "Num coconuts in the morning when 5 men got up: %d\n", big_pile_tb[4],

                "Man 1 got: (stole %d + 1/5(%d), or %d): %d\n", man_tb[0], big_pile_tb[4], big_pile_tb[4]/5, man_tb[0] + big_pile_tb[4]/5,
                "Man 2 got: (stole %d + 1/5(%d), or %d): %d\n", man_tb[1], big_pile_tb[4], big_pile_tb[4]/5, man_tb[1] + big_pile_tb[4]/5,
                "Man 3 got: (stole %d + 1/5(%d), or %d): %d\n", man_tb[2], big_pile_tb[4], big_pile_tb[4]/5, man_tb[2] + big_pile_tb[4]/5,
                "Man 4 got: (stole %d + 1/5(%d), or %d): %d\n", man_tb[3], big_pile_tb[4], big_pile_tb[4]/5, man_tb[3] + big_pile_tb[4]/5,
                "Man 5 got: (stole %d + 1/5(%d), or %d): %d\n", man_tb[4], big_pile_tb[4], big_pile_tb[4]/5, man_tb[4] + big_pile_tb[4]/5,
                "Monkey got: %d\n", monkey_tb,
                "Total: %d\n", total_tb);
        end
    end

    // Test pattern:
    initial
    begin
        for (coconuts_tb = 0; coconuts_tb < 100000; coconuts_tb++)
        begin
            #10;
        end
    end
endmodule

/* Sample test run:
vlog ../*.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module coconut_allocator
# -- Compiling module coconuts_tb
#
# Top level modules:
#   coconuts_tb
vsim work.coconuts_tb
# vsim work.coconuts_tb
# Loading sv_std.std
# Loading work.coconuts_tb
# Loading work.coconut_allocator
run 1000000
# Num coconuts to start with:       15621
# Num coconuts after man 1 stole + 1 to monkey:       12496
# Num coconuts after man 2 stole + 1 to monkey:        9996
# Num coconuts after man 3 stole + 1 to monkey:        7996
# Num coconuts after man 4 stole + 1 to monkey:        6396
# Num coconuts after man 5 stole + 1 to monkey:        5116
# Num coconuts in the morning when 5 men got up:        5116
# Man 1 got: (stole        3124 + 1/5(       5116), or        1023):        4147
# Man 2 got: (stole        2499 + 1/5(       5116), or        1023):        3522
# Man 3 got: (stole        1999 + 1/5(       5116), or        1023):        3022
# Man 4 got: (stole        1599 + 1/5(       5116), or        1023):        2622
# Man 5 got: (stole        1279 + 1/5(       5116), or        1023):        2302
# Monkey got: 6
# Total:       15621
#
# Num coconuts to start with:       31246
# Num coconuts after man 1 stole + 1 to monkey:       24996
# Num coconuts after man 2 stole + 1 to monkey:       19996
# Num coconuts after man 3 stole + 1 to monkey:       15996
# Num coconuts after man 4 stole + 1 to monkey:       12796
# Num coconuts after man 5 stole + 1 to monkey:       10236
# Num coconuts in the morning when 5 men got up:       10236
# Man 1 got: (stole        6249 + 1/5(      10236), or        2047):        8296
# Man 2 got: (stole        4999 + 1/5(      10236), or        2047):        7046
# Man 3 got: (stole        3999 + 1/5(      10236), or        2047):        6046
# Man 4 got: (stole        3199 + 1/5(      10236), or        2047):        5246
# Man 5 got: (stole        2559 + 1/5(      10236), or        2047):        4606
# Monkey got: 6
# Total:       31246
#
# Num coconuts to start with:       46871
# Num coconuts after man 1 stole + 1 to monkey:       37496
# Num coconuts after man 2 stole + 1 to monkey:       29996
# Num coconuts after man 3 stole + 1 to monkey:       23996
# Num coconuts after man 4 stole + 1 to monkey:       19196
# Num coconuts after man 5 stole + 1 to monkey:       15356
# Num coconuts in the morning when 5 men got up:       15356
# Man 1 got: (stole        9374 + 1/5(      15356), or        3071):       12445
# Man 2 got: (stole        7499 + 1/5(      15356), or        3071):       10570
# Man 3 got: (stole        5999 + 1/5(      15356), or        3071):        9070
# Man 4 got: (stole        4799 + 1/5(      15356), or        3071):        7870
# Man 5 got: (stole        3839 + 1/5(      15356), or        3071):        6910
# Monkey got: 6
# Total:       46871
#
# Num coconuts to start with:       62496
# Num coconuts after man 1 stole + 1 to monkey:       49996
# Num coconuts after man 2 stole + 1 to monkey:       39996
# Num coconuts after man 3 stole + 1 to monkey:       31996
# Num coconuts after man 4 stole + 1 to monkey:       25596
# Num coconuts after man 5 stole + 1 to monkey:       20476
# Num coconuts in the morning when 5 men got up:       20476
# Man 1 got: (stole       12499 + 1/5(      20476), or        4095):       16594
# Man 2 got: (stole        9999 + 1/5(      20476), or        4095):       14094
# Man 3 got: (stole        7999 + 1/5(      20476), or        4095):       12094
# Man 4 got: (stole        6399 + 1/5(      20476), or        4095):       10494
# Man 5 got: (stole        5119 + 1/5(      20476), or        4095):        9214
# Monkey got: 6
# Total:       62496
#
# Num coconuts to start with:       78121
# Num coconuts after man 1 stole + 1 to monkey:       62496
# Num coconuts after man 2 stole + 1 to monkey:       49996
# Num coconuts after man 3 stole + 1 to monkey:       39996
# Num coconuts after man 4 stole + 1 to monkey:       31996
# Num coconuts after man 5 stole + 1 to monkey:       25596
# Num coconuts in the morning when 5 men got up:       25596
# Man 1 got: (stole       15624 + 1/5(      25596), or        5119):       20743
# Man 2 got: (stole       12499 + 1/5(      25596), or        5119):       17618
# Man 3 got: (stole        9999 + 1/5(      25596), or        5119):       15118
# Man 4 got: (stole        7999 + 1/5(      25596), or        5119):       13118
# Man 5 got: (stole        6399 + 1/5(      25596), or        5119):       11518
# Monkey got: 6
# Total:       78121
#
# Num coconuts to start with:       93746
# Num coconuts after man 1 stole + 1 to monkey:       74996
# Num coconuts after man 2 stole + 1 to monkey:       59996
# Num coconuts after man 3 stole + 1 to monkey:       47996
# Num coconuts after man 4 stole + 1 to monkey:       38396
# Num coconuts after man 5 stole + 1 to monkey:       30716
# Num coconuts in the morning when 5 men got up:       30716
# Man 1 got: (stole       18749 + 1/5(      30716), or        6143):       24892
# Man 2 got: (stole       14999 + 1/5(      30716), or        6143):       21142
# Man 3 got: (stole       11999 + 1/5(      30716), or        6143):       18142
# Man 4 got: (stole        9599 + 1/5(      30716), or        6143):       15742
# Man 5 got: (stole        7679 + 1/5(      30716), or        6143):       13822
# Monkey got: 6
# Total:       93746
#

*/
