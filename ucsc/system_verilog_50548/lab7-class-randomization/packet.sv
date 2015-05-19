// packet.sv
// John Hubbard, 18 May 2015
// SystemVerilog Essentials, lab7 homework

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

        bit parity;
        rand frame_type frameType;
        rand  bit [5:0] length;
        randc bit [3:0] ipg; // IPG: Inter-packet gap
        rand  bit [7:0] payload[];

        constraint length_rules {
            // Cannot do this, because this.payload.size() is not a random
            // variable (according to Riviera PRO):
            //solve length before payload.size();

            length >= 16;
            length <= 64;
            payload.size() == length;

            // These two lines are ignored, due to the previous line:
            payload.size() >= 8;
            payload.size() <= 128;
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

        task print(int packet_count);
            $display("packet_count: %d, length: %d, parity: %b, ipg: %d, ",
                     packet_count, length, parity, ipg,
                     "Frame type: %s, ",
                     get_frame_type());
        endtask

        function void pre_randomize();
            $display("PRE-RANDOMIZE()");
        endfunction

        function void post_randomize();
            int index;

            $display("POST-RANDOMIZE()");

            for (index = 0; index < length; index++)
                parity = parity ^ payload[index][0];
        endfunction

    endclass

    class constrained_packet extends packet;
        constraint ipg_rules{
            ipg == 5;
            (frameType == BROADCAST) || (frameType == IPV6);
        }
    endclass

    class color_packet extends packet;
        typedef enum {
            GREEN=22,
            YELLOW=18,
            RED=7,
            BLUE=0,
            BROWN=31,
            ORANGE=28
        } color_t;

        randc color_t color;

        constraint color_rules {
            color == YELLOW;
        }

        constraint ipg_rules {
            ipg == 7;
        }

        constraint other_rules {
            length == 17;
        }

        task print(int packet_count);
            super.print(packet_count);
            $display("Length: %d, ipg: %d, Color: %s",
                     length, ipg, color.name());
        endtask

    endclass
    ////////////////////////////////////////////////////////////

    initial begin
        // Randomization and constraints homework section (lab7)
        constrained_packet ethernet;
        color_packet yellow_packet;

        int num_packets = $urandom_range(4, 16);
        ethernet = new();

        for (int packet_count = 0; packet_count < num_packets;
             ++packet_count) begin
            #1;
             assert(ethernet.randomize());
             ethernet.print(packet_count);
        end

        // Inheritance homework section (lab7):
         yellow_packet = new();

         for (int packet_count = 0; packet_count < num_packets;
              ++packet_count) begin
            #1;
            assert(yellow_packet.randomize());
            yellow_packet.print(packet_count);
        end
    end

endmodule
