module testbench();
    bit    clk;

    // These are just for the testbench, to complete wiring up the switch
    // module:
    logic [47:0] dst_addr;
    logic [31:0] dst_data;

    always #10 clk = ~clk;

    switch_interface sif( .clk(clk) );

    switch switch0(.clk(clk),
                   .src_addr (sif.src_addr),
                   .src_data (sif.src_data),
                   .dst_addr (dst_addr),
                   .dst_data (dst_data));

    testcase itestcase(sif.testcase_port);
endmodule
