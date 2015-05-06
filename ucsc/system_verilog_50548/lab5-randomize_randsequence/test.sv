module test();
   int numPackets;

   task gen_packet();
	// insert you randsequence code here
   endtask


   initial begin
     #10 numPackets = $urandom_range(16, 32);
         for(int i=0; i< numPackets ; i++) begin
             $write("Packet ID %0d : ", i);
             gen_packet(); 
             $display("\n");
         end
          
   end

endmodule
