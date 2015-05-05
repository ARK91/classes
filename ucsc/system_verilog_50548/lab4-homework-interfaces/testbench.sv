`timescale 1ns/1ns

module testbench;
  bit clk;

// Instantiate interface here 
  memory_interface mem0(.clk(clk));

// Instantiate memory design here
    mem(.clk(clk), .mif(mem0.mem_port));

// Instantiate testcase here
    testcase(.clk(clk), .mif(mem0.tb_port));

endmodule
