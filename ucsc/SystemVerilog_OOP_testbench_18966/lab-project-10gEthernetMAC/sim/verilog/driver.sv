class driver;

    mailbox                  m_drv2sb;
    virtual switch_interface m_vi;

    function new(input virtual switch_interface vif,
                 input mailbox drv2sb);
        m_vi = vif;
        m_drv2sb = drv2sb;
    endfunction

    task send_packet();
        packet local_pkt;
        local_pkt = new();

        assert(local_pkt.randomize());

        @(m_vi.cb)
            m_vi.cb.src_addr <= local_pkt.src_addr;

        repeat(6) @(m_vi.cb);
        m_vi.cb.src_data <= local_pkt.src_data;

        local_pkt.print();
        m_drv2sb.put(local_pkt);
    endtask
endclass
