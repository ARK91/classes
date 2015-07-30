`include "packet.sv"

module testbench();

    packet ethernet;
    bit    clk;

    always #10 clk = ~clk;

    initial begin
        ethernet = new();

        #100 $finish;
    end

    switch switch0(.clk(clk),
                   .src_addr (ethernet.src_addr),
                   .src_data (ethernet.src_data),
                   .dst_addr (dst_addr),
                   .dst_data (dst_data));

endmodule
