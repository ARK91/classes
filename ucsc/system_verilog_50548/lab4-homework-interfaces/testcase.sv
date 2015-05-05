`timescale 1ns/1ns

module testcase(output bit clk,
                memory_interface mif);

    bit         debug = 0;
    logic [7:0] rdata;

    initial begin
        #6000ns $display ( "MEMORY TEST TIMEOUT" );
        $finish;
    end

    always #5 clk = ~clk;

    initial
    begin
        int error_status;
        $display("Clearing the memory");

        for (int i = 0; i< 32; i++)
        begin
            mif.write_mem (i, 0, debug);
            $display("waddr=%h, wdata=%h", i, 0);
        end

        for (int i = 0; i<32; i++)
        begin
            mif.read_mem (i, rdata, debug);
            $display("raddr=%h, rdata=%h", i, rdata);
            if (rdata != 0)
                error_status++;
        end

        printstatus(error_status);

        $display("Data = Address Test");
        error_status = 0;

        for (int i = 0; i< 32; i++)
        begin
            mif.write_mem (i, i, debug);
            $display("waddr=%h, wdata=%h", i, i);
        end

        for (int i = 0; i<32; i++)
        begin
            mif.read_mem (i, rdata, debug);
            $display("raddr=%h, rdata=%h", i, rdata);
        if (rdata != i)
            error_status++;
        end

        printstatus(error_status);
        $finish;
    end


    function void printstatus (input int status);
    begin
        if (status != 0)
            $display ("Test Failed with %d Errors", status);
        else
            $display ("Test Passed");
    end
    endfunction

endmodule
