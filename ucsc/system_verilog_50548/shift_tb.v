module shift_register_tb;
    bit clk;
    bit clear;
    logic qa, qb, qc, qd;
    logic datain;

// Generate 10ns clock
    always @(*) begin
   #5 clk = ~clk;
    end

    shift_register DUT(datain, clear, clk, qa,  qb, qc, qd);
// Apply Stimulus
  initial
    begin
      @(posedge clk) begin
            clear = 1'b1;
            datain = 1'b0;
      end

      @(negedge clk) 
       for(int i = 0; i < 16; i++) begin
          datain = ~datain;
          @(posedge clk) show();
       end
      $finish;
    end


  //Display results
  task show();
    $display("qa, qb, qc, qd: %b, %b, %b, %b", qa, qb, qc, qd);
  endtask

  // Check for timeout
  initial begin
      #2000ns $display ("TIMEOUT REACHED");
      $finish;
    end
endmodule
