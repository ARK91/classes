// testbench.sv

`timescale 1ns/1ns

module testbench();
    parameter WIDTH = 4;
    logic clk, reset, enable, preload, mode, detect;
    logic   [WIDTH-1:0]  preload_data;
    logic   [WIDTH-1:0]  result;

    initial begin
        clk = 0;

        // Enable Synopsys DVE (Discovery Visualization Environment):
        $vcdpluson();

        forever #5 clk = ~clk;
    end

    counter #(WIDTH) DUT(.*);

    testcase #(WIDTH) TEST_CASE(.*);

endmodule

