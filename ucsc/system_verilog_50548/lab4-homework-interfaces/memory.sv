module mem(input        clk,
	   input        read,
	   input        write, 
	   input  [4:0] addr  ,
	   input  [7:0] data_in  ,
           output [7:0] data_out
	   );

logic [7:0] memory [0:31] ;
logic [7:0] data_out;
  
  always @(posedge clk)
    if (write && !read)
      #1 memory[addr] <= data_in;

  always_ff @(posedge clk iff (read == 1'b1) )
       data_out <= memory[addr];

endmodule
