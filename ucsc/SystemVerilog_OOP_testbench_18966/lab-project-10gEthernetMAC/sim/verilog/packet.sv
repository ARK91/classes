class packet;

    // Signals that will be sent to RTL:
    rand bit [47:0] src_addr;
    rand bit [31:0] src_data;

    // Signals that are just for the test framework (not for RTL):
    static bit [15:0] pktid;

    function new();
        pktid++;
    endfunction

    function void print();
        $display("pktid=%0d, src_addr=%h, src_data=%h",
                 pktid, src_addr, src_data);
    endfunction

endclass
