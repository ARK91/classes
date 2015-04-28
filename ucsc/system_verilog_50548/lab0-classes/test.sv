program test;
  class packet;
     rand bit [15:0] preamble;
     rand bit [47:0] src_addr;
     rand bit [47:0] dst_addr;
  endclass 

  int num_packets; 
  packet ipv4;
  
  initial begin
      ipv4 = new();
  
      num_packets = $urandom_range(4, 16);
      for(int i=0; i<num_packets; i++) begin
      ipv4.randomize();

      `ifdef ENABLE_MESSAGE
         $display("Packet # %0d", i);
         $display("ipv4.preamble = %0h, ipv4.src_addr = %0h, ipv4.dst_addr=%0h\n", ipv4.preamble, ipv4.src_addr, ipv4.dst_addr);
      `endif
      end
   end

   initial begin
      `ifdef ENABLE_DUMP
         $vcdpluson();
      `endif
   end
endprogram
