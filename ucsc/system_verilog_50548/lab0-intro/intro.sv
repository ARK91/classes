module intro();

   string course = "SystemVerilog IEEE-1800";

   initial $display("======Welcome to UC Santa Cruz Extension======");

   initial begin
      $display("Welcome to %s", course);

      $display("This is John F. Hubbard, hi there!");
   end
endmodule
