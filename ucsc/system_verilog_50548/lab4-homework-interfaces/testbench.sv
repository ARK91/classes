`timescale 1ns/1ns

module testbench;
  bit clk;
  logic [7:0] debug_data;

// Instantiate interface here 
    memory_interface mem0(.clk(clk));

// Instantiate memory design here
    mem DUT(.clk(clk), .mif(mem0.mem_port));

// Instantiate testcase here
    testcase TEST0(.clk(clk), .mif(mem0.tb_port));

endmodule
