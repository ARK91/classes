`timescale 1ns/1ns

program testcase #(parameter WIDTH=4)
    (clk,
    reset,
    enable,
    preload,
    preload_data,
    mode,
    detect,
    result);

    input                clk;
    output               reset;
    output               enable;
    output               preload;
    output  [WIDTH-1:0]  preload_data;
    output               mode;
    input                detect;
    input [WIDTH-1:0]    result;

    logic                clk;
    logic                reset;
    logic                enable;
    logic                preload;
    logic   [WIDTH-1:0]  preload_data;
    logic                mode;
    bit                  failed = 0;

    clocking cb @(posedge clk);
        default input #1step;
        default output #0;

        input #0 enable;

    endclocking

    default clocking system_clk @(posedge clk);
        default input #1step;
        default output #0;

        output  enable;
        output  preload;
        output  preload_data;
        output  mode;
        input   detect;
        input   result;

    endclocking

    initial forever @(detect)
        failed <= failed || (detect != (result == (1 << WIDTH)-1));

    initial begin
        $monitor("t=%3t: result=%2d, detect=%b", $time, result, detect);

        reset = 1;
        failed = 0;
        enable = 0;
        preload = 0;
        mode = 0;
        preload_data = '0;

        @(system_clk)
            reset = 0;

        ##1 enable = 1;

        repeat (1 << WIDTH + 2) @(system_clk);
        enable = 0;

        repeat (10) @(system_clk) $finish;
    end

    final begin
        if (failed)
            $display("TEST_RESULT: FAIL");
        else
            $display("TEST_RESULT: PASS");
    end

endprogram



