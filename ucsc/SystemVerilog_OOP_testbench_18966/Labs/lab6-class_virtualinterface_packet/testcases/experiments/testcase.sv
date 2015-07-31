`include "packet.sv"

program testcase(interface tcif);
    packet ethernet;

    initial begin

        for (int i = 0; i < 4; i++) begin
            ethernet = new(sif);
            assert(ethernet.randomize());
            ethernet.send_packet();
            ethernet.print();
        end

        #100 $finish;
    end

    final begin
        $display("-------------------- End of Simulation (JH) --------------");
        $display("# of packets sent is: ???");
    end

endprogram

