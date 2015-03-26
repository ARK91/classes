// File: test_equal_on_board.v
// Derived from Jag's (instructor's) equal_on_board.v module.
//
// John F. Hubbard, 26 Mar 2015
//

module test_equal_on_board(clk, btnU, seg, an, led);
    parameter NINPUTS = 32;
    parameter MAXERROR = 9;

    input clk, btnU;
    output [0:6] seg;
    output [3:0] an;
    output[15:0] led;

    wire done;
    reg [NINPUTS-1:0] inputs, i;
    wire o1, o2, o3;
    wire [15:0] packedHex;
    reg [3:0] error;

    always @(posedge clk or posedge btnU) begin
        if (btnU) begin
            inputs = 0;
            i = 0;
        end
        else if (done) begin
            i = i + 1;
            if (i % 10 == 0)
                inputs = ~(0);
            else
                inputs = i;
        end
    end

    always @(posedge clk)
    if (btnU)
        error = 0;
    else if (done)
        if (error < MAXERROR)
            if ( (o1 != o2) || (o1 != o3) || (o2 != o3) )
                error = error + 1;

    //o1(4), o2(4), o3(4), first(4)
    //0 or 1 0 or 1 <3 to 0> <2 to 0>
    assign packedHex = btnU ? 0 : ((inputs % 10) == 0) ? ~(0) :
                          {{3'b0, o1}, {3'b0,o2},{3'b0,o3}, error};
    //a,b,c,d,e
    //0 1 2 3 4
    andn_rtl U1(inputs, o1); //behaviour
    and32_struct_lut U2(inputs, o2);//Lut
    and32_struct_carrychain U3(inputs, o3);//Lut+carrychain

    display_packed_hex_for_n_seconds #(0.5) D(clk, btnU, seg, an,
                                              packedHex, done);
    assign led = inputs;
endmodule
