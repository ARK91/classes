class scoreboard;

    mailbox m_mbx_from_drv;
    mailbox m_mbx_from_mon;

    function new(input mailbox drv2sb, input mailbox mon2sb);
        m_mbx_from_drv = drv2sb;
        m_mbx_from_mon = mon2sb;
    endfunction

    task compare();
        bit error;
        packet pkt_from_drv;
        packet pkt_from_mon;

        $display("time %0t: About to get a packet from DRIVER mailbox. Number of mailbox entries: %0d",
                 $time, m_mbx_from_drv.num());
        m_mbx_from_drv.get(pkt_from_drv);
        $write("pkt_from_drv:");
        pkt_from_drv.print();

        $display("time %0t: About to get a packet from MONITOR mailbox. Number of mailbox entries: %0d",
                 $time, m_mbx_from_mon.num());
        m_mbx_from_mon.get(pkt_from_mon);
        $write("pkt_from_mon:");
        pkt_from_mon.print();

        if ((pkt_from_mon.src_addr != pkt_from_drv.src_addr + 1) ||
            (pkt_from_mon.src_data != pkt_from_drv.src_data + 1)) begin
                $display("time: %0t ERROR: Packet mismatch!", $time);
                error++;
        end

        if (error == 0)
            $display("time: %0t PASS: Packet matches", $time);
    endtask

endclass
