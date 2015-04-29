`timescale 1ns / 1ns

module shift_register(input datain,
                      input clear,
                      input clk,
                      output logic [0:0] qa,
                      output logic [0:0] qb,
                      output logic [0:0] qc,
                      output logic [0:0] qd);

  logic [0:0]Da;
  logic [0:0]Db;
  logic [0:0]Dc;
  logic [0:0]Dd;

//output logic [0:0]qa;
//output logic [0:0]qb;
//output logic [0:0]qc;
//output logic [0:0]qd;

  always_ff @(posedge clk) begin
    if (clear) begin
      Da = 1'b0;
      Db = 1'b0;
      Dc = 1'b0;
      Dd = 1'b0;
    end
    else begin
      Da <= datain;
      Db <= Da;
      Dc <= Db;
      Dd <= Dc;

      qa <= Da;
      qb <= Db;
      qc <= Dc;
      qd <= Dd;
    end

  end

endmodule
