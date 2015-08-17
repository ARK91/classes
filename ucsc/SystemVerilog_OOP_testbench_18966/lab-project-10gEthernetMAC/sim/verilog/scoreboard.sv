// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

class scoreboard;

    mailbox m_mbx_from_drv;
    mailbox m_mbx_from_mon;

    function new(input mailbox drv2sb, input mailbox mon2sb);
        m_mbx_from_drv = drv2sb;
        m_mbx_from_mon = mon2sb;
    endfunction

    task compare(input bit verbosity_level);
        bit error;
        integer i;
        packet pkt_from_drv;
        packet pkt_from_mon;

        if (verbosity_level > 1)
            $display("time %0t: About to get a packet from DRIVER mailbox. Number of mailbox entries: %0d",
                     $time, m_mbx_from_drv.num());

        m_mbx_from_drv.get(pkt_from_drv);

        if (verbosity_level > 1)
            $display("time %0t: About to get a packet from MONITOR mailbox. Number of mailbox entries: %0d",
                     $time, m_mbx_from_mon.num());

        m_mbx_from_mon.get(pkt_from_mon);

        for (i = 0; i < pkt_from_mon.pkt_length; i++) begin
            if (pkt_from_mon.tx_buffer[i] != pkt_from_drv.tx_buffer[i]) begin
                $display("time: %0t ERROR: Packet mismatch!", $time);
                $display("pkt_from_mon.tx_buffer[i]: %h, pkt_from_drv.tx_buffer[i]: %h",
                         pkt_from_mon.tx_buffer[i], pkt_from_drv.tx_buffer[i]);
                error++;
            end
        end

       if(pkt_from_mon.pkt_length != pkt_from_mon.pkt_length) begin
           $display("time: %0t ERROR: Packet length mismatch!", $time);
           error++;
       end

        if (error == 0)
            $display("time: %0t PASS: All packets passed", $time);
        else
            $display("time: %0t FAIL ***** FAIL", $time);

    endtask

endclass
