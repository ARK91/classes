`timescale 1ns/1ns

program testcase_counter_count2max_bug #(parameter WIDTH=4)
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
    input               detect;
    input [WIDTH-1:0]   result;

    logic                clk;
    logic                reset;
    logic                enable;
    logic                preload;
    logic   [WIDTH-1:0]  preload_data;
    logic                mode;
    bit                  failed = 0;

    initial forever @(detect)
	if (result == (1 << WIDTH)-1)
	    failed <= (detect == 1'b0);
	else
	    failed <= (detect == 1'b1);

    initial begin
        $monitor("t=%3t: result=%2d, detect=%b", $time, result, detect);


        reset = 1;
	failed = 1;
        enable = 0;
        preload = 0;
        mode = 0;
        preload_data = '0;

        @(posedge clk)
            reset = 0;

        @(posedge clk);
        enable = 1;

        repeat (1 << WIDTH) @(posedge clk);
        enable = 0;

        repeat (10) @(posedge clk) $finish;
    end

    final begin
	if (failed == 1)
	    $display("testcase_counter_count2max_bug: FAIL");
	else
	    $display("testcase_counter_count2max_bug: PASS");
    end

endprogram

