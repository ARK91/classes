`timescale 1ns / 1ns

module alu (output logic [7:0] alu_out,
            input         clk,
            input         rst_n,
            input   [7:0] data_1,            
            input   [7:0] data_2,            
            input   [2:0] opcode);

    typedef enum logic [2:0] {
    RST,
        MOV,
        NOT,
        ADD,
        AND,
        XOR,
        LSH,
        RSH
    } myopcode_t;

    always_ff @(posedge clk or negedge rst_n)
      if (!rst_n)
        alu_out <= 8'h00;
      else
         unique case (opcode)
           RST : alu_out <= 8'h00;
           MOV : alu_out <= data_1;
           NOT : alu_out <= ~data_1;
           ADD : alu_out <= data_1 + data_2;
           AND : alu_out <= data_1 & data_2;
           XOR : alu_out <= data_1 ^ data_2;
           LSH : alu_out <= data_1 << 4;
           RSH : alu_out <= data_1 >> 4;
           default: alu_out <= 8'h00;
        endcase

endmodule
