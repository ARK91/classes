`timescale 1ns/1ns

program testcase(input  wire        clk,
                 output logic [7:0] din,
                 input  wire  [7:0] dout,
                 output logic [7:0] addr,
                 output logic       ce,
                 output logic       we
                );

    // Clocking block

    default clocking ramcb @(posedge clk);
        input #1 dout;
        output #2 din, addr, ce, we;

    endclocking

    initial begin

        // Initialize program block outputs
        ramcb.addr <= 0;
        ramcb.din  <= 0;
        ramcb.ce   <= 0;
        ramcb.we   <= 0;

        // ========== Write Operation to Ram ==========
        $display("========== WRITE OPERATION TO RAM ====================");

        for (int i = 0; i < 4; i++) begin

            repeat (2) @(posedge clk);
            //repeat (2) @(ramcb);
            //#2;

            ramcb.addr <= i;
            ramcb.din  <= $urandom_range(0, 255);
            ramcb.ce   <= 1; //ramcb.ce=1 --> Chip Enable
            ramcb.we   <= 1; //ramcb.we=1 --> WRITE Enable

            repeat (2) @(posedge clk);
            ramcb.ce <= 0;

            $display("t=%5t: WRITE: ramcb.addr=%2h, ramcb.din=%2h, dout=%2h, ramcb.we=%2h, ramcb.ce=%2h",
                   $time, addr, din,dout,we,ce);
        end


        // ========== Read Operation from Ram ==========
        $display("\n");
        $display("========== READ OPERATION FROM RAM ====================");

        for (int i = 0; i < 4; i++) begin

            repeat (1) @(posedge clk);
            ramcb.addr <= i;
            ramcb.ce   <= 1;
            ramcb.we   <= 0; //ramcb.we=0 --> READ Enable

            repeat (3) @(posedge clk);
            ramcb.ce <= 0;

            $display("t=%5t: READ : ramcb.addr=%2h, ramcb.din=%2h, dout=%2h, ramcb.we=%2h, ramcb.ce=%2h",
                   $time, addr, din,dout,we,ce);
        end

        repeat(10) @(clk) $finish;
    end

endprogram


