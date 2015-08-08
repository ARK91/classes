class driver;

    packet ethernet;
    virtual switch_interface vi;

    function new(input virtual switch_interface vif);
        this.vi = vif;
        ethernet = new();
    endfunction

    task send_packet();
        packet local_packet;
        local_packet = new();

        assert(local_packet.randomize());

        @(vi.cb)
            vi.cb.src_addr <= local_packet.src_addr;

        repeat(6) @(vi.cb);
        vi.cb.src_data <= local_packet.src_data;

        ethernet.print();
    endtask
endclass
