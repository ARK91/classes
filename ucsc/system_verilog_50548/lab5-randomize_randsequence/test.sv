module test();
    int numPackets;

    task gen_packet();
    // insert you randsequence code here
        randsequence()
            TRAFFIC:            PACKET_TYPE  PACKET_GAP  PACKET_PRIORITY;
            PACKET_TYPE:        ETHERNET:=15 | IPV4:=35 | IPV6:=50;
            PACKET_GAP:         LARGE_GAP:=5 | NORMAL_GAP:=60 | SMALL_GAP:=35;
            PACKET_PRIORITY:    PREMIUM:=25 | ELITE:=25 | PLATINUM:=50;

            ETHERNET:   { $display("ETHERNET"); };
            IPV4:       { $display("IPV4"); };
            IPV6:       { $display("IPV6"); };

            LARGE_GAP:  { $display("LARGE_GAP"); };
            NORMAL_GAP: { $display("NORMAL_GAP"); };
            SMALL_GAP:  { $display("SMALL_GAP"); };

            PREMIUM:    { $display("PREMIUM SERVICE"); };
            ELITE:      { $display("ELITE SERVICE"); };
            PLATINUM:   { $display("PLATINUM SERVICE"); };
        endsequence
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
