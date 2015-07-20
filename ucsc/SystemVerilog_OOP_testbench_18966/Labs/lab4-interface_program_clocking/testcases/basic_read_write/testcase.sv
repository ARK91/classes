// basic read-write: testcase.sv
// For SystemVerilog OOP Testbench class, lab4 (Interface-program-clocking)
// John Hubbard, 19 Jul 2015 (Sunday)

`timescale 1ns/1ns

program testcase(interface tcif);

    // Simulation variables:
    int nReads    = 0;
    int nWrites   = 0;
    bit done      = 0;
    int idleCount = 0;

    initial begin
        // DUT variables:
        tcif.memcb.reset         <= 1;
        tcif.memcb.we_sys        <= 0;
        tcif.memcb.cmd_valid_sys <= 0;
        tcif.memcb.addr_sys      <= 0;
        tcif.memcb.data_sys      <= 8'bz;


        #100 tcif.memcb.reset <= 0;

        for (int i = 0; i < 4; i++) begin
            @(tcif.memcb);
            tcif.memcb.addr_sys      <= i;
            tcif.memcb.data_sys      <= $urandom_range(0, 255);
            tcif.memcb.cmd_valid_sys <= 1;
            tcif.memcb.we_sys        <= 1;

            @(posedge tcif.memcb.ready_sys);
            $display("%5dns: Writing: address=%0d, data_sys (written)=8'h%2h",
                     $time, i, tcif.memcb.data_sys);

            ++nWrites;

            @(tcif.memcb);
            tcif.memcb.addr_sys      <= 0;
            tcif.memcb.data_sys      <= 8'bz;
            tcif.memcb.cmd_valid_sys <= 0;
            tcif.memcb.we_sys        <= 0;
        end

        $display("\n");

        repeat (10) @(tcif.memcb);
        //##10; // fails to compile

        for (int i = 0; i < 4; i++) begin
            @(tcif.memcb);
            tcif.memcb.addr_sys      <= i;
            tcif.memcb.cmd_valid_sys <= 1;
            tcif.memcb.we_sys        <= 0;

            @(posedge tcif.memcb.ready_sys);
            @(tcif.memcb);
            $display("%5dns: Reading: address=%0d, data_sys(read)=8'h%2h",
                     $time, i, tcif.memcb.data_sys);

            ++nReads;

            tcif.memcb.addr_sys      <= 0;
            tcif.memcb.cmd_valid_sys <= 0;
        end

        ##10 tcif.memcb.data_sys <= 0;

        // Wait for the bus to be idle for 100 cycles. This is an indication
        // that we are done with the simulation:

        $display("Waiting for 100 cycles of bus idleness...");

        done = 0;
        while(!done) begin
            @(tcif.memcb);

            if (tcif.memcb.data_sys == 0)
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

