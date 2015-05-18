`timescale 1ns/1ns

module packet_tb();
    class packet;
        rand bit [7:0] src;
        rand bit [7:0] dst;
        rand bit [15:0] pktid;
        randc bit [1:0] pri;

        task print();
            @* begin
                $display("src: %d, dst: %d, pktid: %d, pri: %d",
                         src, dst, pktid, pri);
            end
        endtask

        function void post_randomize();
            $display("src: %d, dst: %d, pktid: %d, pri: %d",
                     src, dst, pktid, pri);
        endfunction
    endclass

    initial begin
        $display("Hello world 1");
        packet onePacket;

        for (int i = 0; i < 8; ++i) begin
            #1;
             onePacket = new();
             onePacket.print();
             $display("Hello world");
        end
    end

endmodule
