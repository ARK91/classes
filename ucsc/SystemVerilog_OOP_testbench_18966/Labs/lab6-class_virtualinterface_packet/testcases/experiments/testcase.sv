`include "packet.sv"
`include "driver.sv"
`include "env.sv"

program testcase(interface tcif);

    env env0;
    int num_packets;

    initial begin

        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        env0 = new(tcif);
        num_packets = $urandom_range(4, 32);
        env0.run(num_packets);

        #100 $finish;
    end

endprogram

