// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "sim_types.sv"

// This test is still under construction. The DEBUG_FLAG_SKIP_SOP_ON_TX
// is still being ignored by the .run() method, so this test acts, for now,
// just like the simple loopback test (DEBUG_FLAGS_SIMPLE_LOOPBACK).

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
                 VERBOSITY_STANDARD,
                 DEBUG_FLAG_SKIP_SOP_ON_TX);

        #100 $finish;
    end

endprogram

