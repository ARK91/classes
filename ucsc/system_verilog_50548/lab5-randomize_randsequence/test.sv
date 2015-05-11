module test();
    int numPackets;

    task gen_packet();
    // insert you randsequence code here
        randsequence()
            TRAFFIC:            PACKET_TYPE PACKET_GAP PACKET_PRIORITY;
            PACKET_TYPE:        ETHERNET IPV4 IPV6;
            PACKET_GAP:         LARGE_GAP NORMAL_GAP SMALL_GAP;
            PACKET_PRIORITY:    PREMIUM ELITE PLATINUM;

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
