class monitor;

    virtual switch_interface mi;

    function new(input virtual switch_interface mif);
        this.mi = mif;
    endfunction

    task collect_packet();
        packet rcv_packet;
        rcv_packet = new();

        @(posedge mi.clk) begin
            // Note the crossed wires: dst --> src:
            rcv_packet.src_addr = mi.dst_addr;
            rcv_packet.src_data = mi.dst_data;
        end

        rcv_packet.print();

    endtask
endclass
