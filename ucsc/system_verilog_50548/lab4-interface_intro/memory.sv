`timescale 1ns/1ns

module memory(input  wire  clk,
              mem_if       bus_mem);

    // Memory array
    logic [7:0] mem [0:255];

    // Read logic
    always @ (posedge clk)
        if (bus_mem.reset)
            bus_mem.datao <= 0;
        else if (bus_mem.ce && !bus_mem.we)
            bus_mem.datao <= mem[bus_mem.addr];

    // Write Logic
    always @ (posedge clk)
        if (bus_mem.ce && bus_mem.we) begin
            mem[bus_mem.addr] <= bus_mem.datai;
        end

endmodule
