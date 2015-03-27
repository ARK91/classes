// File: picoblaze_adder_project.v
//
// John F. Hubbard, 26 Mar 2015
//
// For problem 3 on page 389 of UCSC 20307: Digital Design with FPGA:
// Problem statement:
//
//  1. Start with a number,start, say 4.
//  2. Increment the number by a number, incr, say 20
//  3. Addition is done using microblaze
//  4. Display the number on the board at a time interval of 'n' second
//  Example 4,24,44,64 etc
//  5. Output the above results on LED's also
//  6. What happens after the sum > 255
//  7. Modify the code, both hardware and software code, to
//  handle 16 bits.
//
// Derived from sum.v (Copyright: Jagadeesh Vasudevamurthy)

module in_to_out(in,out);
    parameter IN = 8;
    parameter OUT = 16;
    input [IN-1:0] in;
    output [OUT-1:0] out;

    assign out = {8'b0,in};
endmodule

module sum(clk,sw, btnU, seg, an,led);
    input clk, btnU;
    input [15:0] sw; // 16 switches
    output [0:6] seg; //7 segments
    output [3:0] an; //4 anodes
    output [15:0] led; //16 leds

    wire[11:0] address;
    wire[17:0] instruction;
    wire [7:0] port_id, in_port, out_port;
    wire write_strobe;
    wire interrupt_ack;
    wire read_strobe;
    wire [6:0] seg_out;
    reg [7:0] out_port_reg;
    wire [7:0] num;
    wire [15:0] packedHex;
    wire done;

    embedded_kcpsm6 U(port_id,write_strobe,read_strobe,out_port,in_port,
                      interrupt,interrupt_ack,btnU,clk);

    in_to_out #(8,16) I(out_port_reg,num);
    binary2bcd #(16,16) M(num,packedHex);
    display_packed_hex_for_n_seconds #(1) D(clk, btnU, seg, an,
                                            packedHex, done);

    always @(posedge clk)
    begin
    if (write_strobe)
    begin
    out_port_reg = out_port; //Seg shows sum of 1+2+3+ ..+in_port
    end
    end
    //Although we have 16 switches, picoblaze is reading only 8 switches
    //So max input is : 11111111 = 255
    //So max output is (n *(n+1))/2 = (255*256)/2 == 32640
    //32640 is 111111110000000
    //As it is 8 bit 10000000 = 128
    //When 8 switches are ON, you see 128
    assign in_port = sw; //Read from sw
    assign led = in_port; //leds shows input value
endmodule
