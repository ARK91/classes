// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "sim_types.sv"

class loopback_env extends env;

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
                         $time, i, m_testcase_display_string);

            m_drv.send_packet(i, debug_flags);

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: Collecting packet #%0d ==============",
                         $time, i);

            m_mon.collect_packet(i, debug_flags);

            if (verbosity_level > 0)
                $display("==== time=%0t: Comparing packet #%0d ===============",
                         $time, i);

            // Scoreboard will update env.m_error_count, for use later by
            // env.report_testcase_results():
            m_sb.compare(verbosity_level, m_error_count);
        end

    endtask

endclass

program testcase(interface tcif_driver,
                 interface tcif_monitor);

    loopback_env env0;
    integer num_packets;

    initial begin
        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        env0 = new(tcif_driver, tcif_monitor, "loopback");

        num_packets = $urandom_range(4, 10);
        env0.run(num_packets,
                 `VERBOSITY_STANDARD,
                 `DEBUG_FLAGS_SIMPLE_LOOPBACK);

        env0.report_testcase_results();

        #100 $finish;
    end
endprogram

