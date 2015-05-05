`timescale 1ns/1ns

module mem(input bit clk,
           memory_interface mif);

    logic [7:0] memory [0:31] ;
  
    always @(posedge clk)
    if (mif.write && !mif.read)
        #1 memory[mif.addr] <= mif.data_in;

    always_ff @(posedge clk iff (mif.read == 1'b1))
        mif.data_out <= memory[mif.addr];

endmodule
