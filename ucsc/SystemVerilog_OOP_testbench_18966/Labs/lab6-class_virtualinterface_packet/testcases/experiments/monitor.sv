class monitor;

    mailbox                  m_mon2sb;
    virtual switch_interface m_mi;

    function new(input virtual switch_interface mif,
                 input mailbox mon2sb);
        m_mi = mif;
        m_mon2sb = mon2sb;
    endfunction

    task collect_packet();
        packet rcv_packet;
        rcv_packet = new();

        @(posedge m_mi.clk) begin
            // Note the crossed wires: dst --> src:
            rcv_packet.src_addr = m_mi.dst_addr;
            rcv_packet.src_data = m_mi.dst_data;
        end

        rcv_packet.print();
        m_mon2sb.put(rcv_packet);
    endtask
endclass
