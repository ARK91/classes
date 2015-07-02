module testbench();

    parameter WIDTH = 32;
    logic clk, reset, enable, preload, mode, detect;
    logic   [WIDTH-1:0]  preload_data;
    logic   [WIDTH-1:0]  result;

    counter #(WIDTH) DUT(.*);

    initial begin
        $monitor("t=%3t: result=%2d, detect=%b", $time, result, detect);

        reset = 1;
        enable = 0;
        preload = 0;
        mode = 0;

        @(posedge clk)
            reset = 0;

        @(posedge clk);
        enable = 1;

        repeat (10) @(posedge clk);
        enable = 0;

        repeat (10) @(posedge clk) $finish;
    end

endmodule
