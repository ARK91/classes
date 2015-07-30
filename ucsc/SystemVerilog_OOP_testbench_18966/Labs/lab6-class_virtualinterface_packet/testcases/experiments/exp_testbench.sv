`include "packet.sv"

module testbench();

    packet ethernet;
    bit    clk;

    // These are just for the testbench, to complete wiring up the switch
    // module:
    logic [47:0] dst_addr;
    logic [31:0] dst_data;

    always #10 clk = ~clk;

    switch_interface sif( .clk(clk) );

    initial begin
        // Enable waveform dumps for use by Synopsys DVE:
        $vcdpluson();

        ethernet = new(sif);

        for (int i = 0; i < 4; i++) begin
            assert(ethernet.randomize());

            ethernet.print();
        end

        #100 $finish;
    end

    switch switch0(.clk(clk),
                   .src_addr (sif.src_addr),
                   .src_data (sif.src_data),
                   .dst_addr (dst_addr),
                   .dst_data (dst_data));

endmodule
