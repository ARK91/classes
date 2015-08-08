class driver;

    virtual switch_interface vi;

    function new(input virtual switch_interface vif);
        this.vi = vif;
    endfunction

    task send_packet();
        packet ethernet;
        ethernet = new();

        assert(ethernet.randomize());

        @(vi.cb)
            vi.cb.src_addr <= this.src_addr;

        repeat(6) @(vi.cb);
        vi.cb.src_data <= this.src_data;

        ethernet.print();
    endtask
endclass
