`timescale 1ns/1ns

module memory_tb();
    int         numAccess;

    // Free-running clock
    logic clk = 0;
    always #10 clk = ~clk;

    mem_if mif();
    // Instantiate Interface and DUT
    memory mem0(.clk     (clk),
                .bus_mem (mif));

    //=================================================
    // Test Vector generation
    //=================================================
    initial begin
        mif.reset = 1;
        mif.ce = 1'b0;
        mif.we = 1'b0;
        mif.addr = 0;
        mif.datai = 0;
        repeat (10) @ (posedge clk);
        mif.reset = 0;

        //Specify number of Write and Read operations
        numAccess = $urandom_range(4, 8);

        //Write Access
        $display ("========== Writing to Memory==========");
        for (int i = 0; i < numAccess; i ++ ) begin
            @ (posedge clk) mif.ce = 1'b1;
            mif.we = 1'b1;
            mif.addr = i;
            mif.datai = $urandom_range(8'h00, 8'hff);
            @ (posedge clk) mif.ce = 1'b0;
            $display ("%0dns: Write access address %0h, data %0h",
                      $time, mif.addr, mif.datai);
        end

        //Read Access
        $display ("========== Reading from Memory==========");
        for (int i = 0; i < numAccess; i ++ ) begin
            @ (posedge clk) mif.ce = 1'b1;
            mif.we = 1'b0;
            mif.addr = i;
            repeat (2) @ (posedge clk);
            mif.ce = 1'b0;
            $display ("%0dns: Read access address %0h, data %0h",
                      $time, mif.addr, mif.datao);
        end
        #10 $finish;
    end

endmodule
