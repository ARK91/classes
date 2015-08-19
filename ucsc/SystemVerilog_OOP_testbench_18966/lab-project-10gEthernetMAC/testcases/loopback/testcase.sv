// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "sim_types.sv"

program testcase(interface tcif_driver,
                 interface tcif_monitor);

    env env0;
    int num_packets;

    initial begin

        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        env0 = new(tcif_driver, tcif_monitor);

        num_packets = $urandom_range(4, 10);
        env0.run(num_packets,
                 `VERBOSITY_STANDARD,
                 `DEBUG_FLAGS_SIMPLE_LOOPBACK);

        // Need this for regression test accounting:
        $display("Testcase: loopback: PASS");

        #100 $finish;
    end

endprogram

