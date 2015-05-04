module memory_tb();
logic       reset,ce,we;
logic [7:0] datai,addr;
wire  [7:0] datao;
int         numAccess;

logic clk = 0;
always #10 clk = ~clk;

memory DUT(clk, reset, we, ce, datai, datao, addr);

//=================================================
// Instianciate Interface and DUT 
//=================================================

  // instantiate the design "memory" and make
  // the hook ups and connectivity here
  // Pay special attention to "ports" and "signals"


//=================================================
// Test Vector generation
//=================================================
initial begin
  reset = 1;
  ce = 1'b0;
  we = 1'b0;
  addr = 0;
  datai = 0;
  repeat (10) @ (posedge clk);
  reset = 0;

  //Specify number of Write and Read operations
  numAccess = $urandom_range(8, 16);

  //Write Access
  $display ("========== Writing to Memory==========");
  for (int i = 0; i < numAccess; i ++ ) begin
    @ (posedge clk) ce = 1'b1;
    we = 1'b1;
    addr = i;
    datai = $urandom_range(8'h00, 8'hff);
    @ (posedge clk) ce = 1'b0;
    $display ("%0dns: Write access address %0h, data %0h", $time,addr, datai);
  end

  //Read Access
  $display ("========== Reading from Memory==========");
  for (int i = 0; i < numAccess; i ++ ) begin
    @ (posedge clk) ce = 1'b1;
    we = 1'b0;
    addr = i;
    repeat (2) @ (posedge clk);
    ce = 1'b0;
    $display ("%0dns: Read access address %0h, data %0h", $time,addr, datao);
  end
  #10 $finish;
end

endmodule
