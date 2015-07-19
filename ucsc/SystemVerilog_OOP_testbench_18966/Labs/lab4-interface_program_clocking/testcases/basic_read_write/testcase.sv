// Stand-alone test inside program block

program testcase(input bit clk,
                 output logic           reset,
                 output logic           we_sys,
                 output logic           cmd_valid_sys,
                 output logic [7:0]     addr_sys,
                 ref    logic [7:0]     data_sys,
                 input logic    ready_sys
                );

    // Simulation variables:
    int nReads    = 0;
    int nWrites   = 0;
    bit done      = 0;
    int idleCount = 0;

    initial begin
        // DUT variables:
        reset         = 1;
        we_sys        = 0;
        cmd_valid_sys = 0;
        addr_sys      = 0;
        data_sys      = 8'bz;


        #100 reset = 0;

        for (int i = 0; i < 4; i++) begin
            @(posedge clk);
            addr_sys      = i;
            data_sys      = $urandom_range(0, 255);
            cmd_valid_sys = 1;
            we_sys        = 1;

            @(posedge ready_sys);
            $display("%5dns: Writing: address=%0d, data_sys (written)=8'h%2h",
                     $time, i, data_sys);

            ++nWrites;

            @(posedge clk);
            addr_sys      = 0;
            data_sys      = 8'bz;
            cmd_valid_sys = 0;
            we_sys        = 0;
        end

        $display("\n");

        repeat (10) @(posedge clk);

        for (int i = 0; i < 4; i++) begin
            @(posedge clk);
            addr_sys      = i;
            cmd_valid_sys = 1;
            we_sys        = 0;

            @(posedge ready_sys);
            @(posedge clk);
            $display("%5dns: Reading: address=%0d, data_sys(read)=8'h%2h",
                     $time, i, data_sys);

            ++nReads;

            addr_sys      = 0;
            cmd_valid_sys = 0;
        end

        // Wait for the bus to be idle for 100 cycles. This is an indication
        // that we are done with the simulation:

        $display("Waiting for 100 cycles of bus idleness...");

        done = 0;
        while(!done) begin
            @(posedge clk);

            if (addr_sys == 0)
                idleCount++;

            done = (idleCount >= 100);
        end

        $finish;
    end

    final begin
        $display("Number of reads:  %3d", nReads);
        $display("Number of writes: %3d", nWrites);
        $display("TEST RESULT: PASS");
    end

endprogram
