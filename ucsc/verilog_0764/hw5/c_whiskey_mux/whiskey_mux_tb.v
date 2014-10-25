// File: whiskey_mux_tb.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.3: Liquid dispenser MUX
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw5/c_whiskey_mux/modelsim
// vlib work
// vlog -sv ../whiskey_mux.v ../whiskey_mux_tb.v
// vsim work.whiskey_mux_tb
// run 400 ns
//

`timescale 1ns/1ns
module whiskey_mux_tb;
    reg [1:0]select_tb;
    reg beer_tb, wine_tb, rum_tb, whiskey_tb;
    wire f_tb;
    integer count, bev;

    whiskey_mux DUT(select_tb, beer_tb, wine_tb, rum_tb, whiskey_tb, f_tb);

    // This block prints whenever the inputs of outputs change, for either
    // the DUT or the DUT_REFERENCE instantiations:
    initial
    begin
        $monitor("Time %t, beer, wine, rum, whiskey: %b%b%b%b, ",
                 $time, beer_tb, wine_tb, rum_tb, whiskey_tb,
                 "sel: %b%b, f_tb: %b", select_tb[1:1], select_tb[0:0], f_tb);
    end

    // Test pattern: exhaustive inputs, but selective checks for MUX input-to-
    // output comparisons:
    initial
    begin
        for (count = 0; count < 4; count++)
        begin
            {select_tb} = count[1:0];
            for (bev = 0; bev < 16; bev++)
            begin
                {beer_tb, wine_tb, rum_tb, whiskey_tb} = bev[3:0];
                #10;

                if (count == 0 && f_tb != beer_tb)
                    $display("beer failure: sel: %b%b, beer: %b, f_tb: %b",
                             select_tb[1:1], select_tb[0:0], beer_tb, f_tb);
                else if (count == 1 && f_tb != wine_tb)
                    $display("Wine failure: sel: %b%b, wine_tb: %b, f_tb: %b",
                             select_tb[1:1], select_tb[0:0], wine_tb, f_tb);
                else if (count == 2 && f_tb != rum_tb)
                    $display("Rum failure: sel: %b%b, rum_tb: %b, f_tb: %b",
                             select_tb[1:1], select_tb[0:0], rum_tb, f_tb);
                else if (count == 3 && f_tb != whiskey_tb)
                    $display("Whiskey failure: sel: %b%b, whiskey_tb: %b, f_tb: %b",
                             select_tb[1:1], select_tb[0:0], whiskey_tb, f_tb);
            end // beverage
        end // count (select line)

        $display("DONE\n");
    end
endmodule

/* Sample test run:

vlog -sv ../*.v
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module whiskey_mux
# -- Compiling module whiskey_mux_tb
#
# Top level modules:
#   whiskey_mux_tb
run 400 ns
vsim work.whiskey_mux_tb
# vsim work.whiskey_mux_tb
# Loading sv_std.std
# Loading work.whiskey_mux_tb
# Loading work.whiskey_mux
run 2000ns
# Time                    0, beer, wine, rum, whiskey: 0000, sel: 00, f_tb: 0
# Time                   10, beer, wine, rum, whiskey: 0001, sel: 00, f_tb: 0
# Time                   20, beer, wine, rum, whiskey: 0010, sel: 00, f_tb: 0
# Time                   30, beer, wine, rum, whiskey: 0011, sel: 00, f_tb: 0
# Time                   40, beer, wine, rum, whiskey: 0100, sel: 00, f_tb: 0
# Time                   50, beer, wine, rum, whiskey: 0101, sel: 00, f_tb: 0
# Time                   60, beer, wine, rum, whiskey: 0110, sel: 00, f_tb: 0
# Time                   70, beer, wine, rum, whiskey: 0111, sel: 00, f_tb: 0
# Time                   80, beer, wine, rum, whiskey: 1000, sel: 00, f_tb: 1
# Time                   90, beer, wine, rum, whiskey: 1001, sel: 00, f_tb: 1
# Time                  100, beer, wine, rum, whiskey: 1010, sel: 00, f_tb: 1
# Time                  110, beer, wine, rum, whiskey: 1011, sel: 00, f_tb: 1
# Time                  120, beer, wine, rum, whiskey: 1100, sel: 00, f_tb: 1
# Time                  130, beer, wine, rum, whiskey: 1101, sel: 00, f_tb: 1
# Time                  140, beer, wine, rum, whiskey: 1110, sel: 00, f_tb: 1
# Time                  150, beer, wine, rum, whiskey: 1111, sel: 00, f_tb: 1
# Time                  160, beer, wine, rum, whiskey: 0000, sel: 01, f_tb: 0
# Time                  170, beer, wine, rum, whiskey: 0001, sel: 01, f_tb: 0
# Time                  180, beer, wine, rum, whiskey: 0010, sel: 01, f_tb: 0
# Time                  190, beer, wine, rum, whiskey: 0011, sel: 01, f_tb: 0
# Time                  200, beer, wine, rum, whiskey: 0100, sel: 01, f_tb: 1
# Time                  210, beer, wine, rum, whiskey: 0101, sel: 01, f_tb: 1
# Time                  220, beer, wine, rum, whiskey: 0110, sel: 01, f_tb: 1
# Time                  230, beer, wine, rum, whiskey: 0111, sel: 01, f_tb: 1
# Time                  240, beer, wine, rum, whiskey: 1000, sel: 01, f_tb: 0
# Time                  250, beer, wine, rum, whiskey: 1001, sel: 01, f_tb: 0
# Time                  260, beer, wine, rum, whiskey: 1010, sel: 01, f_tb: 0
# Time                  270, beer, wine, rum, whiskey: 1011, sel: 01, f_tb: 0
# Time                  280, beer, wine, rum, whiskey: 1100, sel: 01, f_tb: 1
# Time                  290, beer, wine, rum, whiskey: 1101, sel: 01, f_tb: 1
# Time                  300, beer, wine, rum, whiskey: 1110, sel: 01, f_tb: 1
# Time                  310, beer, wine, rum, whiskey: 1111, sel: 01, f_tb: 1
# Time                  320, beer, wine, rum, whiskey: 0000, sel: 10, f_tb: 0
# Time                  330, beer, wine, rum, whiskey: 0001, sel: 10, f_tb: 0
# Time                  340, beer, wine, rum, whiskey: 0010, sel: 10, f_tb: 1
# Time                  350, beer, wine, rum, whiskey: 0011, sel: 10, f_tb: 1
# Time                  360, beer, wine, rum, whiskey: 0100, sel: 10, f_tb: 0
# Time                  370, beer, wine, rum, whiskey: 0101, sel: 10, f_tb: 0
# Time                  380, beer, wine, rum, whiskey: 0110, sel: 10, f_tb: 1
# Time                  390, beer, wine, rum, whiskey: 0111, sel: 10, f_tb: 1
# Time                  400, beer, wine, rum, whiskey: 1000, sel: 10, f_tb: 0
# Time                  410, beer, wine, rum, whiskey: 1001, sel: 10, f_tb: 0
# Time                  420, beer, wine, rum, whiskey: 1010, sel: 10, f_tb: 1
# Time                  430, beer, wine, rum, whiskey: 1011, sel: 10, f_tb: 1
# Time                  440, beer, wine, rum, whiskey: 1100, sel: 10, f_tb: 0
# Time                  450, beer, wine, rum, whiskey: 1101, sel: 10, f_tb: 0
# Time                  460, beer, wine, rum, whiskey: 1110, sel: 10, f_tb: 1
# Time                  470, beer, wine, rum, whiskey: 1111, sel: 10, f_tb: 1
# Time                  480, beer, wine, rum, whiskey: 0000, sel: 11, f_tb: 0
# Time                  490, beer, wine, rum, whiskey: 0001, sel: 11, f_tb: 1
# Time                  500, beer, wine, rum, whiskey: 0010, sel: 11, f_tb: 0
# Time                  510, beer, wine, rum, whiskey: 0011, sel: 11, f_tb: 1
# Time                  520, beer, wine, rum, whiskey: 0100, sel: 11, f_tb: 0
# Time                  530, beer, wine, rum, whiskey: 0101, sel: 11, f_tb: 1
# Time                  540, beer, wine, rum, whiskey: 0110, sel: 11, f_tb: 0
# Time                  550, beer, wine, rum, whiskey: 0111, sel: 11, f_tb: 1
# Time                  560, beer, wine, rum, whiskey: 1000, sel: 11, f_tb: 0
# Time                  570, beer, wine, rum, whiskey: 1001, sel: 11, f_tb: 1
# Time                  580, beer, wine, rum, whiskey: 1010, sel: 11, f_tb: 0
# Time                  590, beer, wine, rum, whiskey: 1011, sel: 11, f_tb: 1
# Time                  600, beer, wine, rum, whiskey: 1100, sel: 11, f_tb: 0
# Time                  610, beer, wine, rum, whiskey: 1101, sel: 11, f_tb: 1
# Time                  620, beer, wine, rum, whiskey: 1110, sel: 11, f_tb: 0
# Time                  630, beer, wine, rum, whiskey: 1111, sel: 11, f_tb: 1
# DONE
#
*/
