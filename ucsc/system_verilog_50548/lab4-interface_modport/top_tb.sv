module top_tb();
  localparam  WIDTH = 4;
  logic clk = 0;
  
  initial begin
     clk = 0;
     forever #5 clk = ~clk;
  end

  counter_interface cif0         (.port	(signal), ...);
  counter           counter0     (.port	(signal), ...);
  counter_test      counter_test0(.port	(signal), ...);

endmodule
