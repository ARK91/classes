interface mem_if();

   wire         reset;
   wire         we;
   wire         ce;
   wire   [7:0] datai;
   logic  [7:0] datao;
   wire   [7:0] addr;

endinterface

