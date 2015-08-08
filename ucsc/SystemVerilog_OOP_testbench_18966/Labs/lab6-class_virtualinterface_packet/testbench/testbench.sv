module testbench();
    bit    clk;

    always #10 clk = ~clk;

    switch_interface sif( .clk(clk) );

    switch switch0(.clk(clk),
                   .src_addr (sif.src_addr),
                   .src_data (sif.src_data),
                   .dst_addr (sif.dst_addr),
                   .dst_data (sif.dst_data));

    testcase itestcase(sif.testcase_port, sif.testcase_port);
endmodule
