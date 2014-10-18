// File: cal_tb.v
// John Hubbard, 17 Oct 2014
// hw4 assignment for Verilog 0764 class
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw4/modelsim
// vlib work
// vlog -sv ../cal.v ../cal_tb.v
// vsim work.cal_tb
// run 100 ns
//
//    Dates selected: (year/month/day):
//
//    1840/01/15: Wednesday (leap year)
//    1950/04/07: Friday
//    1980/03/29: Saturday
//    2000/04/09: Sunday  (leap year)
//    2014/05/19: Monday
//
//    <sandstorm> hw4 (master)$ cal 1 1840
//      January 1840
//    Su Mo Tu We Th Fr Sa
//            1  2  3  4
//     5  6  7  8  9 10 11
//    12 13 14 15 16 17 18
//    19 20 21 22 23 24 25
//    26 27 28 29 30 31
//
//    <sandstorm> hw4 (master)$ cal 4 1950
//       April 1950
//    Su Mo Tu We Th Fr Sa
//                     1
//     2  3  4  5  6  7  8
//     9 10 11 12 13 14 15
//    16 17 18 19 20 21 22
//    23 24 25 26 27 28 29
//    30
//
//    <sandstorm> hw4 (master)$ cal 3 1980
//       March 1980
//    Su Mo Tu We Th Fr Sa
//                     1
//     2  3  4  5  6  7  8
//     9 10 11 12 13 14 15
//    16 17 18 19 20 21 22
//    23 24 25 26 27 28 29
//    30 31
//    <sandstorm> hw4 (master)$ cal 4 2000
//       April 2000
//    Su Mo Tu We Th Fr Sa
//                     1
//     2  3  4  5  6  7  8
//     9 10 11 12 13 14 15
//    16 17 18 19 20 21 22
//    23 24 25 26 27 28 29
//    30
//    <sandstorm> hw4 (master)$ cal 5 2014
//        May 2014
//    Su Mo Tu We Th Fr Sa
//               1  2  3
//     4  5  6  7  8  9 10
//    11 12 13 14 15 16 17
//    18 19 20 21 22 23 24
//    25 26 27 28 29 30 31
//

`timescale 1ns/1ns
module cal_tb;
    parameter DEPTH = 279; // 2033 - 1755 + 1
    parameter WIDTH = 20;
    reg [WIDTH - 1:0] entry;
    reg [WIDTH - 1:0] yearTable[DEPTH - 1:0];
    integer yeartb, monthtb, daytb, dayOfWeektb, errorFlagtb;

    cal DUT(yeartb, monthtb, daytb, dayOfWeektb, errorFlagtb);

    initial
    begin
        #10 yeartb = 1200; monthtb = 01; daytb = 15; // Should set error flag
        #10 if (!errorFlagtb)
            #10 $display("Year %d: FAIL", yeartb);
        else
            #10 $display("%d/%d/%d: PASS: out of range, as expected.\n",
                     yeartb, monthtb, daytb);

        // Yes, I will be relieved when we get to "subroutines". Copy and paste
        // like a mad monkey until then:

        #10 yeartb = 1840; monthtb = 01; daytb = 15; // Wednesday (day 4)
        #10 if (!errorFlagtb)
            begin
                #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                         yeartb, monthtb, daytb, dayOfWeektb);

                if (dayOfWeektb == 4)
                    $display("Year %d: PASS", yeartb);
                else
                    $display("Year %d: FAIL", yeartb);
            end
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 1950; monthtb = 04; daytb = 07; // Friday (day 5)
        #10 if (!errorFlagtb)
            begin
                #10 $display("%d/%d/%d: %d\n",
                         yeartb, monthtb, daytb, dayOfWeektb);

                if (dayOfWeektb == 5)
                    $display("Year %d: PASS", yeartb);
                else
                    $display("Year %d: FAIL", yeartb);
            end
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 1980; monthtb = 03; daytb = 29; // Saturday (day 6)
        #10 if (!errorFlagtb)
            begin
                #10 $display("%d/%d/%d: %d\n",
                         yeartb, monthtb, daytb, dayOfWeektb);

                if (dayOfWeektb == 6)
                    $display("Year %d: PASS", yeartb);
                else
                    $display("Year %d: FAIL", yeartb);
            end
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 2000; monthtb = 04; daytb = 09; // Sunday (day 0)
        #10 if (!errorFlagtb)
            begin
                #10 $display("%d/%d/%d: %d\n",
                         yeartb, monthtb, daytb, dayOfWeektb);

                if (dayOfWeektb == 0)
                    $display("Year %d: PASS", yeartb);
                else
                    $display("Year %d: FAIL", yeartb);
            end
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 2014; monthtb = 05; daytb = 19; // Monday (day 1)
        #10 if (!errorFlagtb)
            begin
                #10 $display("%d/%d/%d: %d\n",
                         yeartb, monthtb, daytb, dayOfWeektb);

                if (dayOfWeektb == 1)
                    $display("Year %d: PASS", yeartb);
                else
                    $display("Year %d: FAIL", yeartb);
            end
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

    end
endmodule

/* Sample test run:

vlog ../*.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module cal
# -- Compiling module cal_tb
#
# Top level modules:
#       cal_tb
vsim work.cal_tb
# vsim work.cal_tb
# Loading sv_std.std
# Loading work.cal_tb
# Loading work.cal
run 200 ns
#        1200/          1/         15: PASS: out of range, as expected.
#
#        1840/          1/         15:           4 (0 == Sunday, 1 == Monday, ...)
#
# Year        1840: PASS
#        1950/          4/          7:           5
#
# Year        1950: PASS
#        1980/          3/         29:           6
#
# Year        1980: PASS
#        2000/          4/          9:           0
#
# Year        2000: PASS
#        2014/          5/         19:           1
#
# Year        2014: PASS



*/
