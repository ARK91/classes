`timescale 1ns/1ns

module counter_test(input clk,
                    counter_interface cif);

    int count_delay;

    //=================================================
    // Generate the test vector
    //=================================================
    initial begin
        // Fork of the monitor
        fork
            cif.monitor();
            join_none

        cif.reset = 1;
        cif.enable = 0;
        #10 cif.reset = 0;
        #1 cif.enable = 1;

        //Disable counter
        count_delay = $urandom_range(150, 350);
        #count_delay cif.enable = 0;

        #5 $finish;
    end

endmodule
