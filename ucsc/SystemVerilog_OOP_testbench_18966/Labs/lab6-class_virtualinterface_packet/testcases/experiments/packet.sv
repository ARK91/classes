class packet;
    rand bit [47:0] src_addr;
    rand bit [31:0] src_data;

    virtual switch_interface vi;

    function new(input virtual switch_interface vif);
        this.vi = vif;
    endfunction

endclass
