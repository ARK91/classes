class driver;

    mailbox                  m_drv2sb;
    virtual switch_interface m_vi;

    function new(input virtual switch_interface vif,
                 input mailbox drv2sb);
        m_vi = vif;
        m_drv2sb = drv2sb;
    endfunction

task local_wait_ns;
  input [31:0] delay;
    begin
        #(1000*delay);
    end
endtask

    task send_packet(integer tx_length, logic [7:0] tx_buffer);
        integer i;
        packet local_pkt;
        local_pkt = new();

        assert(local_pkt.randomize());

        @(m_vi.cb);
        local_wait_ns(1);
        m_vi.cb.pkt_tx_val <= 1'b1;

        for (i = 0; i < tx_length; i = i + 8) begin

            if (i == 0)
                m_vi.cb.pkt_tx_sop <= 1'b1;
            else
                m_vi.cb.pkt_tx_sop <= 1'b0;

            if (i + 8 >= tx_length) begin
                m_vi.cb.pkt_tx_eop <= 1'b1;
                m_vi.cb.pkt_tx_mod <= tx_length % 8;
            end
            else begin
                m_vi.cb.pkt_tx_eop <= 1'b0;
                m_vi.cb.pkt_tx_mod <= 2'b0;
            end

            m_vi.cb.pkt_tx_data[`LANE7] = tx_buffer[i];
            m_vi.cb.pkt_tx_data[`LANE6] = tx_buffer[i+1];
            m_vi.cb.pkt_tx_data[`LANE5] = tx_buffer[i+2];
            m_vi.cb.pkt_tx_data[`LANE4] = tx_buffer[i+3];
            m_vi.cb.pkt_tx_data[`LANE3] = tx_buffer[i+4];
            m_vi.cb.pkt_tx_data[`LANE2] = tx_buffer[i+5];
            m_vi.cb.pkt_tx_data[`LANE1] = tx_buffer[i+6];
            m_vi.cb.pkt_tx_data[`LANE0] = tx_buffer[i+7];

            @(posedge m_vi.cb);
            local_wait_ns(1);
        end

        m_vi.cb.pkt_tx_val <= 1'b0;
        m_vi.cb.pkt_tx_eop <= 1'b0;
        m_vi.cb.pkt_tx_mod <= 3'b0;

        local_pkt.print();
        m_drv2sb.put(local_pkt);
    endtask
endclass

