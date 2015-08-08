class driver;

    packet ethernet;
    virtual switch_interface vi;

    function new(input virtual switch_interface vif);
        this.vi = vif;
        ethernet = new();
    endfunction

    task send_packet();
        packet local_packet;
        // Make a local copy of the member variable:
        local_packet = new ethernet;

        assert(local_packet.randomize());

        @(vi.cb)
            vi.cb.src_addr <= local_packet.src_addr;

        repeat(6) @(vi.cb);
        vi.cb.src_data <= local_packet.src_data;

        local_packet.print();
    endtask
endclass
