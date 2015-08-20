// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "sim_types.sv"

class missing_sop_env extends env;

    function new(input virtual switch_interface vif,
                 input virtual switch_interface mif,
                 input string testcase_display_string);

        super.new(vif, mif, testcase_display_string);
    endfunction

    virtual task run(int num_packets, int verbosity_level, int debug_flags);

        initialize_dut();

        for (int i = 0; i < num_packets; i++) begin

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: Sending: %s case #%0d ===============",
                         $time, m_testcase_display_string, i);

            m_drv.send_packet(i, debug_flags);

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: no packet should come back for: %s case #%0d ==============",
                         $time, m_testcase_display_string, i);

            // Wait 50 cycles to see if a packet comes back. It should not.
            repeat(50) @(m_vi.cb);

            m_passed = (m_vi.cb.pkt_rx_avail == 1'b0);
            report_intermediate_results();
        end

    endtask

endclass

program testcase(interface tcif_driver,
                 interface tcif_monitor);

    missing_sop_env env0;
    int num_packets;

    initial begin
        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        env0 = new(tcif_driver, tcif_monitor, "missing SOP");

        num_packets = $urandom_range(4, 10);
        env0.run(num_packets,
                 `VERBOSITY_STANDARD,
                 `DEBUG_FLAGS_SKIP_SOP_ON_TX);

        env0.report_testcase_results();

        #100 $finish;
    end
endprogram

