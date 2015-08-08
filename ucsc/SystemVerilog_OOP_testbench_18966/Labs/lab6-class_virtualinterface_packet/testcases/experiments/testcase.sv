`include "packet.sv"
`include "driver.sv"
`include "env.sv"

program testcase(interface tcif);

    class deadbeef_packet extends packet;
        constraint data {
            src_data == 32'hDEADBEEF;
        }
    endclass

    deadbeef_packet testcase_packet;
    env env0;
    int num_packets;

    initial begin

        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        env0 = new(tcif);
        testcase_packet = new();

        env0.drv.ethernet = testcase_packet;

        num_packets = $urandom_range(4, 32);
        env0.run(num_packets);

        #100 $finish;
    end

endprogram

