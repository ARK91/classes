// Stand-alone test inside program block

program testcase(input bit clk,
                 output logic           reset,
                 output logic           we_sys,
                 output logic           cmd_valid_sys,
                 output logic [7:0]     addr_sys,
                 ref    logic [7:0]     data_sys,
                 input logic    ready_sys
                );

    initial begin
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

            addr_sys      = 0;
            cmd_valid_sys = 0;
        end

        #10 $finish;
    end

endprogram
