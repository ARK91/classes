class packet;

    // Signals that will be sent to RTL:
    rand bit [7:0]  tx_buffer[128];
    rand integer    pkt_length;

    // Signals that are just for the test framework (not for RTL):
    static bit [15:0] m_packet_id;

    constraint legal_payload {
        pkt_length inside {[46:128]};
    }

    function new(integer requested_packet_id);
        m_packet_id = requested_packet_id;
    endfunction
    function void print(string extra_notes);
        $display("------------------- Packet ID: %0d (%s) -----------------------",
                 m_packet_id, extra_notes);

        $display("Length: %4d\n",pkt_length);

        for (i = 0; i < pkt_length; i++) begin
            $display("%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h",
                     tx_buffer[i],
                     tx_buffer[i+1],
                     tx_buffer[i+2],
                     tx_buffer[i+3],
                     tx_buffer[i+4],
                     tx_buffer[i+5],
                     tx_buffer[i+6],
                     tx_buffer[i+7]);
                     tx_buffer[i+8],
                     tx_buffer[i+9],
                     tx_buffer[i+10],
                     tx_buffer[i+11],
                     tx_buffer[i+12],
                     tx_buffer[i+13],
                     tx_buffer[i+14],
                     tx_buffer[i+15]);
        end

        $display("------------------------------------------");
    endfunction
endclass

