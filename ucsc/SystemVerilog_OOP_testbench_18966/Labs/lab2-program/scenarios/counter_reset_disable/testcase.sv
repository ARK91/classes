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

    logic [WIDTH-1:0]    when_to_reset;

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
        if (result == when_to_reset) begin
                reset = 1;
                enable = 0;
        end

    initial forever @(result) begin
        if (result == when_to_reset)
            reset_at_right_time = 1;
    end

    initial begin
        $monitor("t=%3t: result=%2d, detect=%b", $time, result, detect);

        when_to_reset = $urandom_range(0, (1 << WIDTH)-1);
        $display("when_to_reset: %d", when_to_reset);

        reset = 1;
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
        failed = failed || (result != 0) || !reset_at_right_time;

        if (failed)
            $display("TEST_RESULT: FAIL");
        else
            $display("TEST_RESULT: PASS");
    end

endprogram



