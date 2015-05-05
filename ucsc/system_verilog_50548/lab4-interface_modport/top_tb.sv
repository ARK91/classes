`timescale 1ns/1ns

module top_tb();
    localparam  WIDTH = 4;
    logic clk = 0;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    counter_interface cif0         (.clk(clk));
    counter           counter0     (.clk(clk), .cif(cif0.counter_port));
    counter_test      counter_test0(.clk(clk), .cif(cif0.tb_port));

endmodule
