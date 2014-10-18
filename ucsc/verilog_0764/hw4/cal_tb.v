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
//    1950/02/07: Tuesday
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
//    <sandstorm> hw4 (master)$ cal 2 1950
//      February 1950
//    Su Mo Tu We Th Fr Sa
//            1  2  3  4
//     5  6  7  8  9 10 11
//    12 13 14 15 16 17 18
//    19 20 21 22 23 24 25
//    26 27 28
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
    integer year;
    reg [WIDTH - 1:0] entry;
    reg [WIDTH - 1:0] yearTable[DEPTH - 1:0];
    integer yeartb, monthtb, daytb, dayOfWeektb, errorFlagtb;

    cal DUT(yeartb, monthtb, daytb, dayOfWeektb, errorFlagtb);

    initial
    begin
        #10 yeartb = 1200; monthtb = 01; daytb = 15; // Should set error flag
        #10 if (!errorFlagtb)
            #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                     yeartb, monthtb, daytb, dayOfWeektb);
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        // Yes, I will be relieved when we get to "subroutines". Copy and paste
        // like a mad monkey until then:

        #10 yeartb = 1840; monthtb = 01; daytb = 15; // Wednesday
        #10 if (!errorFlagtb)
            #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                     yeartb, monthtb, daytb, dayOfWeektb);
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 1950; monthtb = 02; daytb = 07; // Tuesday
        #10 if (!errorFlagtb)
            #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                     yeartb, monthtb, daytb, dayOfWeektb);
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 1980; monthtb = 03; daytb = 29; // Saturday
        #10 if (!errorFlagtb)
            #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                     yeartb, monthtb, daytb, dayOfWeektb);
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 2000; monthtb = 04; daytb = 09; // Sunday
        #10 if (!errorFlagtb)
            #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                     yeartb, monthtb, daytb, dayOfWeektb);
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

        #10 yeartb = 2014; monthtb = 05; daytb = 19; // Monday
        #10 if (!errorFlagtb)
            #10 $display("%d/%d/%d: %d (0 == Sunday, 1 == Monday, ...)\n",
                     yeartb, monthtb, daytb, dayOfWeektb);
        else
            #10 $display("%d/%d/%d: ERROR: out of range\n",
                     yeartb, monthtb, daytb);

    end
endmodule
