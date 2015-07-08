`include "tasks.sv"

`timescale 1ns/1ns

// Counter preload testcase.

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

    logic [WIDTH-1:0]    when_to_preload;

    logic                clk;
    logic                reset;
    logic                enable;
    logic                preload;
    logic   [WIDTH-1:0]  preload_data;
    logic                mode;
    bit                  failed = 0;
    bit                  reset_at_right_time = 0;
    bit                  saw_a_preload = 0;

    initial forever @(detect) begin
        failed = failed || (detect != (result == (1 << WIDTH)-1));
    end

    initial forever @(posedge clk)
        if (result == when_to_preload) begin
            preload_data = $urandom_range(0, (1 << WIDTH)-1);

            preload = 1;

            @(posedge clk);
                preload = 0;
                 
            $display("preloaded with: preload_data: %d", preload_data);
        end

    initial forever @(preload) begin
        if (result == when_to_preload) begin
            $display("case 1: result, when_to_preload, saw_a_preload, failed: %d, %d, %b, %b",
                              result, when_to_preload, saw_a_preload, failed);
            saw_a_preload = 1;
        end
        else if (saw_a_preload) begin
            failed = failed || (result != preload_data);
            $display("case 2: result, when_to_preload, saw_a_preload, failed: %d, %d, %b, %b",
                              result, when_to_preload, saw_a_preload, failed);
            saw_a_preload = 0;
        end
    end

    initial begin
        $monitor("t=%3t: result=%2d, detect=%b", $time, result, detect);

        init(reset, enable, preload, mode);

        // Take the DUT out of reset:
        @(posedge clk);

        @(posedge clk)
            reset = 0;

        @(posedge clk);
            enable = 1;

        when_to_preload = $urandom_range(0, (1 << WIDTH)-1);
        $display("when_to_preload: %d", when_to_preload);

        repeat (1 << WIDTH) @(posedge clk);
        enable = 0;

        repeat (10) @(posedge clk) $finish;
    end

    final begin
        if (failed)
            $display("testcase_counter_disable_count: FAIL");
        else
            $display("testcase_counter_disable_count: PASS");
    end

endprogram



