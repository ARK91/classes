// File: bin2bcd_tb.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.7: Binary to BCD converter
//
// Steps to run in ModelSim (on Linux this time):
// cd $HOME/git_wa/classes/ucsc/verilog_0764/hw5/f_bin2bcd/modelsim
// vlib work
// vlog -sv ../bin2bcd.v ../bin2bcd_tb.v
// vsim work.bin2bcd_tb
// run 400 ns
//

`timescale 1ns/1ns
module bin2bcd_tb;
    reg [7:0]bin_tb;
    wire [1:0]bcdHundreds_tb;
    wire [3:0]bcdTens_tb;
    wire [3:0]bcdOnes_tb;
    integer count;

    bin2bcd DUT(bin_tb, bcdHundreds_tb, bcdTens_tb, bcdOnes_tb);

    // This block prints whenever the inputs or outputs change:
    initial
    begin
        $monitor("Time %t: bin: %h bcd: %h %h %h ",
                 $time, bin_tb,
                 bcdHundreds_tb, bcdTens_tb, bcdOnes_tb);
    end

    // Test pattern: exhaustive inputs:
    initial
    begin
        for (count = 0; count < 256; count++)
        begin
            {bin_tb} = count[7:0];
            #10;
        end
    end
endmodule

/* Sample test run:
vlog ../*.v -sv
# Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
# -- Compiling module bin2bcd
# -- Compiling module shift_add3
# -- Compiling module bin2bcd_tb
#
# Top level modules:
#   bin2bcd_tb
vsim work.bin2bcd_tb
# vsim work.bin2bcd_tb
# Loading sv_std.std
# Loading work.bin2bcd_tb
# Loading work.bin2bcd
# Loading work.shift_add3
run 4000ns
# Time                    0: bin: 00 bcd: 0 0 0
# Time                   10: bin: 01 bcd: 0 0 1
# Time                   20: bin: 02 bcd: 0 0 2
# Time                   30: bin: 03 bcd: 0 0 3
# Time                   40: bin: 04 bcd: 0 0 4
# Time                   50: bin: 05 bcd: 0 0 5
# Time                   60: bin: 06 bcd: 0 0 6
# Time                   70: bin: 07 bcd: 0 0 7
# Time                   80: bin: 08 bcd: 0 0 8
# Time                   90: bin: 09 bcd: 0 0 9
# Time                  100: bin: 0a bcd: 0 1 0
# Time                  110: bin: 0b bcd: 0 1 1
# Time                  120: bin: 0c bcd: 0 1 2
# Time                  130: bin: 0d bcd: 0 1 3
# Time                  140: bin: 0e bcd: 0 1 4
# Time                  150: bin: 0f bcd: 0 1 5
# Time                  160: bin: 10 bcd: 0 1 6
# Time                  170: bin: 11 bcd: 0 1 7
# Time                  180: bin: 12 bcd: 0 1 8
# Time                  190: bin: 13 bcd: 0 1 9
# Time                  200: bin: 14 bcd: 0 2 0
# Time                  210: bin: 15 bcd: 0 2 1
# Time                  220: bin: 16 bcd: 0 2 2
# Time                  230: bin: 17 bcd: 0 2 3
# Time                  240: bin: 18 bcd: 0 2 4
# Time                  250: bin: 19 bcd: 0 2 5
# Time                  260: bin: 1a bcd: 0 2 6
# Time                  270: bin: 1b bcd: 0 2 7
# Time                  280: bin: 1c bcd: 0 2 8
# Time                  290: bin: 1d bcd: 0 2 9
# Time                  300: bin: 1e bcd: 0 3 0
# Time                  310: bin: 1f bcd: 0 3 1
# Time                  320: bin: 20 bcd: 0 3 2
# Time                  330: bin: 21 bcd: 0 3 3
# Time                  340: bin: 22 bcd: 0 3 4
# Time                  350: bin: 23 bcd: 0 3 5
# Time                  360: bin: 24 bcd: 0 3 6
# Time                  370: bin: 25 bcd: 0 3 7
# Time                  380: bin: 26 bcd: 0 3 8
# Time                  390: bin: 27 bcd: 0 3 9
# Time                  400: bin: 28 bcd: 0 4 0
# Time                  410: bin: 29 bcd: 0 4 1
# Time                  420: bin: 2a bcd: 0 4 2
# Time                  430: bin: 2b bcd: 0 4 3
# Time                  440: bin: 2c bcd: 0 4 4
# Time                  450: bin: 2d bcd: 0 4 5
# Time                  460: bin: 2e bcd: 0 4 6
# Time                  470: bin: 2f bcd: 0 4 7
# Time                  480: bin: 30 bcd: 0 4 8
# Time                  490: bin: 31 bcd: 0 4 9
# Time                  500: bin: 32 bcd: 0 5 0
# Time                  510: bin: 33 bcd: 0 5 1
# Time                  520: bin: 34 bcd: 0 5 2
# Time                  530: bin: 35 bcd: 0 5 3
# Time                  540: bin: 36 bcd: 0 5 4
# Time                  550: bin: 37 bcd: 0 5 5
# Time                  560: bin: 38 bcd: 0 5 6
# Time                  570: bin: 39 bcd: 0 5 7
# Time                  580: bin: 3a bcd: 0 5 8
# Time                  590: bin: 3b bcd: 0 5 9
# Time                  600: bin: 3c bcd: 0 6 0
# Time                  610: bin: 3d bcd: 0 6 1
# Time                  620: bin: 3e bcd: 0 6 2
# Time                  630: bin: 3f bcd: 0 6 3
# Time                  640: bin: 40 bcd: 0 6 4
# Time                  650: bin: 41 bcd: 0 6 5
# Time                  660: bin: 42 bcd: 0 6 6
# Time                  670: bin: 43 bcd: 0 6 7
# Time                  680: bin: 44 bcd: 0 6 8
# Time                  690: bin: 45 bcd: 0 6 9
# Time                  700: bin: 46 bcd: 0 7 0
# Time                  710: bin: 47 bcd: 0 7 1
# Time                  720: bin: 48 bcd: 0 7 2
# Time                  730: bin: 49 bcd: 0 7 3
# Time                  740: bin: 4a bcd: 0 7 4
# Time                  750: bin: 4b bcd: 0 7 5
# Time                  760: bin: 4c bcd: 0 7 6
# Time                  770: bin: 4d bcd: 0 7 7
# Time                  780: bin: 4e bcd: 0 7 8
# Time                  790: bin: 4f bcd: 0 7 9
# Time                  800: bin: 50 bcd: 0 8 0
# Time                  810: bin: 51 bcd: 0 8 1
# Time                  820: bin: 52 bcd: 0 8 2
# Time                  830: bin: 53 bcd: 0 8 3
# Time                  840: bin: 54 bcd: 0 8 4
# Time                  850: bin: 55 bcd: 0 8 5
# Time                  860: bin: 56 bcd: 0 8 6
# Time                  870: bin: 57 bcd: 0 8 7
# Time                  880: bin: 58 bcd: 0 8 8
# Time                  890: bin: 59 bcd: 0 8 9
# Time                  900: bin: 5a bcd: 0 9 0
# Time                  910: bin: 5b bcd: 0 9 1
# Time                  920: bin: 5c bcd: 0 9 2
# Time                  930: bin: 5d bcd: 0 9 3
# Time                  940: bin: 5e bcd: 0 9 4
# Time                  950: bin: 5f bcd: 0 9 5
# Time                  960: bin: 60 bcd: 0 9 6
# Time                  970: bin: 61 bcd: 0 9 7
# Time                  980: bin: 62 bcd: 0 9 8
# Time                  990: bin: 63 bcd: 0 9 9
# Time                 1000: bin: 64 bcd: 1 0 0
# Time                 1010: bin: 65 bcd: 1 0 1
# Time                 1020: bin: 66 bcd: 1 0 2
# Time                 1030: bin: 67 bcd: 1 0 3
# Time                 1040: bin: 68 bcd: 1 0 4
# Time                 1050: bin: 69 bcd: 1 0 5
# Time                 1060: bin: 6a bcd: 1 0 6
# Time                 1070: bin: 6b bcd: 1 0 7
# Time                 1080: bin: 6c bcd: 1 0 8
# Time                 1090: bin: 6d bcd: 1 0 9
# Time                 1100: bin: 6e bcd: 1 1 0
# Time                 1110: bin: 6f bcd: 1 1 1
# Time                 1120: bin: 70 bcd: 1 1 2
# Time                 1130: bin: 71 bcd: 1 1 3
# Time                 1140: bin: 72 bcd: 1 1 4
# Time                 1150: bin: 73 bcd: 1 1 5
# Time                 1160: bin: 74 bcd: 1 1 6
# Time                 1170: bin: 75 bcd: 1 1 7
# Time                 1180: bin: 76 bcd: 1 1 8
# Time                 1190: bin: 77 bcd: 1 1 9
# Time                 1200: bin: 78 bcd: 1 2 0
# Time                 1210: bin: 79 bcd: 1 2 1
# Time                 1220: bin: 7a bcd: 1 2 2
# Time                 1230: bin: 7b bcd: 1 2 3
# Time                 1240: bin: 7c bcd: 1 2 4
# Time                 1250: bin: 7d bcd: 1 2 5
# Time                 1260: bin: 7e bcd: 1 2 6
# Time                 1270: bin: 7f bcd: 1 2 7
# Time                 1280: bin: 80 bcd: 1 2 8
# Time                 1290: bin: 81 bcd: 1 2 9
# Time                 1300: bin: 82 bcd: 1 3 0
# Time                 1310: bin: 83 bcd: 1 3 1
# Time                 1320: bin: 84 bcd: 1 3 2
# Time                 1330: bin: 85 bcd: 1 3 3
# Time                 1340: bin: 86 bcd: 1 3 4
# Time                 1350: bin: 87 bcd: 1 3 5
# Time                 1360: bin: 88 bcd: 1 3 6
# Time                 1370: bin: 89 bcd: 1 3 7
# Time                 1380: bin: 8a bcd: 1 3 8
# Time                 1390: bin: 8b bcd: 1 3 9
# Time                 1400: bin: 8c bcd: 1 4 0
# Time                 1410: bin: 8d bcd: 1 4 1
# Time                 1420: bin: 8e bcd: 1 4 2
# Time                 1430: bin: 8f bcd: 1 4 3
# Time                 1440: bin: 90 bcd: 1 4 4
# Time                 1450: bin: 91 bcd: 1 4 5
# Time                 1460: bin: 92 bcd: 1 4 6
# Time                 1470: bin: 93 bcd: 1 4 7
# Time                 1480: bin: 94 bcd: 1 4 8
# Time                 1490: bin: 95 bcd: 1 4 9
# Time                 1500: bin: 96 bcd: 1 5 0
# Time                 1510: bin: 97 bcd: 1 5 1
# Time                 1520: bin: 98 bcd: 1 5 2
# Time                 1530: bin: 99 bcd: 1 5 3
# Time                 1540: bin: 9a bcd: 1 5 4
# Time                 1550: bin: 9b bcd: 1 5 5
# Time                 1560: bin: 9c bcd: 1 5 6
# Time                 1570: bin: 9d bcd: 1 5 7
# Time                 1580: bin: 9e bcd: 1 5 8
# Time                 1590: bin: 9f bcd: 1 5 9
# Time                 1600: bin: a0 bcd: 1 6 0
# Time                 1610: bin: a1 bcd: 1 6 1
# Time                 1620: bin: a2 bcd: 1 6 2
# Time                 1630: bin: a3 bcd: 1 6 3
# Time                 1640: bin: a4 bcd: 1 6 4
# Time                 1650: bin: a5 bcd: 1 6 5
# Time                 1660: bin: a6 bcd: 1 6 6
# Time                 1670: bin: a7 bcd: 1 6 7
# Time                 1680: bin: a8 bcd: 1 6 8
# Time                 1690: bin: a9 bcd: 1 6 9
# Time                 1700: bin: aa bcd: 1 7 0
# Time                 1710: bin: ab bcd: 1 7 1
# Time                 1720: bin: ac bcd: 1 7 2
# Time                 1730: bin: ad bcd: 1 7 3
# Time                 1740: bin: ae bcd: 1 7 4
# Time                 1750: bin: af bcd: 1 7 5
# Time                 1760: bin: b0 bcd: 1 7 6
# Time                 1770: bin: b1 bcd: 1 7 7
# Time                 1780: bin: b2 bcd: 1 7 8
# Time                 1790: bin: b3 bcd: 1 7 9
# Time                 1800: bin: b4 bcd: 1 8 0
# Time                 1810: bin: b5 bcd: 1 8 1
# Time                 1820: bin: b6 bcd: 1 8 2
# Time                 1830: bin: b7 bcd: 1 8 3
# Time                 1840: bin: b8 bcd: 1 8 4
# Time                 1850: bin: b9 bcd: 1 8 5
# Time                 1860: bin: ba bcd: 1 8 6
# Time                 1870: bin: bb bcd: 1 8 7
# Time                 1880: bin: bc bcd: 1 8 8
# Time                 1890: bin: bd bcd: 1 8 9
# Time                 1900: bin: be bcd: 1 9 0
# Time                 1910: bin: bf bcd: 1 9 1
# Time                 1920: bin: c0 bcd: 1 9 2
# Time                 1930: bin: c1 bcd: 1 9 3
# Time                 1940: bin: c2 bcd: 1 9 4
# Time                 1950: bin: c3 bcd: 1 9 5
# Time                 1960: bin: c4 bcd: 1 9 6
# Time                 1970: bin: c5 bcd: 1 9 7
# Time                 1980: bin: c6 bcd: 1 9 8
# Time                 1990: bin: c7 bcd: 1 9 9
# Time                 2000: bin: c8 bcd: 2 0 0
# Time                 2010: bin: c9 bcd: 2 0 1
# Time                 2020: bin: ca bcd: 2 0 2
# Time                 2030: bin: cb bcd: 2 0 3
# Time                 2040: bin: cc bcd: 2 0 4
# Time                 2050: bin: cd bcd: 2 0 5
# Time                 2060: bin: ce bcd: 2 0 6
# Time                 2070: bin: cf bcd: 2 0 7
# Time                 2080: bin: d0 bcd: 2 0 8
# Time                 2090: bin: d1 bcd: 2 0 9
# Time                 2100: bin: d2 bcd: 2 1 0
# Time                 2110: bin: d3 bcd: 2 1 1
# Time                 2120: bin: d4 bcd: 2 1 2
# Time                 2130: bin: d5 bcd: 2 1 3
# Time                 2140: bin: d6 bcd: 2 1 4
# Time                 2150: bin: d7 bcd: 2 1 5
# Time                 2160: bin: d8 bcd: 2 1 6
# Time                 2170: bin: d9 bcd: 2 1 7
# Time                 2180: bin: da bcd: 2 1 8
# Time                 2190: bin: db bcd: 2 1 9
# Time                 2200: bin: dc bcd: 2 2 0
# Time                 2210: bin: dd bcd: 2 2 1
# Time                 2220: bin: de bcd: 2 2 2
# Time                 2230: bin: df bcd: 2 2 3
# Time                 2240: bin: e0 bcd: 2 2 4
# Time                 2250: bin: e1 bcd: 2 2 5
# Time                 2260: bin: e2 bcd: 2 2 6
# Time                 2270: bin: e3 bcd: 2 2 7
# Time                 2280: bin: e4 bcd: 2 2 8
# Time                 2290: bin: e5 bcd: 2 2 9
# Time                 2300: bin: e6 bcd: 2 3 0
# Time                 2310: bin: e7 bcd: 2 3 1
# Time                 2320: bin: e8 bcd: 2 3 2
# Time                 2330: bin: e9 bcd: 2 3 3
# Time                 2340: bin: ea bcd: 2 3 4
# Time                 2350: bin: eb bcd: 2 3 5
# Time                 2360: bin: ec bcd: 2 3 6
# Time                 2370: bin: ed bcd: 2 3 7
# Time                 2380: bin: ee bcd: 2 3 8
# Time                 2390: bin: ef bcd: 2 3 9
# Time                 2400: bin: f0 bcd: 2 4 0
# Time                 2410: bin: f1 bcd: 2 4 1
# Time                 2420: bin: f2 bcd: 2 4 2
# Time                 2430: bin: f3 bcd: 2 4 3
# Time                 2440: bin: f4 bcd: 2 4 4
# Time                 2450: bin: f5 bcd: 2 4 5
# Time                 2460: bin: f6 bcd: 2 4 6
# Time                 2470: bin: f7 bcd: 2 4 7
# Time                 2480: bin: f8 bcd: 2 4 8
# Time                 2490: bin: f9 bcd: 2 4 9
# Time                 2500: bin: fa bcd: 2 5 0
# Time                 2510: bin: fb bcd: 2 5 1
# Time                 2520: bin: fc bcd: 2 5 2
# Time                 2530: bin: fd bcd: 2 5 3
# Time                 2540: bin: fe bcd: 2 5 4
# Time                 2550: bin: ff bcd: 2 5 5
*/
