module alu_tb;

import alu_package::*;

// Declaring the variables
    
   logic 	[7:0] 	op_A, op_B;
   myopcode_t 		opcode;
   logic 	[7:0] 	result;
   bit   		clk, rst_n;       

// Place instance of the ALU here and use:
   
   alu alu1 (.data_1	(op_A	),
             .data_2	(op_B	),
             .opcode	(opcode	),
             .alu_out	(result	),
             .clk	(clk	),
             .rst_n	(rst_n	)
            );

// Generate 10ns clock
   always #5 clk = ~clk;

// Apply Stimulus
  initial
    begin
       { opcode, op_B, op_A } = 19'h0_00_00;
      @(posedge clk)
       rst_n = 1'b1;
      @(negedge clk) 
       { opcode, op_B, op_A } = 19'h0_37_68; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h1_e4_dc; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h2_83_20; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h3_ac_98; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h4_d0_3b; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h5_88_c8; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h6_03_e8; @(posedge clk) show(); verify();
       { opcode, op_B, op_A } = 19'h7_f2_39; @(posedge clk) show(); verify();

       for(int i=0; i<4; i++) begin
          { opcode, op_B, op_A } = $urandom_range(19'h00000, 19'h7FFFF); @(posedge clk) show(); verify();
       end
      $finish;
    end


  //Display results
  task show();
   $display(" time = %4t ns opcode = %s operand_1 = %d operand_2 = %h result = %h" , $time, opcode.name(), op_A, op_B, result);
  endtask
 
    // Verify Response
  task verify() ;
     
      logic [7:0] expected_result;
 
     case (opcode)
       RST : expected_result = 8'h00;
       MOV : expected_result = op_A;
       NOT : expected_result = ~op_A;
       ADD : expected_result = op_A + op_B;
       AND : expected_result = op_A & op_B;
       XOR : expected_result = op_A ^ op_B;
       LSH : expected_result = op_A << 4;
       RSH : expected_result = op_A >> 4;
        default: expected_result = 8'h00;
    endcase
   
      if ( expected_result == result)
        $display("PASS");
      else
        $display("FAIL");   
 
  endtask

  //Checking for timeout
  initial begin
      #2000ns $display ("TIMEOUT REACHED" );
      $finish;
    end

  // To display the waveforms
     initial begin
       $vcdpluson();
     end   

 
endmodule
