class packet;

    // Signals that will be sent to RTL:
    rand bit [47:0] src_addr;
    rand bit [31:0] src_data;

    // Signals that are just for the test framework (not for RTL):
    rand bit [15:0] pktid;

    virtual switch_interface vi;

    function new(input virtual switch_interface vif);
        this.vi = vif;
    endfunction

    function void print();
        $display("pktid=%0d, src_addr=%h, src_data=%h",
                 pktid, src_addr, src_data);
    endfunction
endclass
