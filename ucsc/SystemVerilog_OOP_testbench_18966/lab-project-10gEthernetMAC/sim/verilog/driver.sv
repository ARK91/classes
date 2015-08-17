class driver;

    mailbox                  m_drv2sb;
    virtual switch_interface m_vi;

    function new(input virtual switch_interface vif,
                 input mailbox drv2sb);
        m_vi = vif;
        m_drv2sb = drv2sb;
    endfunction

    task send_packet();
        packet ethernet;
        ethernet = new();

        assert(ethernet.randomize());

        @(m_vi.cb)
            m_vi.cb.src_addr <= ethernet.src_addr;

        repeat(6) @(m_vi.cb);
        m_vi.cb.src_data <= ethernet.src_data;

        ethernet.print();
        m_drv2sb.put(ethernet);
    endtask
endclass
