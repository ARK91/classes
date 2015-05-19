`timescale 1ns/1ns

module packet_tb();
    class packet;

        typedef enum {
            UNICAST = 11,
            MULTICAST,
            BROADCAST,
            ETHERNET,
            IPV4,
            IPV6
        }frame_type;

        rand frame_type frameType;
        rand  bit [5:0] length;
        randc bit [3:0] ipg; // IPG: Inter-packet gap
        rand  bit [7:0] payload[];

        constraint length_rules {
            length >= 16;
            length <= 64;

            payload.size() >= 8;
            payload.size() <= 128;

            payload.size() == length;
        }

        constraint ipg_rules {
            ipg >= 4;
            ipg <= 12;
            ipg dist { 8:=80, [4:7]:/10, [9:12]:/10 };
        }

        function string get_frame_type();
            case (frameType) inside
                [UNICAST:IPV6]:
                    get_frame_type = frameType.name();
                default:
                    get_frame_type = "UNKNOWN TYPE";
            endcase

        endfunction

        task print();
            $display("length: %d, payload.size(): %d, ipg: %d, Frame type: %s, ",
                     length, payload.size(), ipg, get_frame_type());
        endtask
    endclass
    ////////////////////////////////////////////////////////////

    initial begin
        packet ethernet;
        int num_packets = $urandom_range(4, 16);
        ethernet = new();

        for (int i = 0; i < num_packets; ++i) begin
            #1;
             assert(ethernet.randomize());
             ethernet.print();
        end
    end

endmodule
