class packet;

    // Signals that will be sent to RTL:
    rand bit [47:0] src_addr;
    rand bit [31:0] src_data;

    reg           pkt_rx_ren;

    rand logic  [63:0]   pkt_tx_data;
    logic           pkt_tx_val;
    logic           pkt_tx_sop;
    logic           pkt_tx_eop;
    logic  [2:0]    pkt_tx_mod;

    integer       tx_count;
    integer       rx_count;

    // Signals that are just for the test framework (not for RTL):
    static bit [15:0] pktid;

    function new();
        pktid++;
    endfunction

    function void print();
        $display("pktid=%0d, src_addr=%h, src_data=%h",
                 pktid, src_addr, src_data);
    endfunction

//    task TxPacket();
//        integer        i;
//        begin
//            $display("Transmit packet with length: %d", tx_length);
//
//            @(posedge clk_156m25);
//            WaitNS(1);
//            pkt_tx_val = 1'b1;
//
//            for (i = 0; i < tx_length; i = i + 8) begin
//
//                pkt_tx_sop = 1'b0;
//                pkt_tx_eop = 1'b0;
//                pkt_tx_mod = 2'b0;
//
//                if (i == 0) pkt_tx_sop = 1'b1;
//
//                if (i + 8 >= tx_length) begin
//                    pkt_tx_eop = 1'b1;
//                    pkt_tx_mod = tx_length % 8;
//                end
//
//                pkt_tx_data[`LANE7] = tx_buffer[i];
//                pkt_tx_data[`LANE6] = tx_buffer[i+1];
//                pkt_tx_data[`LANE5] = tx_buffer[i+2];
//                pkt_tx_data[`LANE4] = tx_buffer[i+3];
//                pkt_tx_data[`LANE3] = tx_buffer[i+4];
//                pkt_tx_data[`LANE2] = tx_buffer[i+5];
//                pkt_tx_data[`LANE1] = tx_buffer[i+6];
//                pkt_tx_data[`LANE0] = tx_buffer[i+7];
//
//                @(posedge clk_156m25);
//                WaitNS(1);
//            end
//
//            pkt_tx_val = 1'b0;
//            pkt_tx_eop = 1'b0;
//            pkt_tx_mod = 3'b0;
//
//            tx_count = tx_count + 1;
//        end
//    endtask
//
//    task RxPacket();
//        reg done;
//        begin
//            done = 0;
//
//            pkt_rx_ren <= 1'b1;
//            @(posedge clk_156m25);
//
//            while (!done) begin
//                if (pkt_rx_val) begin
//
//                    if (pkt_rx_sop) begin
//                        $display("\n\n------------------------");
//                        $display("Received Packet");
//                        $display("------------------------");
//                    end
//
//                    $display("%x", pkt_rx_data);
//
//                    if (pkt_rx_eop) begin
//                        done <= 1;
//                        pkt_rx_ren <= 1'b0;
//                    end
//
//                    if (pkt_rx_eop) begin
//                        $display("------------------------\n\n");
//                    end
//                end
//
//                @(posedge clk_156m25);
//            end
//
//            rx_count = rx_count + 1;
//        end
//    endtask

endclass

