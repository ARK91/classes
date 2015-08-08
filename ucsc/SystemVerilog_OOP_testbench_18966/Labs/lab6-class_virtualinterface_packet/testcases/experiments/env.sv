class env;
    driver drv;
    virtual switch_interface vi;

    function new(input virtual switch_interface vif);
        this.vi = vif;
        drv = new(vif);
    endfunction

    task run(int num_packets = 5);
        for (int i = 0; i < num_packets; i++) begin
            $display("Sending packet #%0d...\n", i + 1);
            drv.send_packet();
        end
    endtask
endclass

