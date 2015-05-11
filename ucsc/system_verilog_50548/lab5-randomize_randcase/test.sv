module test();
    int numPackets;

    task gen_error_packets();
        randsequence()
            CATEGORY:       OVERSIZE | UNDERSIZE;
            UNDERSIZE:      LESSTHAN_64BYTES:=4382 | ZERO_BYTES:=5618;
            OVERSIZE:       OVER_1500BYTES:=329 | OVER_10KBYTES:=671;

            OVER_1500BYTES:     { $display("OVER_1500BYTES"); };
            OVER_10KBYTES:      { $display("OVER_10KBYTES"); };
            LESSTHAN_64BYTES:   { $display("LESSTHAN_64BYTES"); };
            ZERO_BYTES:         { $display("ZERO_BYTES"); };
        endsequence
    endtask

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

            randcase
                1: gen_error_packets();
                1: gen_packet();
            endcase

            $display("\n");
        end
    end

endmodule
