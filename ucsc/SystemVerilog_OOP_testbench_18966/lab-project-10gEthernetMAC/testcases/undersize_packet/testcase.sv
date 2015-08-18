// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "sim_types.sv"

class undersize_packet_env extends env;

    function new(input virtual switch_interface vif,
                 input virtual switch_interface mif);

        super.new(vif, mif);
    endfunction

    virtual task run(int num_packets, int verbosity_level, int debug_flags);

        initialize_dut();

        for (int i = 0; i < num_packets; i++) begin

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: Sending undersize packet #%0d =================",
                         $time, i);

            m_drv.send_packet(i, debug_flags);

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: Setting up a receive case to trigger and error for undersize case #%0d ==============",
                         $time, i);

            m_mon.collect_error_packet(i);

            // Wait for ptk_rx_err to go high, as a result of the undersize packet:
            repeat(50) @(m_vi.cb);

            if (m_vi.cb.pkt_rx_err == 1'b1)
                $display("time: %0t PASS: Expected behavior for undersize packet case.", $time);
            else
                $display("time: %0t FAIL ***** Undersize packet case FAILED", $time);
        end
    endtask

endclass

program testcase(interface tcif_driver,
                 interface tcif_monitor);

    undersize_packet_env env0;
    int num_packets;

    initial begin

        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        env0 = new(tcif_driver, tcif_monitor);

        num_packets = $urandom_range(4, 10);
        env0.run(num_packets,
                 `VERBOSITY_STANDARD,
                 `DEBUG_FLAGS_UNDERSIZE_PACKET_ON_TX);

        #100 $finish;
    end

endprogram

