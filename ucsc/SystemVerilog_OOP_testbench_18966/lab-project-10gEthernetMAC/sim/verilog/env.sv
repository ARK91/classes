// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "sim_types.sv"

class env;
    scoreboard m_sb;
    mailbox    m_drv2sb;
    mailbox    m_mon2sb;
    driver     m_drv;
    monitor    m_mon;

    string                   m_testcase_display_string;
    integer                  m_error_count;
    bit                      m_passed;

    virtual switch_interface m_vi;
    virtual switch_interface m_mi;

    function new(input virtual switch_interface vif,
                 input virtual switch_interface mif,
                 input string testcase_display_string);
        m_vi = vif;
        m_mi = mif;
        m_error_count = 0;
        m_passed = 0;
        m_testcase_display_string = testcase_display_string;

        m_drv2sb = new();
        m_mon2sb = new();
        m_sb     = new(m_drv2sb, m_mon2sb);
        m_drv    = new(vif, m_drv2sb);
        m_mon    = new(mif, m_mon2sb);
    endfunction


    task initialize_dut();

        // Reset the device under test:
        m_vi.cb.reset_156m25_n   <= 1'b0;
        m_vi.cb.reset_xgmii_rx_n <= 1'b0;
        m_vi.cb.reset_xgmii_tx_n <= 1'b0;
        WaitNS(20);
        m_vi.cb.reset_156m25_n   <= 1'b1;
        m_vi.cb.reset_xgmii_rx_n <= 1'b1;
        m_vi.cb.reset_xgmii_tx_n <= 1'b1;

        // Wait this long for the device to come out of reset and become usable:
        WaitNS(5000);
    endtask

    virtual task run(int num_packets, int verbosity_level, int debug_flags);
        // Do nothing. This method is meant to be overridden.
    endtask;

    task report_testcase_results();
        if (m_error_count == 0)
            $display("time: %0t %s case: PASS",
                     $time, m_testcase_display_string);
        else
            $display("time: %0t %s case: FAIL ************ %d errors",
                     $time, m_testcase_display_string, m_error_count);
    endtask

    task report_intermediate_results();
        if (m_passed)
            $display("time: %0t OK: Expected behavior for %s case.",
                     $time, m_testcase_display_string);
        else begin
            m_error_count++;
            $display("time: %0t ERROR ***** %s case ERROR",
                     $time, m_testcase_display_string);
        end
    endtask

endclass

