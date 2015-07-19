// basic read-write: testcase.sv
// For SystemVerilog OOP Testbench class, lab4 (Interface-program-clocking)
// John Hubbard, 19 Jul 2015 (Sunday)

program testcase(interface tcif);

    // Simulation variables:
    int nReads    = 0;
    int nWrites   = 0;
    bit done      = 0;
    int idleCount = 0;

    initial begin
        // DUT variables:
        tcif.reset         = 1;
        tcif.we_sys        = 0;
        tcif.cmd_valid_sys = 0;
        tcif.addr_sys      = 0;
        tcif.data_sys      = 8'bz;


        #100 tcif.reset = 0;

        for (int i = 0; i < 4; i++) begin
            @(posedge tcif.clk);
            tcif.addr_sys      = i;
            tcif.data_sys      = $urandom_range(0, 255);
            tcif.cmd_valid_sys = 1;
            tcif.we_sys        = 1;

            @(posedge tcif.ready_sys);
            $display("%5dns: Writing: address=%0d, tcif.data_sys (written)=8'h%2h",
                     $time, i, tcif.data_sys);

            ++nWrites;

            @(posedge tcif.clk);
            tcif.addr_sys      = 0;
            tcif.data_sys      = 8'bz;
            tcif.cmd_valid_sys = 0;
            tcif.we_sys        = 0;
        end

        $display("\n");

        repeat (10) @(posedge tcif.clk);

        for (int i = 0; i < 4; i++) begin
            @(posedge tcif.clk);
            tcif.addr_sys      = i;
            tcif.cmd_valid_sys = 1;
            tcif.we_sys        = 0;

            @(posedge tcif.ready_sys);
            @(posedge tcif.clk);
            $display("%5dns: Reading: address=%0d, tcif.data_sys(read)=8'h%2h",
                     $time, i, tcif.data_sys);

            ++nReads;

            tcif.addr_sys      = 0;
            tcif.cmd_valid_sys = 0;
        end

        // Wait for the bus to be idle for 100 cycles. This is an indication
        // that we are done with the simulation:

        $display("Waiting for 100 cycles of bus idleness...");

        done = 0;
        while(!done) begin
            @(posedge tcif.clk);

            if (tcif.addr_sys == 0)
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
