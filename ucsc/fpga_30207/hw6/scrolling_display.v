// File: scrolling_display.v
// John Hubbard, 08 Mar 2015
//
// hw6: Implement a scrolling display, that can display any number, up to
// 10-digits long.
//
// To compile:
// vlog ../scrolling_display.v ../display_at_n_second.v ../hex2_7seg.v
//      ../binary2bcd.v ../seg7.v
//
// vsim work.scrolling_display_test -L unisims_ver

`timescale 1ns/1ns

module scrolling_display(clk, reset, seg, an, inputNumber, outputNumber, getNextNumber);
    parameter N = 70; // 70 bits can contain 10 digits.
    input clk, reset, getNextNumber;
    input [N-1:0]inputNumber;
    output [0:7-1] seg;
    output [4-1:0] an;
    output reg [N-1:0]outputNumber;

    wire getNextNumber;
    wire [15:0]text;

    always @(posedge clk)
    begin
        if (reset)
            outputNumber = 70'd00_0000_0000;
        else if (getNextNumber)
        begin
            if (inputNumber <= 9999)
                outputNumber = inputNumber;
            else
                outputNumber = inputNumber * 10;
        end
    end

//  binary2bcd BCD(outputNumber[N-1-:16], text);
//  display_at_n_second #(1.0) D (clk, btnU, seg, an, text, getNextNumber);
endmodule

module scrolling_display_test(clk, btnU, seg, an);
    parameter N = 70; // 70 bits can contain 10 digits.
    input clk, btnU;
    output [0:7-1] seg;
    output [4-1:0] an;

    // These variables are only for modelsim runs:
    reg simReset;
    reg simClock;
    reg getNextNumber;

    reg [N-1:0]vec;
    wire [15:0]text;
    reg [N-1:0]inputNumber;
    wire [N-1:0]outputNumber;

    // TODO: change reset to btnU, for running on real board. Leave it alone,
    // for running in modelsim:
    //scrolling_display DUT(clk, btnU, seg, an, inputNumber, outputNumber);
    scrolling_display DUT(simClock, simReset, seg, an, inputNumber, outputNumber, getNextNumber);

    // Create a clock
    always
    begin
        #1; simClock <= ~simClock;
    end

    initial
    begin
        // Reset:
        simClock = 1'b0;
        simReset = 1'b0;
        getNextNumber = 1'b1;

        #1; simReset = 1'b1;
        #2; simReset = 1'b0;

        for (vec = 19; vec <= 70'd99_9999_9999; vec = vec + 2000)
        begin
            #1;
            inputNumber = vec;
            $display("simClock: %b, getNextNumber: %b, inputNumber: %d, outputNumber: %d",
                     simClock, getNextNumber, inputNumber, outputNumber);
        end
    end
endmodule

