// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

class packet;

    `define TX_BUFFER_LEN 10000

    // Signals that will be sent to RTL:
    rand bit [7:0]  pkt_buffer[`TX_BUFFER_LEN];
    rand integer    pkt_length;

    // Signals that are just for the test framework (not for RTL):
    static bit [15:0] m_packet_id;

    constraint legal_payload {
        pkt_length inside {[60:90]};
    }

    function new(integer requested_packet_id);
        m_packet_id = requested_packet_id;
    endfunction

    function zero_out_trailing_bytes();
        integer i;

        for (i = pkt_length; i < `TX_BUFFER_LEN; i++) begin
            pkt_buffer[i] = 0;
        end
    endfunction

    function void print(string extra_notes);
        integer i;

        $display("------------------- Packet ID: %0d (%s) -----------------------",
                 m_packet_id, extra_notes);

        $display("Length: %4d\n",pkt_length);

        for (i = 0; i < pkt_length; i = i + 16) begin
            $display("%h %h %h %h %h %h %h %h  |  %h %h %h %h %h %h %h %h",
                     pkt_buffer[i],
                     pkt_buffer[i+1],
                     pkt_buffer[i+2],
                     pkt_buffer[i+3],
                     pkt_buffer[i+4],
                     pkt_buffer[i+5],
                     pkt_buffer[i+6],
                     pkt_buffer[i+7],
                     pkt_buffer[i+8],
                     pkt_buffer[i+9],
                     pkt_buffer[i+10],
                     pkt_buffer[i+11],
                     pkt_buffer[i+12],
                     pkt_buffer[i+13],
                     pkt_buffer[i+14],
                     pkt_buffer[i+15]);
        end

        $display("------------------------------------------");
    endfunction
endclass

