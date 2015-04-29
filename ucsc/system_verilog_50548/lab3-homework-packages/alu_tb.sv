module alu_tb;

// Using new datatypes, define the alu variables used in the testbench:
   //Declare variables here
   //op_A, op_B;
   //opcode;
   //result;
   //clk, rst_n;       

// Place instance of the ALU here and use:
  alu DUT(alu_out, clk, rst_n, data_1, data_2, opcode);

// Generate 10ns clock
    always_comb
        #5 clk = ~clk;

// Apply Stimulus
  initial
    begin
       { opcode, op_B, op_A } = 19'h0_00_00;
      @(posedge clk)
       rst_n = 1'b1;
      @(negedge clk) 
       { opcode, op_B, op_A } = 19'h0_37_68; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h1_e4_dc; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h2_83_20; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h3_ac_98; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h4_d0_3b; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h5_88_c8; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h6_03_e8; @(posedge clk) show();
       { opcode, op_B, op_A } = 19'h7_f2_39; @(posedge clk) show();

       for(int i=0; i<4; i++) begin
          { opcode, op_B, op_A } = $urandom_range(19'h00000, 19'h7FFFF); @(posedge clk) show();
       end
      $finish;
    end


  //Display results
  task show();
    //<insert code here>
  endtask

  // Verify Response
  /*task verify(...) ;
    begin
      // if ALU alu output is different from expected output, print FAILED
      // otherwise, print PASS
    end
  endtask*/

  //Checking for timeout
  initial begin
      #2000ns $display ("TIMEOUT REACHED" );
      $finish;
    end
endmodule
