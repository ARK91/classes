`timescale 1ns/1ns

task automatic init #(parameter WIDTH=4)
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

    initial begin
        $display("init() task running");

        reset = 1;
        enable = 0;
        preload = 0;
        mode = 0;
        preload_data = '0;

        @(posedge clk)
            reset = 0;

        @(posedge clk);
        enable = 1;

    end

endtask

