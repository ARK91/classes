`include "packet.sv"

module testbench();

    packet ethernet;
    bit    clk;

    // These are just for the testbench, to complete wiring up the switch
    // module:
    logic [47:0] dst_addr;
    logic [31:0] dst_data;

    always #10 clk = ~clk;

    switch_interface sif( .clk(clk) );

    initial begin
        ethernet = new();

        for (int i = 0; i < 4; i++) begin
            assert(ethernet.randomize());

            // Assign the ethernet object to the switch interface:
            sif.src_addr = ethernet.src_addr;
            sif.src_data = ethernet.src_data;

            $display("Packet #%2d: ethernet.src_addr=%h, .src_data=%h",
                     i, ethernet.src_addr, ethernet.src_data);

        #100 $finish;
    end

    switch switch0(.clk(clk),
                   .src_addr (sif.src_addr),
                   .src_data (sif.src_data),
                   .dst_addr (dst_addr),
                   .dst_data (dst_data));

endmodule
