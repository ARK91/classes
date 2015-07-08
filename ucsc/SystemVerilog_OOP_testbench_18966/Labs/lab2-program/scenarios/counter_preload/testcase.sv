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

    initial forever @(detect) begin
        failed = failed || (detect != (result == (1 << WIDTH)-1));
    end

    initial forever @(negedge clk)
        if (result == when_to_preload) begin
                preload_data = $urandom_range(0, (1 << WIDTH)-1);
                $display("preloaded with: preload_data", preload_data);
        end

    initial forever @(result) begin
        if (result == when_to_preload)
            reset_at_right_time = 1;
    end

    initial begin
        $monitor("t=%3t: result=%2d, detect=%b", $time, result, detect);

        when_to_preload = $urandom_range(0, (1 << WIDTH)-1);
        $display("when_to_preload: %d", when_to_preload);

        init(clk, reset, enable, preload, preload_data, mode, detect, result);

        repeat (1 << WIDTH) @(posedge clk);
        enable = 0;

        repeat (10) @(posedge clk) $finish;
    end

    final begin
        failed = failed || (result != 0) || !reset_at_right_time;

        if (failed)
            $display("testcase_counter_disable_count: FAIL");
        else
            $display("testcase_counter_disable_count: PASS");
    end

endprogram



