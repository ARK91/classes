`timescale 1ns/10ps

module statemachine(clk, in, reset, out);

   input clk, in, reset;
   output [3:0] out;

   reg [3:0] out;
   reg [1:0] state;

   `define IDLE		0
   `define ACTIVE	1
   `define READY 	2
   `define DONE		3

   always @(state)
      begin
          case(state)
              `IDLE:   out = 4'b0000;
            `ACTIVE:   out = 4'b0001;
             `READY:   out = 4'b0010;
              `DONE:   out = 4'b0100;
            default:   out = 4'b0000;
          endcase
       end
endmodule
