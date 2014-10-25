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
    reg [1:0]select_tb, beer_tb, wine_tb, rum_tb, whiskey_tb;
    wire f_tb;
    integer count, bev;

    major DUT(select_tb, beer_tb, wine_tb, rum_tb, whiskey_tb, f_tb);

    // This block prints whenever the inputs of outputs change, for either
    // the DUT or the DUT_REFERENCE instantiations:
    initial
    begin
        $monitor("Time %t, a: %b%b%b%b%b, f: %b, reftb: %b",
                 $time, atb[4], atb[3], atb[2], atb[1], atb[0], ftb, reftb);
    end

    // Test pattern: exhaustive inputs, but selective checks for MUX input-to-
    // output comparisons:
    initial
    begin
        for (count = 0; count < 4; count++)
        begin
            {select_tb} = count;
            for (bev = 0; bev < 16; bev++)
            begin
                {beer_tb, wine_tb, rum_tb, whiskey_tb} = bev;

                if (count == 0 && f_tb != beer_tb)
                    $display("Test failure: count: $d, f_tb: %b\n", count, f_tb);
                else if (count == 0 && f_tb != wine_tb)
                    $display("Test failure: count: $d, f_tb: %b\n", count, f_tb);
                else if (count == 0 && f_tb != rum_tb)
                    $display("Test failure: count: $d, f_tb: %b\n", count, f_tb);
                else if (count == 0 && f_tb != whiskey_tb)
                    $display("Test failure: count: $d, f_tb: %b\n", count, f_tb);
                #10;
            end // beverage
        end // count (select line)

        $display("DONE\n");
    end
endmodule

/* Sample test run:
*/
