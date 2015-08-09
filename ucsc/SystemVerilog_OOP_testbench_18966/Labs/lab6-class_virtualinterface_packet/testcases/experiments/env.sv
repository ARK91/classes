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
        m_sb = new(m_drv2sb, m_mon2sb);
        m_drv = new(vif, m_drv2sb);
        m_mon = new(mif, m_drv2sb);
    endfunction

    task run(int num_packets = 5);
        for (int i = 0; i < num_packets; i++) begin
            $display("======================== time=%0t: Sending packet #%0d ===========================",
                     $time, i + 1);
            m_drv.send_packet();

            $display("======================== time=%0t: Collecting packet #%0d ===========================",
                     $time, i + 1);

            m_mon.collect_packet();

            $display("======================== time=%0t: Comparing packet #%0d ===========================",
                     $time, i + 1);
            m_sb.compare();
        end
    endtask
endclass

