module test();
   reg [2:0] state;

   enum logic [2:0] {XMII=0, SGMII=1, RMII=2} protocol;

   typedef enum logic [2:0] {ONE=1, THREE=3, FIVE=5} oddnumber_t;
   oddnumber_t mynumber;

   initial begin
      state = 3'b101;
      protocol = SGMII; 

      $display("state=%b", state);
      $display("protocol=%b", protocol);
      $display("protocol=%s", protocol.name());
      $display("mynumber=%d", mynumber.first()); 

      mynumber = 3;
      $display("mynumber=%d", mynumber); 

      mynumber = 4;
      $display("mynumber=%d", mynumber); 
   end
endmodule
