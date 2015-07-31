`include "packet.sv"

program testcase(interface tcif);
    packet ethernet;

    initial begin

        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        for (int i = 0; i < 4; i++) begin
            ethernet = new(tcif);
            assert(ethernet.randomize() with {src_data == 32'hDEADBEEF;} );
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

