// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

class monitor;

    mailbox                  m_mon2sb;
    virtual switch_interface m_mi;

    function new(input virtual switch_interface mif,
                 input mailbox mon2sb);
        m_mi = mif;
        m_mon2sb = mon2sb;
        m_mi.cb.pkt_rx_ren <= 1'b0;
    endfunction

    task collect_packet(integer expected_packet_id);
        bit done;
        integer byte_index;
        packet rcv_packet;
        rcv_packet = new(expected_packet_id);

        done       = 0;
        byte_index = 0;

        // Wait for the device to indicate that a packet has arrived:
        while(!m_mi.cb.pkt_rx_avail)
            @(posedge m_mi.clk);

        m_mi.cb.pkt_rx_ren <= 1'b1;
        @(posedge m_mi.clk);

        while (!done) begin
            if (m_mi.cb.pkt_rx_val) begin

                rcv_packet.tx_buffer[byte_index+0] <= m_mi.cb.pkt_rx_data[`LANE7];
                rcv_packet.tx_buffer[byte_index+1] <= m_mi.cb.pkt_rx_data[`LANE6];
                rcv_packet.tx_buffer[byte_index+2] <= m_mi.cb.pkt_rx_data[`LANE5];
                rcv_packet.tx_buffer[byte_index+3] <= m_mi.cb.pkt_rx_data[`LANE4];
                rcv_packet.tx_buffer[byte_index+4] <= m_mi.cb.pkt_rx_data[`LANE3];
                rcv_packet.tx_buffer[byte_index+5] <= m_mi.cb.pkt_rx_data[`LANE2];
                rcv_packet.tx_buffer[byte_index+6] <= m_mi.cb.pkt_rx_data[`LANE1];
                rcv_packet.tx_buffer[byte_index+7] <= m_mi.cb.pkt_rx_data[`LANE0];

                if (m_mi.cb.pkt_rx_eop) begin
                    m_mi.cb.pkt_rx_ren <= 1'b0;

                    done = 1;
                    // Take care of not-a-multiple-of-8 bytes:
                    if(m_mi.cb.pkt_rx_mod == 0)
                        rcv_packet.pkt_length = byte_index + 8;
                    else
                        rcv_packet.pkt_length = byte_index + m_mi.cb.pkt_rx_mod;
                end

                // Only increment the byte counter while the pkt_rx_val is set:
                byte_index = byte_index + 8;
            end

            @(posedge m_mi.clk);
        end

        // Send the packet to the scoreboard, and also print it:
        rcv_packet.zero_out_trailing_bytes();
        m_mon2sb.put(rcv_packet);
        rcv_packet.print("Received");

    endtask
endclass

