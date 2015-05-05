`timescale 1ns/1ns

module testcase(output bit clk,
                memory_interface mif);

    bit         debug = 1;
    logic [7:0] rdata;

    initial begin
        #4000ns $display ( "MEMORY TEST TIMEOUT" );
        $finish;
    end

    always #5 clk = ~clk;

    initial
    begin
        int error_status;
        $display("Clearing the memory");

        for (int i = 0; i< 32; i++)
        begin
            write_mem (i, 0, debug);
            $display("waddr=%h, wdata=%h", i, 0);
        end

        for (int i = 0; i<32; i++)
        begin
            read_mem (i, rdata, debug);
            $display("raddr=%h, rdata=%h", i, rdata);
            if (rdata != 0)
                error_status++;
        end

        printstatus(error_status);

        $display("Data = Address Test");
        error_status = 0;

        for (int i = 0; i< 32; i++)
        begin
        write_mem (i, i, debug);
        $display("waddr=%h, wdata=%h", i, i);
        end

        for (int i = 0; i<32; i++)
        begin
            read_mem (i, rdata, debug);
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

    task write_mem(input logic [4:0] addr, input logic [7:0] data, input debug);
        //implement write logic here
        mif.write <= 1'b1;
        mif.read  <= 1'b0;
        mif.addr[4:0] <= addr[4:0];
        mif.datain[7:0] <= data[7:0];
    endtask

    task read_mem(input logic [4:0] addr, output logic [7:0] data, input debug);
        //implement read logic here
        mif.write <= 1'b0;
        mif.read  <= 1'b1;
        mif.addr[4:0] <= addr[4:0];
        data[7:0] <= mif.dataout[7:0];
    endtask
endmodule
