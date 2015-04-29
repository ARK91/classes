module counter(input clk,
               input logic reset,
               input logic enable,
               output logic [3:0] count
               );

  always @ (posedge clk)
    if (reset) begin
       count <= {4{1'b0}};
    end else if (enable) begin
       count ++;
    end
endmodule

