`timescale 1ns/1ns

module counter(input clk,
               counter_interface cif);

    always @ (posedge clk)
        if (cif.reset) begin
            cif.count <= {4{1'b0}};
        end else if (cif.enable) begin
            cif.count ++;
        end
endmodule

