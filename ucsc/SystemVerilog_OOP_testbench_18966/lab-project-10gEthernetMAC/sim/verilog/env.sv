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

    virtual switch_interface m_vi;
    virtual switch_interface m_mi;

    function new(input virtual switch_interface vif,
                 input virtual switch_interface mif);
        m_vi = vif;
        m_mi = mif;

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

        initialize_dut();

        for (int i = 0; i < num_packets; i++) begin

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: Sending packet #%0d =================",
                         $time, i);

            m_drv.send_packet(i, debug_flags);

            if (verbosity_level > `VERBOSITY_SILENT)
                $display("==== time=%0t: Collecting packet #%0d ==============",
                         $time, i);

            m_mon.collect_packet(i, debug_flags);

            if (verbosity_level > 0)
                $display("==== time=%0t: Comparing packet #%0d ===============",
                         $time, i);

            m_sb.compare(verbosity_level);

        end
    endtask
endclass

