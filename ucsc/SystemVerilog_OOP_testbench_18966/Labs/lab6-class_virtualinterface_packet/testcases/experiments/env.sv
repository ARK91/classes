class env;
    driver drv;
    monitor mon;

    virtual switch_interface vi;
    virtual switch_interface mi;

    function new(input virtual switch_interface vif,
                 input virtual switch_interface mif);
        this.vi = vif;
        this.mi = mif;

        drv = new(vif);
        mon = new(mif);
    endfunction

    task run(int num_packets = 5);
        for (int i = 0; i < num_packets; i++) begin
            $display("Sending packet #%0d...", i + 1);
            drv.send_packet();

            @(posedge mi.clk)
                $display("Collecting packet #%0d...", i+1);

            mon.collect_packet();
        end
    endtask
endclass

