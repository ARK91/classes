class packet;

    // Signals that will be sent to RTL:
    rand bit [63:0] pkt_data;

    // Signals that are just for the test framework (not for RTL):
    static bit [15:0] pktid;

    function new();
        pktid++;
    endfunction

    function void print();
        $display("pktid=%0d, pkt_data=%h",
                 pktid, pkt_data);
    endfunction
endclass

