// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

task WaitPS;
  input [31:0] delay;
    begin
        #(delay);
    end
endtask

task WaitNS;
  input [31:0] delay;
    begin
        #(1000*delay);
    end
endtask

