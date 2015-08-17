class monitor;

    mailbox                  m_mon2sb;
    virtual switch_interface m_mi;

    function new(input virtual switch_interface mif,
                 input mailbox mon2sb);
        m_mi = mif;
        m_mon2sb = mon2sb;
    endfunction

    task collect_packet();
        bit done;
        packet rcv_packet;
        rcv_packet = new();

        done <= 0;

        m_mi.cb.pkt_rx_ren <= 1'b1;
        @(posedge m_mi.cb);

        while (!done) begin
            if (m_mi.cb.pkt_rx_val) begin

                if (m_mi.cb.pkt_rx_sop) begin
                    $display("\n\n------------------------");
                    $display("Received Packet");
                    $display("------------------------");
                end

                rcv_packet.pkt_data <= m_mi.cb.pkt_rx_data;
                rcv_packet.print();
                m_mon2sb.put(rcv_packet);

                if (m_mi.cb.pkt_rx_eop) begin
                    done <= 1'b1;
                    m_mi.cb.pkt_rx_ren <= 1'b0;
                end

                if (m_mi.cb.pkt_rx_eop) begin
                    $display("------------------------\n\n");
                end
            end

            @(posedge m_mi.cb);
        end

    endtask
endclass
